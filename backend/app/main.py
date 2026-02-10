from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="CMPDI RI4 API",
    description="Backend services for the CMPDI RI4 project",
    version="1.0.0"
)

# Set up CORS (Cross-Origin Resource Sharing)
# This is essential if your Flutter app (or any frontend) is running on a different port/domain
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins, adjust for production
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

@app.get("/")
async def root():
    return {"message": "Welcome to the CMPDI RI4 API", "status": "running"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

# Future: Include routers from the api module
# from app.api import some_module
# app.include_router(some_module.router, prefix="/api/v1")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
