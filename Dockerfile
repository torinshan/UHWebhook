# Base R image
FROM rocker/r-ver:4.5.1

# Install Linux system libraries required for plumber and dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    && apt-get clean

# Install R packages (plumber + dependencies)
RUN R -e "install.packages(c('plumber', 'jsonlite', 'data.table'), repos = 'https://cran.rstudio.com')"

# Create app directory and copy webhook script
WORKDIR /app
COPY openfield_webhook.R /app/openfield_webhook.R

# Expose the port Plumber will use
EXPOSE 8000

# Command to run your webhook
CMD ["R", "-e", "plumber::plumb('openfield_webhook.R')$run(host='0.0.0.0', port=8000)"]
