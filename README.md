xlsxclean
=========

Simple Shiny app for selecting and renaming Excel columns. Download the cleaned up file as CSV.


## Usage

When a XSLX file is uploaded the column headers of the worksheet you are looking will be loaded the *to* and *from* text boxes.

Each text box expects a comma separated list of column names of equal length.

Say I have a file with the headers

```
firstname,lastname,date,country
```

I want an output file that selects the *firstname* and *lastname* columns and renames them *fname* and *lname*.

From textbox would be

```
firstname,lastname,
```

To textbox would be

```
fname,lname,
```

Click the *clean* button to check the output and *download* to get the output as a CSV file.

##Demo

https://gouzout.shinyapps.io/xlsxclean/
