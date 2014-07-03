# Server side code

library(shiny)

source("xlsxclean.R")

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
    
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects and uploads a 
    # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
    # columns. The 'datapath' column will contain the local filenames where the 
    # data can be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    # Shiny upload strips the file extension
    # But OpenXLSX insits that the file have an ".xlsx" extension
    # So we rename the uploaded file and pass its pass to openXLSX
    path <- paste(inFile$datapath,".xlsx")
    file.rename(from=inFile$datapath, to=path)
    xlsxclean(path)
  })
  
})

