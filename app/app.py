#!/usr/bin/env python3

import os
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello from ECS", "status": "running"}

@app.get("/health")
async def health():
    return {"status": "healthy"}

@app.get("/error")
async def error():
    print("ERROR: Test error for monitoring")
    return {"message": "Error triggered"}

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)