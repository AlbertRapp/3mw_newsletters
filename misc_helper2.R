setwd(here::here())
directories <- list.files() |> 
  stringr::str_subset('[0-9]{1,}\\_')

first_to_be_moved <- 57
last_prescheduled_number <- readr::parse_number(directories) |> max()
regex_numbers <- paste0(
  first_to_be_moved:last_prescheduled_number, 
  collapse = '|'
)


to_be_moved_dirs <- stringr::str_subset(
  directories, 
  paste0('(', regex_numbers, ')\\_')
)

last_newsletter_dir <- to_be_moved_dirs[length(to_be_moved_dirs)]
last_newsletter_date <- last_newsletter_dir |> 
  stringr::str_remove(paste0(last_prescheduled_number, '_')) |> 
  lubridate::parse_date_time(orders = 'mdy')


new_date <- last_newsletter_date + lubridate::days(7)
new_day <- lubridate::day(new_date) |> stringr::str_pad(2, pad = '0')
new_month <- month.abb[lubridate::month(new_date)]
new_year <- lubridate::year(new_date)

new_dir_name <- paste(
  last_prescheduled_number + 1, 
  new_month, 
  new_day, 
  new_year, 
  sep = '_'
)


involved_dirs <- c(new_dir_name, rev(to_be_moved_dirs))

for (i in seq_along(involved_dirs[-length(involved_dirs)])) {
  old_dir_name <- involved_dirs[i + 1]
  new_dir_name <- involved_dirs[i]
  old_qmd_file_path <- paste0(old_dir_name, '/', old_dir_name, '.qmd')
  new_qmd_file_path <- paste0(new_dir_name, '/', new_dir_name, '.qmd')
  
  if (!dir.exists(new_dir_name)) dir.create(new_dir_name)
  print(glue::glue('From {old_qmd_file_path} to {new_qmd_file_path}'))
  file.copy(
    from = old_qmd_file_path, 
    to = new_qmd_file_path,
    overwrite = TRUE
  )
}









