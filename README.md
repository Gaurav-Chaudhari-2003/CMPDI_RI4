# CMPDI RI-4 – Digital Operations Platform

## Overview
This repository contains the source code for the **CMPDI RI-4 Digital Operations Platform**, a centralized system designed to support operational workflows through a secure API-first backend and multiple Flutter-based client applications. The platform aims to standardize data access, improve operational visibility, and enable future digital transformation initiatives within CMPDI RI-4.

The system is designed with clear separation of concerns: a backend API responsible for business logic and data persistence, and client applications responsible for presentation and user interaction.

---

## High-Level Architecture
The platform follows an **API-only backend architecture** with multiple clients:

- **Backend**: A RESTful API that exposes all business capabilities
- **Clients**:
  - Flutter mobile application(s)
  - Flutter web application (optional/extended scope)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


temp
All clients communicate exclusively with the backend API. No client accesses the database directly.

---

## Technology Stack

### Backend
- **FastAPI** – High-performance Python web framework for building APIs
- **PostgreSQL** – Relational database for persistent storage
- **SQLAlchemy / Alembic** – ORM and database migrations (planned)

### Clients
- **Flutter** – Cross-platform framework for mobile and web clients

### Infrastructure (Planned)
- GitHub Actions – CI/CD
- Docker – Containerization
- Cloud or on-prem deployment (TBD)

---

## Documentation
- **Foundation Document**:  
  Refer to the project foundation document for requirements, constraints, architectural decisions, and governance rules.  
  (Link to be added)

---

## Repository Structure (Evolving)
This repository will evolve to include:
- Backend API source code
- Client application source code
- CI/CD configuration
- Documentation and architectural decision records (ADRs)

---

## Contribution Model
- All changes must go through pull requests
- Direct pushes to `main` are blocked
- CI checks must pass before merging

Refer to contribution guidelines (to be added) before submitting changes.