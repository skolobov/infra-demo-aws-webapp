# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Install curl for the healthcheck
RUN apt-get update && \
    apt-get install --yes --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and group
RUN adduser --system appuser

# Set the working directory
WORKDIR /app

# Copy the dependency files first (for better caching)
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Change to the non-root user
USER appuser

# Copy Python code
COPY *.py /app

# Expose the port
EXPOSE 8080

# Add a healthcheck
HEALTHCHECK CMD curl --fail http://127.0.0.1:8080/health || exit 1

# Run the application
CMD ["python3", "hello-world.py"]
