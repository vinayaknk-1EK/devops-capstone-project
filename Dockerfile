FROM python:3.9-slim

# creating working directory and installing dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Coping service files
COPY service/ ./service/

# switching to non-root-user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# exposing port to listen to

EXPOSE  8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
