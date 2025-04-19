import * as nodemailer from "nodemailer"
import { config } from "../utils/config"
import { generateToken } from "../utils/helpFunction"
import db from "../db"
import { EmailTable, tokenTable } from "../db/schema"
import { eq, sql } from "drizzle-orm"
import { string } from "zod"
// create transaction 
const transporter = nodemailer.createTransport({
    host: config.emailService.host,
    port: config.emailService.port,
    secure: config.emailService.secure,
    auth: {
        user: config.emailService.auth.user,
        pass: config.emailService.auth.pass,
    }
})


export const sendVerificationEmail = async (email: string) => {
    try {
        const token = generateToken();
        const expiresAt = new Date(Date.now() + config.optExpire);
        const newToken = {
            email,
            token,
            expiresAt,
        }
        const tokenResult = await db.insert(tokenTable).values(newToken).returning();
        const mailOptions = {
            from: config.emailService.from,
            to: email,
            subject: "Verified Your Registration Email",
            html:
                `                            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                        <h2>Email Verification</h2>
                        <p>Hello ${email},</p>
                        <p>Thank you for registering. Please click on the following link to verify your email address:</p>
                        <div style="">
                            <i>https://webdatabase-702dd.web.app/confirm?token=${token}</i>
                        </div>
                        <p>This link will expire in 10 minutes.</p>
                        <p>If you didn't request this verification, please ignore this email.</p>
                        <p>Best regards,<br>Your App Team</p>
                        </div>
                    `

        }

        await transporter.sendMail(mailOptions);
        return {
            success: true,
            detail: {
                data: tokenResult,
            }
        }
    } catch (err) {
        return {
            success: false,
            detail: {
                error: err,
            }
        }
    }
}


export const VerifyToken = async (token: string) => {
    try {
        const validToken = await db.select().from(tokenTable).where(eq(tokenTable.token, token));
        if (validToken.length == 0) {
            return {
                success: false,
                detail: {
                    error: "invalid token",
                }
            }
        }
        if (validToken[0].expiresAt.getTime() < Date.now()) {
            return {
                success: false,
                detail: {
                    error: "token is expired",
                }
            }
        }
        const mail = validToken[0].email;
        await db.delete(tokenTable).where(eq(tokenTable.token, token))
        const emailUpdated = await db.update(EmailTable).set({
            isVerified: true,
            updatedAt: sql`NOW()`,
        }).where(eq(EmailTable.email, mail));
        return {
            success: true,
            detail: {
                data: emailUpdated,
            }
        }
    } catch (error) {
        return {
            success: false,
            detail: {
                error: error,
            }
        }
    }
}


export const registerEmail = async (email: string, city: string) => {
    const exist = await db.select().from(EmailTable).where(eq(EmailTable.email, email))
    console.log(exist);
    if (exist.length != 0) {
        if (exist[0].isVerified) {
            console.log('email is verified');
            return {
                success: false,
                detail: {
                    error: "Email have already register"
                }
            }
        } else {
            return {
                success: true,
                detail: {
                    data: exist,
                }
            }
        }

    }
    const queryData = {
        email,
        city,
    }
    const data = await db.insert(EmailTable).values(queryData).returning();
    return {
        success: true,
        detail: {
            data: data,
        }
    }
}

export const unsubscribeEmail = async (email: string) => {
    const deleted = await db.delete(EmailTable).where(eq(EmailTable.email, email));
    return {
        success: true,
        detail: {
            data: deleted,
        }
    }

}

export const sendWeatherForecastInformation = async (email: string, city: string) => {
    try {
        const res = await fetch(`${Bun.env.WEATHER_API_URL}/current.json?q=${city}&key=${Bun.env.WEATHER_API_KEY}`)
        const data = await res.json();
        const mailOptions = {
            from: config.emailService.from,
            to: email,
            subject: ` Your Daily Weather Forecast for ${city} - ${data['location']['localtime']} !`,
            html: ` <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                <h2>Good Morning, </h2>
                <p>Here is your weather update for ${city} on ${data['location']['localtime']}:</p>
                <ul>    
                    <li>🌡 Current Temperature: ${data['current']['temp_c']}°C </li>
                    <li>🌧 Condition: ${data['current']['condition']['text']}</li>
                    <li>💨 Wind Speed: ${data['current']['wind_mph']} km/h</li>
                    <li>💧 Humidity: ${data['current']['humidity']}%</li>
                </ul>
                <p>We hope this helps you plan your day better. Stay safe and dress accordingly! </p>
            </div>
            `
        }
        await transporter.sendMail(mailOptions);
        return {
            success: true,
            detail: {
                data: {
                    time: data['location']['localtime'],
                    temperature: data['current']['temp_c'],
                    condition: data['current']['condition']['text'],
                    windSpeed: data['current']['wind_mph'],
                    humidity: data['current']['humidity'],
                }
            }
        }
    } catch (error) {
        console.log(error);
        return {
            success: false,
            detail: {
                error: error,
            }
        }
    }
}

