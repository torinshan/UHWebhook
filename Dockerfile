FROM rocker/r-ver:latest

# Install system libraries needed for common R packages like curl, plumber, etc.
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    && apt-get clean

# Install required R packages
RUN R -e "install.packages(c('plumber', 'jsonlite', 'data.table'), repos = 'https://cran.rstudio.com')"

# Copy your Plumber webhook R script into the image
COPY openfield_webhook.R /app/openfield_webhook.R

# Set the working directory
WORKDIR /app

# Expose port 8000 (Plumber default)
EXPOSE 8000

# Run the API
CMD ["R", "-e", "plumber::plumb('openfield_webhook.R')$run(host='0.0.0.0', port=8000)"]
