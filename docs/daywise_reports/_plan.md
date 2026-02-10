# CMPDI RI-4 — 21-Day Execution Plan

**Objective:**  
Take CMPDI RI-4 from zero code to a working, defensible system in 21 days.

**Constraints:**
- Single developer
- Full-day execution, no multitasking
- No redesigns midstream
- Functional correctness > cosmetic polish

---

## Assumptions (Explicit)

- Backend: **FastAPI + PostgreSQL**
- Frontend: **Flutter**
- Stack is finalized
- Goal is a *working institutional-grade system* with a strong foundation

---

# WEEK 1 — FOUNDATION & CORE (Days 1–7)

### 🎯 Goal
Establish backend foundation with authentication, RBAC, audit logging, and start FTMS with a real vertical slice.

---

## Day 1 — Repo, Process, Discipline

**Outcome:** Project becomes real and enforceable.

**Tasks:**
- Create GitHub repository
- Add `README.md` (link foundation document)
- Set up:
    - Branch strategy (`main`, `dev`)
    - Commit message rules
    - GitHub Issues labels
    - GitHub Project board
- Create initial issues:
    - Backend skeleton
    - Authentication system
    - FTMS module

⚠️ **No coding beyond hello-world**

---

## Day 2 — Backend Skeleton

**Outcome:** Backend boots cleanly and predictably.

**Tasks:**
- FastAPI project structure
- Environment configuration
- PostgreSQL connection
- Health check endpoint
- Logging setup
- Base response wrapper

**Deliverable:**
- `GET /health` returns standardized response

---

## Day 3 — Authentication Core

**Outcome:** Secure authentication works end-to-end.

**Tasks:**
- Users table
- Password hashing
- JWT access + refresh tokens
- Login endpoint
- Token validation middleware

**Deliverable:**
- Login → JWT → protected endpoint works

---

## Day 4 — RBAC + Permissions

**Outcome:** Authorization is enforced, not theoretical.

**Tasks:**
- Roles table
- Permissions table
- Role-permission mapping
- User-role mapping
- Permission enforcement decorator

**Deliverable:**
- Unauthorized access returns proper `403 Forbidden`

---

## Day 5 — Audit Logging

**Outcome:** System becomes institution-grade and traceable.

**Tasks:**
- Audit log table
- Automatic audit hooks
- Log:
    - Login events
    - Role changes
    - CRUD actions

**Deliverable:**
- Audit entries created automatically without manual calls

---

## Day 6 — FTMS Database Design

**Outcome:** First real module foundation is solid.

**Tasks:**
- Design tables:
    - Vehicles
    - Drivers
    - Bookings
    - Approval workflow
- Indexing strategy
- Create migrations

**Deliverable:**
- ER diagram
- Database migrations applied

---

## Day 7 — FTMS Core APIs

**Outcome:** Vertical slice backend works.

**Tasks:**
- Create booking
- Approve / reject booking
- Assign vehicle & driver
- Permission enforcement
- Audit logging

**Deliverable:**
- End-to-end FTMS backend workflow functional

---

### ✅ End of Week 1 Status

- Backend foundation complete
- Auth + RBAC + audit logging active
- FTMS backend vertical slice running

---

# WEEK 2 — FRONTEND + FULL FTMS (Days 8–14)

### 🎯 Goal
Flutter app works end-to-end for FTMS.

---

## Day 8 — Flutter Skeleton

**Outcome:** App launches reliably.

**Tasks:**
- Flutter project setup
- Domain-aligned folder structure
- Theme configuration
- Navigation shell

---

## Day 9 — Auth Flow (Flutter)

**Outcome:** Authentication is real, not mocked.

**Tasks:**
- Login screen
- Secure token storage
- API client setup
- Auth guard

**Deliverable:**
- Login → dashboard flow works

---

## Day 10 — Role-Based Navigation

**Outcome:** UI respects backend roles.

**Tasks:**
- Decode roles from JWT / backend
- Conditional navigation
- Access denied screens

⚠️ Backend still enforces permissions

---

## Day 11 — FTMS UI (Employee)

**Outcome:** Real usage begins.

**Tasks:**
- Create booking screen
- View booking status
- Error handling and validations

---

## Day 12 — FTMS UI (Manager/Admin)

**Outcome:** Workflow completes.

**Tasks:**
- Approval screen
- Vehicle & driver assignment
- Booking list views

---

## Day 13 — FTMS End-to-End Testing

**Outcome:** System is usable and stable.

**Tasks:**
- Backend testing
- Frontend testing
- Fix authentication edge cases
- Fix RBAC inconsistencies

---

## Day 14 — CI/CD Setup

**Outcome:** Professional development workflow.

**Tasks:**
- GitLab CI pipeline
- Linting and tests
- Build checks
- Merge blocking rules

---

### ✅ End of Week 2 Status

- Flutter app operational
- FTMS fully functional end-to-end
- CI/CD pipeline active

---

# WEEK 3 — SECOND MODULE + HARDENING (Days 15–21)

### 🎯 Goal
Add RMCS (Complaints) and harden system for production readiness.

---

## Day 15 — RMCS DB + Backend

**Outcome:** Second module foundation established.

**Tasks:**
- Complaints table
- Electrical / Civil units
- Status flow
- Permissions

---

## Day 16 — RMCS APIs

**Outcome:** Complaints workflow functional.

**Tasks:**
- Raise complaint
- Assign technician
- Update status
- Audit logging

---

## Day 17 — RMCS Flutter UI

**Outcome:** Residents and staff can operate.

**Tasks:**
- Complaint form
- Status tracking
- Technician views

---

## Day 18 — Error Handling & Stability

**Outcome:** System stops crashing under edge cases.

**Tasks:**
- Standardized API errors
- User-friendly error messages
- Edge case handling

---

## Day 19 — Performance & Security Pass

**Outcome:** System is defensible.

**Tasks:**
- Pagination everywhere
- Query optimization
- Input validation
- Permission review

---

## Day 20 — Documentation & Demo Prep

**Outcome:** System is explainable and defensible.

**Tasks:**
- Update GitHub Wiki
- Architecture diagram
- API documentation
- Demo script

---

## Day 21 — Buffer + Review

**Outcome:** Confidence and stability.

**Tasks:**
- Fix leftover bugs
- Code cleanup
- Final deployment test
- Backup strategy verification

---

## Final Deliverable

A working, audited, role-secured, multi-module CMPDI RI-4 system that is:
- Demonstrable
- Defensible
- Extendable
- Institution-ready
