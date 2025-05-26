library(plumber)
library(jsonlite)

verify_token <- "Rogeno2001"  # Token segreto per la verifica

#* @get /webhook
#* @serializer unboxedJSON
function(req, res) {
  res$setHeader("Content-Type", "text/plain")
  
  params <- req$args
  hub.mode <- params$hub.mode
  hub.verify_token <- params$hub.verify_token
  hub.challenge <- params$hub.challenge
  
  if (!is.null(hub.mode) && !is.null(hub.verify_token) && !is.null(hub.challenge)) {
    if (hub.mode == "subscribe" && hub.verify_token == verify_token) {
      res$status <- 200
      return(as.character(hub.challenge))  # Meta richiede una risposta in testo normale!
    } else {
      res$status <- 403
      return(list(error = "Verifica fallita"))
    }
  } else {
    res$status <- 400
    return(list(error = "Parametri mancanti"))
  }
}

#* @post /webhook
function(req) {
  # Controlla se il corpo della richiesta esiste
  if (!is.null(req$postBody)) {
    event_data <- fromJSON(req$postBody)  # Converte i dati JSON ricevuti
    print(event_data)  # Stampa i dati ricevuti
    return(list(status = "OK"))  # Restituisce conferma
  } else {
    return(list(error = "Dati mancanti"))
  }
}
