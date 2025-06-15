library(httr)

resp <- POST("http://127.0.0.1:48152/openfield-webhook",
             body = list(trigger = list(id = "test123"),
                         action = "created"),
             encode = "json")

content(resp)
