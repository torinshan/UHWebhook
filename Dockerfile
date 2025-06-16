# Base image with R
FROM rocker/r-ver:4.5.1

# Install system-level libraries required by plumber, httpuv, and sodium
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libz-dev \
    libsodium-dev \
    build-essential \
    && apt-get clean

# Install R packages
RUN R -e "install.packages(c('plumber', 'jsonlite', 'data.table'), repos = 'https://cran.rstudio.com')"

# Set working directory
WORKDIR /app

# Copy your webhook script
COPY openfield_webhook.R /app/openfield_webhook.R

# Expose the plumber API port
EXPOSE 8000

# Run the plumber API
CMD ["R", "-e", "plumber::plumb('openfield_webhook.R')$run(host='0.0.0.0', port=8000)"]
