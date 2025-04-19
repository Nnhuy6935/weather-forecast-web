import { zValidator } from '@hono/zod-validator';
import { Hono } from 'hono'
import { z } from "zod";
import { registerEmail, sendVerificationEmail, sendWeatherForecastInformation, unsubscribeEmail, VerifyToken } from './services/emailService';
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'
import { startDailyMailJob } from './jobs/dailyMail';

const RegisterSchema = z.object({
  email: z.string().email(),
  city: z.string(),
});

const UnsubscribeSchema = z.object({
  email: z.string().email(),
})
const ConfirmSchema = z.object({
  token: z.string(),
});

const WeatherForecastSchema = z.object({
  email: z.string().email(),
  city: z.string(),
})

const app = new Hono()

startDailyMailJob();

app.use('*', cors());
app.use('*',
  cors({
    origin: '*',
  })
)

app.use(logger());

app.get('/', (c) => {
  return c.text('Hello Hono!')
})

app.post('/api/register', zValidator('json', RegisterSchema) ,async (c) => {
  const {email, city} = c.req.valid('json');
  try{
    const emailResult = await registerEmail(email, city);
    if(!emailResult.success){
      return c.json({
        result: emailResult,
      }, 400)
    }else{
      const sendMailResult = await sendVerificationEmail(email);
      return c.json({
        result: sendMailResult,
      }, sendMailResult.success ? 200 : 400);
    }
  }catch(error){
    return c.json({
      "success": false,
      "detail":{
        "error": error,
      }
    }, 500)
  }
  
})


app.post('/api/confirm', zValidator('json', ConfirmSchema) ,async(c) => {
  try{
    const { token } = c.req.valid('json');
    console.log(`token ==> ${token}`);
    const result = await VerifyToken(token);
    console.log(result);
    return c.json({
      result: result,
    }, result.success ? 200 : 400)
  }catch(error){
    return c.json({
      success: false,
      detail: {
        error: error,
      }
    })
  }
})


app.post('/api/unsubscribe', zValidator('json', UnsubscribeSchema), async(c) => {
  try{
    const { email } = c.req.valid('json');
    const result = await unsubscribeEmail(email);
    return c.json({
      result: result,
    }, 200);
  }catch(error){
    return c.json({
      result: error, 
    }, 500);
  }
})


app.post('/api/send-weather-forecast', zValidator('json', WeatherForecastSchema), async (c) => {
  try{
    const {email, city} = c.req.valid('json');
    const resp = await sendWeatherForecastInformation(email, city);
    return c.json({
      result: resp,
    }, 200)
  }catch(error){
    return c.json({
      success: false,
      detail:{
        error: error,
      }
    }, 500)
  }
})
export default {
  port: Bun.env.PORT ?? 3000,
  fetch: app.fetch,
}
