# Day 3 Report --- Authentication Core (JWT + Users)

Day 3 is critical. If authentication is incorrect, all future modules
will fail.

------------------------------------------------------------------------

# Objective

By end of Day 3:

-   Users table exists
-   Password hashing implemented securely
-   Login endpoint issues JWT
-   Protected route validates token correctly

No RBAC implemented today.

------------------------------------------------------------------------

# Step-by-Step Implementation Report

------------------------------------------------------------------------

## 1️⃣ Install Required Packages

Added the following dependencies:

-   passlib\[bcrypt\]
-   python-jose\[cryptography\]
-   sqlalchemy
-   psycopg2-binary
-   alembic

Updated requirements.txt and committed changes.

------------------------------------------------------------------------

## 2️⃣  Database Layer Setup

Created structured DB layer inside app/:

app/ ├── db/ │ ├── base.py │ ├── session.py │ └── models/ │ └── user.py

### base.py

-   Created SQLAlchemy declarative Base

### session.py

-   Configured engine using DATABASE_URL
-   Created SessionLocal factory
-   No direct engine usage inside routes

Result: Clean and layered DB architecture.

------------------------------------------------------------------------

## 3️⃣  Users Table Model

Created user model with fields:

-   id (UUID primary key)
-   employee_id (unique)
-   name
-   email (unique)
-   phone
-   password_hash
-   status (active / suspended)
-   created_at
-   updated_at

Important rule followed:

Passwords are stored only as hashed values. No plaintext storage.

------------------------------------------------------------------------

## 4️⃣ Password Hashing Utility

Created:

app/core/security.py

Implemented:

-   hash_password()
-   verify_password()

Used bcrypt via passlib.

Verified:

-   Password hashes correctly
-   Verification returns True/False properly

------------------------------------------------------------------------

## 5️⃣ JWT Utility Implementation

Inside security module:

Implemented:

-   create_access_token()
-   decode_token()

JWT payload contains:

-   user_id
-   employee_id
-   exp (expiration)

Roles not included.

Verified:

-   Token generation works
-   Expired token fails correctly

------------------------------------------------------------------------

## 6️⃣  Auth Routes

Created:

app/api/auth.py

### POST /api/auth/login

Process:

1.  Fetch user by employee_id
2.  Verify password
3.  Generate JWT
4.  Return token using standard response wrapper

Test Result:

Login returns valid JWT.

------------------------------------------------------------------------

## 7️⃣ Protected Route Dependency

Created:

get_current_user dependency

Logic:

1.  Extract Bearer token
2.  Decode JWT
3.  Fetch user from DB
4.  Check if user status is active
5.  Return user object

Failure conditions:

-   Invalid token → 401
-   Expired token → 401
-   Suspended user → 401

------------------------------------------------------------------------

## 8️⃣  Protected Test Endpoint

Created:

GET /api/auth/me

Returns current authenticated user information.

Verified:

-   Valid token → returns user data
-   Invalid token → 401
-   Suspended user → 401

------------------------------------------------------------------------

## 9️⃣ Database Migration

Used Alembic:

-   Initialized Alembic
-   Generated migration for users table
-   Applied migration to PostgreSQL

No manual table creation performed.

Migration verified successfully.

------------------------------------------------------------------------

## 🔟  End-to-End Testing

Mandatory tests performed:

1.  Created user manually in database
2.  Login successful → JWT received
3.  Accessed /me → success
4.  Modified token → 401
5.  Changed user status to suspended → 401

All tests passed.

------------------------------------------------------------------------

# Scope Control

Did NOT:

-   Add roles
-   Add permissions
-   Add audit logs
-   Start feature modules

Authentication stabilized first.

------------------------------------------------------------------------

# Final End-of-Day Status

System state:

-   FastAPI running
-   PostgreSQL connected
-   Users table migrated
-   Password hashing secure
-   JWT issued correctly
-   Protected route validated

Commit example:

feat(auth): implement JWT authentication and user model
(#`<issue>`{=html})

------------------------------------------------------------------------

Day 3 authentication core successfully implemented.
