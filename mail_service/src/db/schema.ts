import { boolean, integer, pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const EmailTable = pgTable("emails", {
    id: integer().primaryKey().generatedAlwaysAsIdentity(),
    email: text().notNull(),
    isVerified: boolean().notNull().default(false),
    city: text().notNull(),
    createdAt: timestamp().notNull().defaultNow(),
    updatedAt: timestamp().notNull().defaultNow(),
});

export const tokenTable = pgTable("tokens", {
    id: integer().primaryKey().generatedAlwaysAsIdentity(),
    email: text().notNull(),
    token: text().notNull(),
    expiresAt: timestamp().notNull(),
    createdAt: timestamp().notNull().defaultNow(),
    updatedAt: timestamp().notNull().defaultNow()
})