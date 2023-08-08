setwd(here::here())
directories <- list.files() |> 
  stringr::str_subset('[0-9]{1,}\\_')

last_newsletter_number <- stringr::str_split(directories, '_') |> 
  purrr::map_chr(1) |> 
  readr::parse_number() |> 
  max()

last_newsletter_dir <- stringr::str_subset(directories, as.character(last_newsletter_number))
last_newsletter_date <- last_newsletter_dir |> 
  stringr::str_remove(paste0(last_newsletter_number, '_')) |> 
  lubridate::parse_date_time(orders = 'mdy')

new_date <- last_newsletter_date + lubridate::days(7)
new_day <- lubridate::day(new_date) |> stringr::str_pad(2, pad = '0')
new_month <- month.abb[lubridate::month(new_date)]
new_year <- lubridate::year(new_date)

new_dir_name <- paste(
  last_newsletter_number + 1, 
  new_month, 
  new_day, 
  new_year, 
  sep = '_'
)

if (!dir.exists(new_dir_name)) dir.create(new_dir_name)
new_qmd_file_path <- paste0(new_dir_name, '/', new_dir_name, '.qmd')
if (!file.exists(new_qmd_file_path)) {
  file.create(new_qmd_file_path)
  file_conn <- file(new_qmd_file_path, open = 'a+')
  writeLines(
    c(
      "", "", "```{r}", 
      glue::glue("setwd(here::here('{new_dir_name}'))"), 
      "library(tidyverse)",
      "```"
    ), 
    file_conn
  )
  close(file_conn)
}
rstudioapi::navigateToFile(new_qmd_file_path)
