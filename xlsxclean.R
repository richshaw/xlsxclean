## Global vars for easy editing by user
defaultFrom = c("Please.enter.your.preferred.username.below.(please.limit.it.to.20.characters).","Please.enter.your.first.name.","Please.enter.your.email.address.below.")
defaultTo = c("Screen Name","First Name","Email")
## Alternative default froms
defaultFrom2 = c("Screen.Name","First.Name","Email")

## Helper functions

## Tests for required packages
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}


## Test excel package exists and try install
pkgTest("openxlsx")
## Enable Excel library
library("openxlsx")


#Wraper for read function
xlsxread <- function(file,sheet = 1, startRow = 1, colNames = TRUE,skipEmptyRows = TRUE)
{
  ## Read and return Excel data file
  read.xlsx(xlsxFile = file, sheet = sheet, startRow = startRow, colNames = colNames,skipEmptyRows = skipEmptyRows)
}

## Subsets & renames XLSX columns and returns CSV file
xlsxclean <- function(data,
                      from = defaultFrom,
                      to = defaultTo)
{
  
  ## Default from cols
  ##"Please.enter.your.email.address.below."
  ##"Please.enter.your.first.name."
  ##"Please.enter.your.preferred.username.below.(please.limit.it.to.20.characters)."   
  
  ## Default to cols
  ## Required columns: "Screen Name"  "First Name"  "Email"  
  ## Optional columns: "Gender"	"City"	"Segment"	"(Age)"	"(ID)"	"(Panel)"

  ## Select needed data 
  data <- subset(data, select = from)
  ## Relabel columns from - to
  names(data)[match(from,names(data))] <- to
  
  ## Remove NA's
  data <- na.omit(data)
  
  ## Return data
  data
}



