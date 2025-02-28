% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_entity.R
\name{get_entity_live_data}
\alias{get_entity_live_data}
\title{Get entity live data}
\usage{
get_entity_live_data(entity_id, verbose = TRUE)
}
\arguments{
\item{entity_id}{Character. Either the GUID or the slug string for a given
entity.}

\item{verbose}{Logical. Whether you would like messages to print in the
console.}
}
\value{
A data frame with live data for the entity
}
\description{
Get an entity's live data (wait times, availability, parade times, etc.) as
well as for all child entities.
}
\examples{
## Live data for Walt Disney World
\donttest{
get_entity_live_data("waltdisneyworldresort")
}
}
