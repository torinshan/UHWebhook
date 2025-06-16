# run_webhook_server.R
library(plumber)

# Point to your plumber API script
r <- plumb("openfield_webhook.R")

# Start the plumber server
r$run(host = "0.0.0.0", port = 8000)
