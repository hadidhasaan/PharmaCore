# PharmaCore

PharmaCore is a PHP 8 + MySQL/MariaDB pharmacy management system for pharmacy operations, inventory, purchasing, sales, returns, finance, cashier shifts, customer receivables, expenses, clinical records, settings, notifications, imports, reporting, and protected backup/recovery.

## Requirements

- PHP 8.2 or newer compatible with this codebase
- MySQL 8+ or MariaDB 10.4+
- PHP PDO MySQL extension
- PHP mbstring extension
- Apache/XAMPP for the standard local setup

## Database setup

The clean release uses one canonical database schema file:

`database/PharmaCore.sql`

This file contains the current 90-table schema exported from the working PharmaCore database. It is a structure-only export; test/business rows are intentionally not included.

For a fresh installation:

1. Create an empty database named `pharmacore` in phpMyAdmin or your hosting control panel.
2. Import `database/PharmaCore.sql`.
3. Configure the database values in your environment (see `.env.example`).
4. Start Apache and MySQL/MariaDB.
5. Open `http://localhost/PharmaCore/public/` under XAMPP.
6. Create the first administrator from the setup page when the imported database has no users.

The application does not create the database or database user automatically.

## XAMPP entry point

`http://localhost/PharmaCore/public/`

The public front controller is `public/index.php` and Apache routing is defined by the included `.htaccess` files.

## Project structure

```text
app/         Core application, authentication, security, and services
config/      Application configuration and HTTP routes
database/    Canonical current database schema export
public/      Web entry point and public assets
resources/   Shared views and UI components
scripts/     Local backup/scheduler helper scripts
bin/         CLI helper entry points
storage/     Protected runtime storage
```

## Security baseline

The application uses password hashing, session management, CSRF protection, permission-based authorization, prepared SQL statements, security headers, audit logging, and protected runtime storage. Local secrets belong in environment configuration and must not be committed.

## Development principle

Build -> Test -> Audit -> Fix -> Re-test.

The repository intentionally contains the current application source and one canonical database schema export rather than the historical migration and audit-file archive used during development.
