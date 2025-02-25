
<!-- README.md is generated from README.Rmd. Please edit that file -->

# themeparks

<!-- badges: start -->
<!-- badges: end -->

The goal of themeparks is to allow R users to access the themeparks.wiki
API.

## Installation

You can install the development version of themeparks like so:

``` r
devtools::install_github("LucyMcGowan/themeparks")
```

## Example

You can access the available destinations using the `get_destinations`
function:

``` r
library(themeparks)
get_destinations()
#> # A tibble: 92 × 5
#>    destination_id            destination_name destination_slug park_id park_name
#>    <chr>                     <chr>            <chr>            <chr>   <chr>    
#>  1 259cf011-6195-42dd-bfdb-… Guangzhou Chime… chimelongguangz… 73436f… Chimelon…
#>  2 259cf011-6195-42dd-bfdb-… Guangzhou Chime… chimelongguangz… 9a268a… Chimelon…
#>  3 259cf011-6195-42dd-bfdb-… Guangzhou Chime… chimelongguangz… a148a9… Chimelon…
#>  4 259cf011-6195-42dd-bfdb-… Guangzhou Chime… chimelongguangz… 7fa8dc… Chimelon…
#>  5 9c6a0987-e519-4d6e-b011-… Walibi Holland   walibiholland    18635b… Walibi H…
#>  6 6cc48df2-f126-4f28-905d-… Parc Asterix     parcasterix      9e9386… Parc Ast…
#>  7 c0eddd5b-da82-4161-9a5f-… Plopsaland De P… plopsaland-de-p… f0ea9b… Plopsala…
#>  8 119fce4a-9662-484f-ac3a-… California's Gr… californiasgrea… bdf9b5… Californ…
#>  9 8fba5a14-8d04-455c-acf8-… Silver Dollar C… silverdollarcity d21fac… Silver D…
#> 10 f9497403-adf3-4409-bd79-… Walibi Rhône-Al… walibirhonealpes 28aee1… Walibi R…
#> # ℹ 82 more rows
```

Once you have a destination in mind, you can find more information using
the `get_entity` function. For example, if I want to pull all entity
data for the Walt Disney World Resort, I can use the `slug` provided in
the above dataset (or the `id`).

``` r
get_entity("waltdisneyworldresort")
#> # A tibble: 1 × 9
#>   id     name  slug  location_latitude location_longitude location_points_of_i…¹
#>   <chr>  <chr> <chr>             <dbl>              <dbl> <lgl>                 
#> 1 e957d… Walt… walt…              28.4              -81.6 NA                    
#> # ℹ abbreviated name: ¹​location_points_of_interest
#> # ℹ 3 more variables: timezone <chr>, entity_type <chr>, external_id <chr>
```

If you would like to all of the available parks, attractions, dining,
and shows for a particular destination, you can use
`get_entity_children`.

``` r
get_entity_children("waltdisneyworldresort")
#> # A tibble: 518 × 12
#>    id                       name  entity_type timezone children_id children_name
#>    <chr>                    <chr> <chr>       <chr>    <chr>       <chr>        
#>  1 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 7f6e15e9-f… Hoop-Dee-Doo…
#>  2 e957da41-3552-4cf6-b636… Walt… DESTINATION America… d7618a38-f… Amare        
#>  3 e957da41-3552-4cf6-b636… Walt… DESTINATION America… a08d9f84-f… DiVine       
#>  4 e957da41-3552-4cf6-b636… Walt… DESTINATION America… d90f0556-5… Stir         
#>  5 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 51392ca4-f… Main Street …
#>  6 e957da41-3552-4cf6-b636… Walt… DESTINATION America… d3461b18-2… Pizza al Tag…
#>  7 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 796b0a25-c… Jungle Cruise
#>  8 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 99fc0f7d-6… Blue Ribbon …
#>  9 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 15107c34-6… Space 220 Lo…
#> 10 e957da41-3552-4cf6-b636… Walt… DESTINATION America… 7ad20d41-f… Planet Holly…
#> # ℹ 508 more rows
#> # ℹ 6 more variables: children_entity_type <chr>, children_slug <chr>,
#> #   children_parent_id <chr>, children_external_id <chr>,
#> #   children_location_longitude <dbl>, children_location_latitude <dbl>
```

If you would like to extract live data for a particular attraction, you
can use `get_entity_live_data`:

``` r
get_entity_live_data("junglecruise")
#> ℹ Pulling live data for Jungle Cruise
#> # A tibble: 1 × 13
#>   id       name  entity_type park_id external_id status forecast operating_hours
#>   <chr>    <chr> <chr>       <chr>   <chr>       <chr>  <list>   <list>         
#> 1 796b0a2… Jung… ATTRACTION  75ea57… 80010153;e… OPERA… <df>     <df [1 × 3]>   
#> # ℹ 5 more variables: last_updated <chr>, queue_standby_wait_time <int>,
#> #   queue_return_time_state <chr>, queue_return_time_return_end <lgl>,
#> #   queue_return_time_return_start <lgl>
```
