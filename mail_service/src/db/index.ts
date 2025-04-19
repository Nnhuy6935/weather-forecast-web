import { neon } from "@neondatabase/serverless";
import { drizzle } from "drizzle-orm/neon-http";
import * as schema from "./schema";

const sql = neon(Bun.env.DATABASE_URL!);
const db = drizzle(sql);

export default db;
export type newEmail = typeof schema.EmailTable.$inferInsert;
export type newOtp = typeof schema.tokenTable.$inferInsert;
