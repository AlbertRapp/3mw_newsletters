library(shiny)

habit_rowUI <- function(id, habit, even = FALSE) {
  ns <- NS(id)
  background_color <- if (even) '#e5e5e5' else 'white'
  tagList(
    div(
      style = htmltools::css(
        display = 'flex',
        background_color = background_color,
      ),
      div(
        # Add auto-margins and padding 
        # Also changed to css() for cleaner code
        style = htmltools::css(
          min_width = '125px', 
          padding_left = '20px', 
          margin_top = 'auto',
          margin_bottom =  'auto'
        ),
        habit
      ),
      div(
        style = htmltools::css(
          display = 'flex', 
          background_color = background_color,
          padding_top = '5px',
          padding_bottom = '5px'
        ),
        purrr::map(1:31, \(x) checkboxInput(
          # unique id for each day
          ns(paste0('checkbox', x)), '', 
          width = '50px'
        )
        )
      )
    )
  )
}

habit_rowServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = 'minty'),
  tags$style(
    '.form-check-input[type="checkbox"], .shiny-input-container .checkbox input[type="checkbox"], .shiny-input-container .checkbox-inline input[type="checkbox"], .shiny-input-container .radio input[type="checkbox"], .shiny-input-container .radio-inline input[type="checkbox"] {
    width:40px; height: 40px; margin: auto;}
    
    .form-check, .shiny-input-container .checkbox, .shiny-input-container .radio {
      margin: auto;
    }
    
    .shiny-input-container:not(.shiny-input-container-inline) {
      margin: auto; 
      display: flex;
    }'
  ),
  navbarPage(
    'Habit Tracker',
    tabPanel(
      'January',
      div(
        style = 'width: 1000px; overflow-x: scroll; scrollbar-width: thin;',
        
        div(
          style = 'display: flex',
          div(
            style = 'min-width:125px;',
            ''
          ),
          div(
            style = 'display: flex;',
            purrr::map(1:31, \(x) div(
              style = 'width:50px; text-align: center; font-weight:500;', 
              x)
            )
          )
        ),
        habit_rowUI('meditation', 'Meditation', even = TRUE),
        habit_rowUI('running', 'Running'),
        habit_rowUI('naps', 'Take Naps', even = TRUE),
        habit_rowUI('phd_stuff', 'Do PhD Stuff'),
        habit_rowUI('weird_habit', 'Weird habit', even = TRUE),
      )
    ),
    !!!purrr::map(month.name[-1], \(x) tabPanel(x))
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)