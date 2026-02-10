## Manual Workflow Rules (Kanban Governance)

Certain workflow transitions are intentionally **manual** and are not automated.
These rules exist to enforce judgment, clarity, and accountability in the SDLC.

Automation must not replace human decision-making at these stages.

---

### Backlog → Ready

**When allowed**
- The issue scope is clearly defined
- Acceptance criteria are understood
- Dependencies are identified
- The work is approved for implementation

**Who decides**
- Maintainer / Lead / Reviewer

**Rationale**
Moving an issue to *Ready* signals that it is eligible to be worked on immediately.
Premature movement creates churn and rework.

---

### Any State → Blocked

**When required**
- An external dependency exists (technical, organizational, or approval-based)
- Progress cannot continue without external input
- The blocker is outside the assignee’s control

**Requirements**
- The blocking reason must be documented in the issue
- The dependency owner (if known) should be mentioned

**Rationale**
Blocked work must be visible. Silent blockers distort delivery timelines and
invalidate board metrics.

---

### Blocked → Ready / In Progress

**When allowed**
- The blocking dependency has been fully resolved
- Confirmation is documented in the issue
- No new blockers are present

**Target state**
- Return to *Ready* if work has not started
- Return to *In Progress* if work was partially completed

**Rationale**
Unblocking is a conscious decision. Automatic movement risks resuming work
without validating resolution.

---

## Non-Negotiable Principles

- Manual transitions require explicit intent
- Status changes must reflect reality, not optimism
- The board is a source of truth, not a reporting artifact
- Exceptions must be documented, not implied
