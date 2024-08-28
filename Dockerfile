# Debeing from the official Python image
FROM python:3.12-slim  

# open scripot to install weasyprint dependencies
RUN apt-get update
# install weasyprint dependencies
RUN apt install -y python3-pip libpango-1.0-0 libpangoft2-1.0-0 libharfbuzz-subset0 libjpeg-dev libopenjp2-7-dev libffi-dev 


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