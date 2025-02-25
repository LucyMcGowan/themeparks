get_park <- function(park) {

}

list_parks <- function() {
  response <- httr::RETRY(
    verb = "GET",
    url = "https://api.themeparks.wiki/v1/parks"
  )

  httr::stop_for_status(response)
  httr::content(response, encoding = "UTF-8") |>
    unlist()
}
