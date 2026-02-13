# Day 4 Report --- RBAC Foundation Implementation

## Overview

Day 4 focused on implementing a complete Role‑Based Access Control
(RBAC) foundation for the backend system. This transitioned the
application from simple authentication to enterprise‑grade
authorization.

------------------------------------------------------------------------

## Objectives Achieved

### 1. RBAC Database Design

The following core tables were created:

-   **roles** --- stores system roles
-   **permissions** --- stores permission codes
-   **role_permissions** --- many‑to‑many mapping
-   **user_roles** --- assigns roles to users

All tables were successfully migrated using Alembic.

------------------------------------------------------------------------

### 2. Permission Enforcement Engine

Implemented a centralized permission dependency:

-   Loads current user from JWT
-   Retrieves assigned roles
-   Resolves permissions via join queries
-   Blocks unauthorized access with HTTP 403

File created:

    app/core/permissions.py

------------------------------------------------------------------------

### 3. OAuth2 Integration Alignment

Updated login flow to OAuth2 standard:

-   Switched to `OAuth2PasswordRequestForm`
-   Standard token response format
-   Fixed tokenUrl mismatch in Swagger

Result: Fully automated authorization flow in Swagger UI.

------------------------------------------------------------------------

### 4. JWT Payload Consistency Fix

Resolved a critical runtime issue:

-   JWT payload used `user_id`
-   Dependency expected `sub`
-   Updated dependency to read correct key

This restored authentication stability.

------------------------------------------------------------------------

### 5. RBAC Data Seeding

Initial roles and permissions inserted:

Roles: - PLATFORM_ADMIN - TRANSPORT_MANAGER - EMPLOYEE

Permissions: - FTMS_CREATE_BOOKING - FTMS_APPROVE_BOOKING -
FTMS_VIEW_BOOKINGS

User‑role mapping verified using UUID primary keys.

------------------------------------------------------------------------

### 6. Protected Endpoint Testing

Test endpoint created:

    POST /api/test/create-booking

Validation results:

-   Without role → 403 Forbidden
-   With role → 200 Permission granted

Confirms RBAC enforcement pipeline is fully operational.

------------------------------------------------------------------------

## System Architecture After Day 4

Request Flow:

Client Request\
→ OAuth2 Authentication\
→ JWT Validation\
→ User Resolution\
→ Role Lookup\
→ Permission Check\
→ API Access Decision

------------------------------------------------------------------------

## Key Lessons Learned

-   Foreign key types must match primary key types exactly.
-   OAuth2 requires strict request/response formats.
-   JWT payload contracts must align with dependency logic.
-   RBAC mappings must use database primary keys, not business
    identifiers.
-   Model layers must never import application logic or DB sessions.

------------------------------------------------------------------------

## Current System Status

The backend now supports:

-   Secure authentication
-   Dynamic role assignment
-   Permission‑based authorization
-   Real‑time access control enforcement

This marks the transition to an enterprise‑ready security architecture.

------------------------------------------------------------------------

## Next Phase Direction

Planned enhancements include:

-   Permission seeding automation
-   Admin role management APIs
-   Permission caching layer
-   Audit logging for access control events

------------------------------------------------------------------------


