library(stringr)
library(httr)
library(jsonlite)
library(dplyr)

source("./api-requests.R")

GetPlaylistTracks <- function(playlist.id){
  playlist.tracks.base.uri <- paste0("https://api.spotify.com/v1/users/atheistjesus/playlists/", playlist.id)
  playlist.tracks <- GET(playlist.tracks.base.uri, add_headers(authorization = authorization.header))
  playlist.tracks.body <- content(playlist.tracks, "text")
  playlist.tracks.parsed.data <- fromJSON(playlist.tracks.body)
  clean.playlist.tracks <- data.frame(t(sapply(playlist.tracks.parsed.data,c)))
  specific.tracks <- clean.playlist.tracks$tracks$tracks$items$track
  return(specific.tracks)
}

test <- GetPlaylistTracks("4VX4Kc5LAAbLg0dJnHay7J")
America.test <- GetPlaylistTracks("37i9dQZEVXbLRQDuF5jeBp")

GetUsersPlaylists <- function(user.id){
  user.playlists.base.uri <- paste0("https://api.spotify.com/v1/users/", user.id, "/playlists")
  user.playlists <- GET(user.playlists.base.uri, add_headers(authorization = authorization.header))
  user.playlists.body <- content(user.playlists, "text")
  user.playlists.parsed.data <- fromJSON(user.playlists.body)
  clean.user.playlists <- data.frame(t(sapply(user.playlists.parsed.data,c)))
  clean.user.playlists <- clean.user.playlists$items
  return(clean.user.playlists)
}

temp <- GetUsersPlaylists("atheistjesus")

