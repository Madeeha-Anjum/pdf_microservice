# Debeing from the official Python image
FROM python:3.12-slim  

WORKDIR /app

RUN pip install pdm

COPY . ./

RUN pdm install

# Add the virtualenv to the PATH
ENV PATH="/app/.venv/bin:$PATH" 

# Command to run the FastAPI app with uvicorn
# CMD ["pdm", "run", "start"]
# OR
CMD ["fastapi",  "run", "src/micro/main.py", "--port", "8000"]