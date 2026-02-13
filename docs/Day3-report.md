
## 🎯 Day 3 Goal

By end of today:

-   Users table exists
-   Password hashing works
-   Login endpoint issues JWT
-   Protected route validates token

No RBAC yet. That's tomorrow.

------------------------------------------------------------------------

# 1️⃣ Install Required Packages

Add:

-   passlib\[bcrypt\]
-   python-jose\[cryptography\]
-   sqlalchemy
-   psycopg2-binary
-   alembic

Update requirements and commit.

------------------------------------------------------------------------

# 2️⃣ Database Setup (Clean & Layered)

Add:

app/ ├── db/ │ ├── base.py │ ├── session.py │ └── models/ │ └── user.py

### base.py

Create declarative base.

### session.py

Create engine + session factory using DATABASE_URL.

No direct engine creation inside routes.

------------------------------------------------------------------------

# 3️⃣ Create Users Table

Users table fields:

-   id (UUID or int)
-   employee_id (unique)
-   name
-   email (unique)
-   phone
-   password_hash
-   status (active / suspended)
-   created_at
-   updated_at

Do NOT store plaintext password. Ever.

------------------------------------------------------------------------

# 4️⃣ Password Hashing Utility

Create:

app/core/security.py

Functions:

-   hash_password()
-   verify_password()

Use bcrypt via passlib.

------------------------------------------------------------------------

# 5️⃣ JWT Utility

In same security module:

Functions:

-   create_access_token()
-   decode_token()

Token payload should contain:

-   user_id
-   employee_id
-   exp

Do NOT include roles yet.

------------------------------------------------------------------------

# 6️⃣ Auth Routes

Create:

app/api/auth.py

Endpoints:

### POST /api/auth/login

Input:

employee_id\
password

Process:

-   Validate user
-   Verify password
-   Return JWT

Use standard response wrapper.

------------------------------------------------------------------------

# 7️⃣ Dependency for Protected Routes

Create:

get_current_user dependency:

-   Extract Bearer token
-   Decode JWT
-   Fetch user from DB
-   Ensure user is active
-   Return user object

If invalid → 401.

------------------------------------------------------------------------

# 8️⃣ Create a Protected Test Route

Example:

GET /api/auth/me

Returns current user info.

This proves:

-   Token works
-   Middleware works
-   DB works

------------------------------------------------------------------------

# 9️⃣ Migration (Important)

Use Alembic:

-   Initialize
-   Create migration for users table
-   Apply migration

No manual DB table creation.

------------------------------------------------------------------------

# 🔟 Test Flow (Mandatory)

You must test:

1.  Create user manually in DB
2.  Login → receive token
3.  Access /me → works
4.  Modify token → returns 401
5.  Deactivate user → returns 401

If any fails, fix today.

------------------------------------------------------------------------

# 🚫 What NOT To Do Today

-   Add roles
-   Add permissions
-   Add audit logs
-   Start FTMS

Auth must be stable first.

------------------------------------------------------------------------

# ✅ Expected End-of-Day State

You have:

-   Running FastAPI
-   PostgreSQL connected
-   User table migrated
-   Secure login issuing JWT
-   Protected route validated



