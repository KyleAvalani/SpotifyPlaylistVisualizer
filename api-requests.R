library(stringr)
library(httr)
library(jsonlite)

#Retrieves api-keys
source("./api-keys.R")

#Encodes the authentication string in Base64, which is required to make requests from Spotify's API.
encoded.string <- base64_enc(paste0(client.id,":",client.secret))
updated.string <-paste0("Authorization: Basic ",encoded.string)

#Makes the request to Spotify for the API token
response <- POST(
  'https://accounts.spotify.com/api/token',
  accept_json(),
  authenticate(client.id, client.secret),
  body = list(grant_type = 'client_credentials'),
  encode = 'form',
  verbose()
)

#Extracts and stores the API token and then creates the authorization header
token <- content(response)$access_token
authorization.header <- paste0("Bearer ", token)
