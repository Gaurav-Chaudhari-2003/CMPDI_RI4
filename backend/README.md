# Backend API - CMPDI RI4

This directory contains the backend services for the CMPDI RI4 project.

## Tech Stack
- **Language:** Python
- **Framework:** FastAPI (Recommended)
- **Environment:** Python 3.8+

## Project Structure
```text
backend/
├── app/
│   ├── api/          # API endpoints and route handlers
│   ├── core/         # Core configuration, security, and constants
│   └── main.py       # Application entry point
├── requirements.txt  # Project dependencies
└── README.md         # Documentation
```

## Getting Started

### Prerequisites
- Python 3.8 or higher installed on your system.

### Installation
1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Create a virtual environment:
   ```bash
   python -m venv venv
   ```
3. Activate the virtual environment:
   - **Windows:** `venv\Scripts\activate`
   - **Unix/MacOS:** `source venv/bin/activate`
4. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

### Running the Application
To start the development server (assuming FastAPI):
```bash
uvicorn app.main:app --reload
```

## API Documentation
Once the server is running, you can access the automatically generated documentation at:
- **Swagger UI:** [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- **ReDoc:** [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)
