# Definition of Done (DoD)

This document defines the **non-negotiable criteria** for considering any issue as **DONE** in this repository.

An issue that does not satisfy **all** criteria below is **NOT DONE**, regardless of perceived completeness.

---

## Definition of Done

An issue is considered **DONE** only if **all** of the following conditions are met:

### 1. Code Written
- All required code changes are implemented
- Code is committed to the repository
- Changes are merged into the appropriate branch via Pull Request

---

### 2. Permission Enforced
- Role-Based Access Control (RBAC) is enforced where applicable
- Unauthorized access paths are explicitly prevented
- No implicit or client-side-only permission checks

---

### 3. Audit Logged (If Applicable)
- All security-sensitive or state-changing operations emit audit logs
- Audit logs include:
    - Actor (user/service)
    - Action performed
    - Timestamp
    - Target entity
- If audit logging is not applicable, this must be explicitly stated in the PR

---

### 4. API Follows Response Contract
- API responses conform to the agreed response structure
- Proper HTTP status codes are used
- Error responses are consistent and predictable
- No breaking changes without explicit approval

---

### 5. Linked to an Issue
- Pull Request is explicitly linked to a GitHub Issue
- Link is created using keywords such as:
    - `Closes #<issue-number>` or `Refs #<issue-number>`
- No orphan PRs are allowed

---

### 6. Tested Manually at Least Once
- Functionality has been manually tested by the author
- Test scenario and result are documented in the PR description or comments
- “Untested” or “assumed to work” is not acceptable

---

## Enforcement

- Reviewers must verify **all DoD criteria** before approving a Pull Request
- Issues closed without meeting DoD must be **reopened**
- There are **no exceptions** to this definition

---

## Rationale

The Definition of Done exists to:
- Prevent partial or ambiguous completion
- Ensure security, traceability, and consistency
- Maintain long-term system integrity

Speed without discipline is technical debt.
