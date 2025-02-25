#' Get destinations
#'
#' Get a list of supported destinations available on the live API
#'
#' @return A data frame of supported destinations with the following
#'     columns:
#'    * destination_id
#'    * destination_name
#'    * destination_slug
#'    * park_id
#'    * park_name
#' @export
get_destinations <- function() {
  response <- httr::RETRY(
    verb = "GET",
    url = "https://api.themeparks.wiki/v1/destinations"
  )

  httr::stop_for_status(response)
  content <- httr::content(response, encoding = "UTF-8")
  content$destinations |>
    purrr::map(function(dest) {
      parks <- dest$parks %||% list()
      parks_df_list <- purrr::map(parks, function(park) {
        tibble::tibble(
          destination_id = dest$id %||% NA,
          destination_name = dest$name %||% NA,
          destination_slug = dest$slug %||% NA,
          park_id = park$id,
          park_name = park$name
        )
      })
      do.call(rbind, parks_df_list)
    }) -> destinations_list
  do.call(rbind, destinations_list)
}
