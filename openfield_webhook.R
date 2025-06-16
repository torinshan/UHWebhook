# openfield_webhook.R
library(plumber)
library(jsonlite)

#* @apiTitle OpenField Webhook Receiver
# The above line sets the title shown when plumber starts up or accessed via Swagger.

#* Receive webhook POST requests from Catapult OpenField
#* @post /openfield-webhook
function(req, res) {
  # Parse JSON body
  payload <- fromJSON(req$postBody)
  
  # Print payload to R console for testing
  print(payload)
  
  # Optional: Log payload to file
  write(toJSON(payload, pretty = TRUE), file = "webhook_log.json", append = TRUE)
  
  # Respond immediately (OpenField expects HTTP 200 OK)
  list(status = "received", timestamp = Sys.time())
}
