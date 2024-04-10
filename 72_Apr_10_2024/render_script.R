setwd(here::here('72_Apr_10_2024'))
library(tidyverse)
city_values <- c(
  "Chicago, IL", 
  "Milwaukee, WI", 
  "New York City, NY", 
  "Los Angeles, CA", 
  "San Francisco, CA"
) |>
  str_replace_all(" ", "_") |>
  str_replace_all(",", "")

walk(
  city_values,
  \(x) quarto::quarto_render(
    input = 'template.qmd',
    output_file = glue::glue('{x}.html'),
    execute_params = list(
      selected_city_value = x
    )
  )
)