## Global vars for easy editing by user
defaultFrom = c("Please.enter.your.preferred.username.below.(please.limit.it.to.20.characters).","Please.enter.your.first.name.","Please.enter.your.email.address.below.")
defaultTo = c("Screen Name","First Name","Email")
## Alternative default froms
defaultFrom2 = c("Screen.Name","First.Name","Email")

## Subsets & renames XLSX columns and returns CSV file
xlsxclean <- function(file,
                      from = defaultFrom,
                      to = defaultTo,
                      sheet = 4, startRow = 4, colNames = TRUE,skipEmptyRows = TRUE,saveFile = "output.csv")
{
  ## Test excel package exists and try install
  pkgTest("openxlsx")
  ## Enable Excel library
  library("openxlsx")
  
  ## Read Excel data file
  data <- read.xlsx(file, sheet = sheet, startRow = startRow, colNames = colNames,skipEmptyRows = skipEmptyRows)
  
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
  
  write.csv(data, file = saveFile, row.names=FALSE)
}

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