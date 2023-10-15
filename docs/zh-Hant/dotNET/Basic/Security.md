# Security

## Json Web Token

```csharp
var email = "email"; // replace user identity here.
var key = "key"; // key is the secret key.
var sub = "sub"; // sub means subject.
var iss = "iss"; // iss means issuer.
var aud = "aud"; // aud means audience.

var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key));
var signingCredentials = new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256Signature);
var expires = DateTime.UtcNow.AddMinutes(10);

var claims = new Claim[]
{
    new Claim(ClaimTypes.Email, email),
    new Claim(JwtRegisteredClaimNames.Sub, sub),
    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
    new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
};

var jwtSecurityToken = new JwtSecurityToken(
    iss,
    aud,
    claims,
    expires: expires,
    signingCredentials: signingCredentials);

var token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
```
