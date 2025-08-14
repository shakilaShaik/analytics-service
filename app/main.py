from fastapi import FastAPI
from app.routes import router
from fastapi.middleware.cors import CORSMiddleware

import os
app = FastAPI()
frotnend_origin=os.getenv("ALLOWED_ORIGINS")



app.add_middleware(
    CORSMiddleware,
    allow_origins=
        frotnend_origin
    ,  # Replace "*" with specific origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router)
