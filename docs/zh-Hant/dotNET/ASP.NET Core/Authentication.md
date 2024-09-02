# Authentication

## Common

### 設定配置檔

```csharp
app.UseAuthentication();
app.UseAuthorization();
```

### API 控制器

```csharp
[Route("api/[controller]")]
[ApiController]
[AllowAnonymous]
public class AuthController : ControllerBase
{
    [HttpGet("Login")]
    public IActionResult NoLogin()
    {
        return Ok("沒有登錄");
    }

    [HttpGet("NoAccess")]
    public IActionResult NoAccess()
    {
        return Ok("沒有權限");
    }
}
```

### 讓所有 API 都需要驗證

```csharp
builder.Services.AddControllers()
    .AddMvcOptions(options =>
    {
        options.Filters.Add(new AuthorizeFilter());
    });
```

### 讓特定 API 不需要驗證

```csharp
[AllowAnonymous]
public class AccountController : ControllerBase
{
    ...
}
```

### 讓特定 API 需要特定角色

```csharp
[Authorize(Roles = "admin")]
public class AccountController : ControllerBase
{
    ...
}
```

### 取得當前使用者資訊

```csharp
services.AddHttpContextAccessor();
```

```csharp
public class AccountController : ControllerBase
{
    ...
    public void GetCurrentUser()
    {
        var currentClaims = _httpContextAccessor.HttpContext.User.Claims;
        var currentEmployeeId = Guid.Parse(currentClaims.FirstOrDefault(c => c.Type == nameof(Employee.EmployeeId))?.Value);
    }
}
```

## Cookie Authentication

### 設定配置檔

`CookieAuthenticationDefaults` 是 ASP.NET Core 內建的 Cookie 認證的常數。

```csharp
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(CookieAuthenticationDefaults.AuthenticationScheme, options =>
    {
        options.LoginPath = "/api/account/login";
        options.LogoutPath = "/api/account/logout";
        options.AccessDeniedPath = "/api/account/noaccess";
        options.ExpireTimeSpan = TimeSpan.FromMinutes(5);
    });

```

### API 控制器

```csharp
[Route("api/[controller]")]
[ApiController]
[AllowAnonymous]
public class CookieAuthController : ControllerBase
{
    private readonly TodoContext _todoContext;

    public CookieAuthController(TodoContext todoContext)
    {
        _todoContext = todoContext;
    }

    [HttpPost("Login")]
    public async Task<IActionResult> Post([FromBody] LoginDto value)
    {
        // TODO: 驗證帳號密碼
        var user = _todoContext.Employees
            .Where(e => e.Account == value.UserName && e.Password == value.Password)
            .SingleOrDefault();

        if (user is null)
        {
            return BadRequest("帳號密碼錯誤");
        }
        else
        {
            List<Claim> claims =
            [
                new(ClaimTypes.Name, user.Account),
                new(ClaimTypes.Name, user.Name),
                new(nameof(Employee.EmployeeId), user.EmployeeId.ToString()),
            ];

            var roles = _todoContext.Roles.Where(e => e.EmployeeId == user.EmployeeId).Select(e => e.Name).ToList();

            foreach (var role in roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role));
            }

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, claimsPrincipal);

            return Ok("登入成功");
        }
    }

    [HttpGet("Logout")]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return Ok("登出成功");
    }
}
```

## JWT Authentication

### 設定配置檔

`JwtBearerDefaults` 是 ASP.NET Core 內建的 JWT 認證的常數。

```csharp
builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters()
        {
            ValidateIssuer = true, // 驗證發行者
            ValidIssuer = configuration["Jwt:Issuer"],
            ValidateAudience = true, // 驗證接收者
            ValidAudience = configuration["Jwt:Audience"],
            ValidateLifetime = true, // 驗證生命週期
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"])),
            ClockSkew = TimeSpan.Zero, // 時間偏移量
        };
    });
```

### API 控制器

```csharp
[Route("api/[controller]")]
[ApiController]
[AllowAnonymous]
public class JWTAuthController : ControllerBase
{
    private readonly TodoContext _todoContext;
    private readonly IConfiguration _configuration;

    public JWTAuthController(TodoContext todoContext, IConfiguration configuration)
    {
        _todoContext = todoContext;
        _configuration = configuration;
    }

    [HttpPost("Login")]
    public IActionResult Post([FromBody] LoginDto value)
    {
        // TODO: 驗證帳號密碼
        var user = _todoContext.Employees
            .Where(e => e.Account == value.UserName && e.Password == value.Password)
            .SingleOrDefault();

        if (user is null)
        {
            return BadRequest("帳號密碼錯誤");
        }
        else
        {
            List<Claim> claims =
            [
                new(JwtRegisteredClaimNames.Email, user.Account),
                new(ClaimTypes.Name, user.Name),
                new(nameof(Employee.EmployeeId), user.EmployeeId.ToString()),
            ];

            var roles = _todoContext.Roles.Where(e => e.EmployeeId == user.EmployeeId).Select(e => e.Name).ToList();

            foreach (var role in roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role));
            }

            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));

            var securityToken = new JwtSecurityToken
                (
                    issuer: _configuration["Jwt:Issuer"],
                    audience: _configuration["Jwt:Audience"],
                    claims: claims,
                    expires: DateTime.Now.AddMinutes(30),
                    signingCredentials: new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256)
                );

            var token = new JwtSecurityTokenHandler().WriteToken(securityToken);

            return Ok(token);
        }
    }
}
```
