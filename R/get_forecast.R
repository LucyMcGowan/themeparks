#' Get forecast
#'
#' @param entity_id Character. Either the GUID or the slug string for a given
#'     entity.
#'
#' @return A data frame of forecast data with three columns:
#'    * time
#'    * wait_time
#'    * percentage
#' @export
#'
get_forecast <- function(entity_id) {
  data <- get_entity_live_data(entity_id, verbose = FALSE)
  check_attraction(data)
  data$forecast[[1]] |>
    tibble::as_tibble() |>
    janitor::clean_names()
}
