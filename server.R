library(plumber)
print("Avviando il server Webhook...")  
r <- plumb("webhook.R")  # Collega il file principale
print("Webhook caricato!")  
r$run(port = 8000)  # Avvia il server sulla porta 8000

source("server.R")


library(httr)
res <- POST("http://127.0.0.1:8000/webhook", body = '{"test": "Instagram"}', encode = "json")
content(res)
