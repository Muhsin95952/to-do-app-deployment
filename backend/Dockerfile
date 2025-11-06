# Build stage
FROM python:3.11-slim-bookworm AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# ==================== ADD THIS LINE ====================
# Upgrade pip and setuptools to patch vulnerabilities *before* installing requirements
RUN pip install --upgrade pip setuptools
# =======================================================

# Create virtual environment and install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Production stage
FROM python:3.11-slim-bookworm

WORKDIR /app

# ==================== ADD THIS SECTION ====================
# Install security updates for OS packages (like libgnutls30, libpam, etc.)
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
# ==========================================================

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY . .

# Set environment variables
ENV FLASK_APP=application.py
ENV FLASK_ENV=production

# Expose the port the app runs on
EXPOSE 5000

# Run the application
CMD ["/opt/venv/bin/gunicorn", "--bind", "0.0.0.0:5000", "application:app"]