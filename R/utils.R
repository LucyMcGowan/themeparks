json_to_tibble <- function(content) {
  jsonlite::fromJSON(content, flatten = TRUE) |>
  replace_empty_with_na() |>
  as.data.frame() |>
  tibble::as_tibble() |>
  janitor::clean_names()
}

replace_empty_with_na <- function(x) {
  if (is.list(x)) {
    if (length(x) == 0) {
      return(NA)
    }
    return(lapply(x, replace_empty_with_na))
  } else {
    return(x)
  }
}

check_year_month <- function(year, month) {
  if (is.null(year) || is.null(month)) {
    cli::cli_abort("Parameters {.var year} and {.var month} must
                   both be present if one is.")
  }
  if (!is.numeric(year)) {
    cli::cli_abort(c(
      "{.var year} must be a numeric vector",
      "x" = "You've supplied a {.cls {class(year)}} vector."
    ))
  }
  if (!is.numeric(month)) {
    cli::cli_abort(c(
      "{.var month} must be a numeric vector",
      "x" = "You've supplied a {.cls {class(month)}} vector."
    ))
  }
  if (month > 12 || month < 1) {
    cli::cli_abort(c(
      "{.var month} must be a numeric vector between 1 and 12"
    ))
  }

}

check_attraction <- function(data) {
  if (all(data$entity_type != "ATTRACTION")) {
    cli::cli_abort(c("This function is intended for attractions, ",
                     "the entity you input is of type {data$entity_type})")
    )

  }
}
check_entity_id <- function(entity_id) {
  return(entity_id)
}
