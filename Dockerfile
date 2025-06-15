FROM rocker/r-ver:latest

RUN R -e "install.packages(c('plumber', 'jsonlite', 'data.table'), repos='https://cran.rstudio.com')"

COPY openfield_webhook.R /app/openfield_webhook.R
COPY run_webhook.R /app/run_webhook.R

WORKDIR /app

EXPOSE 8000

CMD ["Rscript", "run_webhook.R"]
