## Instruction how to build server
To generate databases: 
```sh
npx drizzle-kit generate
```

To migrate database:
```sh
npx drizzle-kit migrate
```

To install dependencies:
```sh
bun install
```

To run:
```sh
bun run dev
```

## Technical 
- ``hono`` + ``bun``
- ``drizzle`` : manage neon database
- ``node_cron``: schedule jobs ( send daily notification to register email)
- ``nodemailer`` : send email

## Environment variables 
- PORT=3007
- DATABASE_URL=postgresql://[database-owner]:[database-password]@[database-host]/[database-name]?sslmode=require

- EMAIL_HOST=[mail-host]
- EMAIL_PORT=[mail-port]
- EMAIL_SECURE=false
- EMAIL_USER=[email-user]
- EMAIL_PASS=[email-password]
- EMAIL_FROM=noreply@example.com

- WEATHER_API_URL=https://api.weatherapi.com/v1
- WEATHER_API_KEY=[api-key]

## Deploy API 
- api link: https://weather-forecast-web-zob7.onrender.com

## Send Mail demo 
### Verification email 
![image](https://github.com/user-attachments/assets/49bd86d0-2a66-4df9-9281-399e37e9c897)

### Daily notification email 
![image](https://github.com/user-attachments/assets/a1ad27e0-4471-4004-a46e-d693020c138e)

