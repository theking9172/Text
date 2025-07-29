FROM python:3.9.7-slim-buster

# Set working directory inside container
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev ffmpeg mediainfo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy all project files into the container
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Run both Gunicorn and main.py in a proper way using a shell
CMD bash -c "gunicorn app:app & python3 main.py"
