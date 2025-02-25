#' Get Wait Times
#'
#' @param entity_id Character. Either the GUID or the slug string for a given
#'     entity.
#'
#' @return A data frame with three columns:
#'   * park
#'   * name
#'   * wait time
#' @export
#'
#' @examples
#' ## Get wait time for the Jungle Cruise
#' \donttest{
#' get_wait_times("junglecruise")
#' }
get_wait_times <- function(entity_id) {
  data <- get_entity_live_data(entity_id, verbose = FALSE)
  check_attraction(data)
  data <- tibble::tibble(
    name = data$name,
    wait_time = data$queue_standby_wait_time
  )
  data[!is.na(data$wait_time), ]
}
