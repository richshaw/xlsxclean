# Server side code

library(shiny)

source("xlsxclean.R")

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output,session) {
    
  path <- reactive({

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
    
    path
  })
  
  
  data <- reactive({
    
    if (is.null(path()))
      return(NULL)
    
    data <- xlsxread(path(),sheet = input$sheet, startRow = input$startRow, colNames = TRUE,skipEmptyRows = input$skipEmptyRows)
    
    c <- colnames(data)
    c <- paste(c, collapse = ',')
    
    updateTextInput(session, "from", value = c)
    updateTextInput(session, "to", value = c)
    
    data
    
    })
  
  clean <- reactive({
    # Don't do anything until after the first button push.
    if (input$cleanButton == 0)
      return(NULL)
    
    # Note that just by virtue of checking the value of input$cleanButton,
    # we're now going to get called whenever it is pushed.
    
    return(isolate({
      # Now do the expensive stuff
      from <- unlist(strsplit(input$from, split=","))
      to <- unlist(strsplit(input$to, split=","))
      
      data <- xlsxclean(data(),from,to)
    }))
  })
    
  output$contents <- renderTable({
    
    if (is.null(data()))
      return(NULL)
    
    if (input$cleanButton != 0)
      return(clean())
    
    data()
  })
  
  output$downloadCleanedData <- downloadHandler(    
    filename = function() { paste('data-', Sys.Date(), '.csv', sep='') },
    content = function(file) {

      if (is.null(clean()))
        return(NULL)
      
      write.csv(clean(), file)
    }
  )
  
})

