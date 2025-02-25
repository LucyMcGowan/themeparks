#' Get entity document
#'
#' @param entity_id Either the GUID or the slug string for a given entity
#' @return A data frame with details about the given entity
#' @examples
#' ## Entity data for Walt Disney World
#' \donttest{
#' get_entity("waltdisneyworldresort")
#' }
#' @export
get_entity <- function(entity_id) {
  check_entity_id(entity_id)
  response <- httr::GET(
    url = glue::glue("https://api.themeparks.wiki/v1/entity/{entity_id}")
  )

  httr::stop_for_status(response)
  content <- httr::content(response, encoding = "UTF-8", type = "text")
  json_to_tibble(content)
}

#' Get entity children
#'
#' Get all children for a given entity document
#'
#' This is recursive, so a destination will return all parks and all rides
#' within those parks.
#' @param entity_id Either the GUID or the slug string for a given entity
#' @return A data frame with details about the given entity's children
#' @examples
#' ## Entity children data for Walt Disney World
#' \donttest{
#' get_entity_children("waltdisneyworldresort")
#' }
#' @export


get_entity_children <- function(entity_id) {
  check_entity_id(entity_id)
  response <- httr::GET(
    url = glue::glue("https://api.themeparks.wiki/v1/entity/{entity_id}/children")
  )

  httr::stop_for_status(response)
  content <- httr::content(response, encoding = "UTF-8", type = "text")
  json_to_tibble(content)
}

#' Get entity live data
#'
#' Get an entity's live data (wait times, availability, parade times, etc.) as
#' well as for all child entities.
#'
#' @param entity_id Character. Either the GUID or the slug string for a given
#'     entity.
#' @param verbose Logical. Whether you would like messages to print in the
#'     console.
#' @return A data frame with live data for the entity
#' @examples
#' ## Live data for Walt Disney World
#' \donttest{
#' get_entity_live_data("waltdisneyworldresort")
#' }
#' @export
get_entity_live_data <- function(entity_id, verbose = TRUE) {
  check_entity_id(entity_id)
  response <- httr::GET(
    url = glue::glue("https://api.themeparks.wiki/v1/entity/{entity_id}/live")
  )
  httr::stop_for_status(response)
  content <- httr::content(response, encoding = "UTF-8", type = "text")
  lst <- jsonlite::fromJSON(content, flatten = TRUE)
  if (verbose) {
    cli::cli_alert_info("Pulling live data for {lst$name}")
  }
  lst$liveData |>
    tibble::as_tibble() |>
    janitor::clean_names()
}

#' Get entity schedule
#'
#' Get this entity's schedule for the next 30 days
#' @param entity_id Either the GUID or the slug string for a given entity
#' @param year Numeric. Year for entity schedule (if `NULL` will default to
#'    current year)
#' @param month Numeric. Month for entity schedule (if `NULL` will default to
#'    current month)
#' @return A data frame with schedule data for the entity
#' @examples
#' ## Schedule data for Walt Disney World
#' \donttest{
#' get_entity_schedule("waltdisneyworldresort")
#' }
#' @export
get_entity_schedule <- function(entity_id, year = NULL, month = NULL) {
  check_entity_id(entity_id)
  if (is.null(year) && is.null(month)) {
    response <- httr::GET(
      url = glue::glue("https://api.themeparks.wiki/v1/entity/{entity_id}/schedule")
    )
  } else {
    check_year_month(year, month)

    response <- httr::GET(
      url = glue::glue("https://api.themeparks.wiki/v1/entity/{entity_id}/schedule/{year}/{sprintf('%02d', month)}")
    )
  }
  httr::stop_for_status(response)
  content <- httr::content(response, encoding = "UTF-8", type = "text")
  lst <- jsonlite::fromJSON(content, flatten = TRUE)
  if (lst$entityType == "DESTINATION") {
    data <- lst$parks |>
      tibble::as_tibble() |>
      janitor::clean_names()
    return(data)
  } else if (lst$entityType %in% c("PARK")) {
    data <- lst$schedule |>
      tibble::as_tibble() |>
      janitor::clean_names()
    return(data)
  } else {
    cli::cli_alert_info(c("Your entity was of type {lst$entityType}; we do not",
                          " know of a schedule for these types."))
  }

}
