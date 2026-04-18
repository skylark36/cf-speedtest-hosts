# Use a slim python image
FROM python:3.12-slim-bookworm

# Set working directory
WORKDIR /app

# Install dependencies for downloading and running the tool
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download and install CloudflareSpeedTest (v2.3.4)
RUN curl -L https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.3.4/cfst_linux_amd64.tar.gz -o cfst.tar.gz \
    && tar -zxf cfst.tar.gz \
    && rm cfst.tar.gz \
    && chmod +x cfst

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the script
COPY main.py .

# Environment variables (defaults)
ENV CRON="0 0 * * *"

# Run the app
CMD ["python", "main.py"]
