# UI

library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("XLSX Muncher"),
  
  sidebarPanel(
    fileInput('file1', 'Choose Excel File',
              accept=c('.xlsx')),
    tags$hr(),
    
    downloadButton('downloadData', 'Download')
    
  ),
  
  mainPanel(
    
    tableOutput('contents')
  
    
  )
))