export const config = {
    port: Number.parseInt(process.env.PORT ?? "5000"),
    emailService: {
        host: process.env.EMAIL_HOST ?? "smtp.example.com",
        port: Number.parseInt(process.env.EMAIL_PORT ?? "578"),
        secure: process.env.EMAIL_SECURE === "true",
        auth: {
            user: process.env.EMAIL_USER ?? "",
            pass: process.env.EMAIL_PASS ?? "",
        },
        from: process.env.EMAIL_FROM ?? "norely@example.com",
    },
    optExpire: 10 * 60 * 1000,      // 10 minute in miliseconds 
    database: {
        url: process.env.DATABASE_URL ?? ""
    }
}