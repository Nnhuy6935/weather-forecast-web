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
