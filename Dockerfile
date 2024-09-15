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


# How to build the image
# for eample when running the container, the host name will be resolved to the IP address you specify
# --add-host		Add a custom host-to-IP mapping (format: host:ip)
# tags are used to identify the image in the repository. For example, you can have multiple versions of the same image with different tags. tags can be dates, version numbers, or any other meaningful identifier.
# if I push with the same tag, it will overwrite the previous image
# -t        Name and optionally a tag in the 'name:tag' format 

