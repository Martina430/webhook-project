library(plumber)
library(jsonlite)

verify_token <- "Rogeno2001"  # Token segreto per la verifica

#* @get /webhook
function(hub.mode, hub.verify_token, hub.challenge) {
  if (!missing(hub.mode) && !missing(hub.verify_token) && !missing(hub.challenge)) {
    if (hub.mode == "subscribe" && hub.verify_token == verify_token) {
      return(hub.challenge)  # Restituisce il valore per la verifica
    } else {
      return(list(error = "Verifica fallita"))
    }
  } else {
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
