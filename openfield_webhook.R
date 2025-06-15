library(plumber)
library(jsonlite)
library(data.table) # for efficient writing

# Define file path
csv_file <- "activity_data.csv"

#* @post /openfield-webhook
function(req, res) {
  payload <- fromJSON(req$postBody)
  
  # Prepare your data as a data.frame
  new_data <- data.frame(
    activity_id = payload$trigger$id,
    event_type = payload$action,
    timestamp = as.character(Sys.time())
  )
  
  # Check if file exists
  if (!file.exists(csv_file)) {
    fwrite(new_data, csv_file)
  } else {
    fwrite(new_data, csv_file, append = TRUE)
  }
  
  # Respond
  list(status = "received", timestamp = Sys.time())
}
