import db from "../db";
import { EmailTable } from "../db/schema";
import { sendWeatherForecastInformation } from "../services/emailService";
import { eq } from "drizzle-orm"
import * as cron from 'node-cron';

export const startDailyMailJob = async () => {
    cron.schedule('50 14 * * *', async () => {
        console.log('⏰ Sending email job triggered...');
        const emailList = await db.select().from(EmailTable).where(eq(EmailTable.isVerified, true));
        for (const email of emailList) {
            await sendWeatherForecastInformation(email.email, email.city);
       }
       console.log(`✅ Sent email to ${emailList.length} users.`);
    })
}