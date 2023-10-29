# Security

## Json Web Token

### Generate Json Web Token

```csharp
var email = "email"; // replace user identity here.
var key = "key"; // key is the secret key.
var sub = "sub"; // sub means subject.
var iss = "iss"; // iss means issuer.
var aud = "aud"; // aud means audience.

var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key));
var signingCredentials = new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256);
var expires = DateTime.UtcNow.AddMinutes(10);

var claims = new Claim[]
{
    new Claim(ClaimTypes.Email, email),
    new Claim(JwtRegisteredClaimNames.Sub, sub),
    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
    new Claim(JwtRegisteredClaimNames.Iat, new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds().ToString()),
};

var jwtSecurityToken = new JwtSecurityToken(
    iss,
    aud,
    claims,
    expires: expires,
    signingCredentials: signingCredentials);

var token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
```

### Json Web Token in ASP.NET Core

```csharp
var key = "key"; // key is the secret key.
var iss = "iss"; // iss means issuer.
var aud = "aud"; // aud means audience.

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
    .AddJwtBearer(options =>
    {
        options.RequireHttpsMetadata = false;
        options.SaveToken = true;
        options.TokenValidationParameters = new TokenValidationParameters()
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidAlgorithms = new[] { SecurityAlgorithms.HmacSha256 },
            ValidAudience = aud,
            ValidIssuer = iss,
            IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(key))
        };
        options.Events = new JwtBearerEvents();
        options.Events.OnTokenValidated = async (context) =>
        {
            // add custom validation here.
        };
    });
```

### Json Web Token in ASP.NET Core Swagger

Reference

-   [OAuth Bearer Token with Swagger UI — .NET 6.0](https://medium.com/@deidra108/oauth-bearer-token-with-swagger-ui-net-6-0-86835e616deb)

```csharp
builder.Services.AddSwaggerGen(option =>
{
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        BearerFormat = "JWT",
        Description = "Please enter token",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Scheme = "bearer",
        Type = SecuritySchemeType.Http,
    });

    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                In = ParameterLocation.Header,
                Reference = new OpenApiReference
                {
                    Id="Bearer",
                    Type=ReferenceType.SecurityScheme,
                },
            },
            new string[]{}
        }
    });
});
```

## Refresh Token

### Generate Refresh Token

Refresh Token can be any string.

```csharp
var byteArray = new byte[64];
RandomNumberGenerator.Fill(byteArray);
Convert.ToBase64String(byteArray);
```
