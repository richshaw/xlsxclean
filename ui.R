# UI

library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("XLSX Organizer"),
  
  sidebarPanel(
    fileInput('file1', 'Choose Excel File',
              accept=c('.xlsx')),
    tags$hr(),
    
    numericInput("sheet", "Worksheet:", 1,
                 min = 1, max = 100),
    
    numericInput("startRow", "Start at row:", 1,
                 min = 1, max = 1000),
    
    checkboxInput("skipEmptyRows", "Skip empty rows", TRUE),
    
    tags$hr(),
    
    tags$label('From'),
    tags$textarea(id="from", rows=3, cols=40),
    
    tags$label('To'),
    tags$textarea(id="to", rows=3, cols=40),
    
    tags$hr(),
    
    actionButton("cleanButton", "Clean"),
    downloadLink('downloadCleanedData', 'Download')
    
  ),
  
  mainPanel(
    
    tableOutput('contents')
  
    
  )
))