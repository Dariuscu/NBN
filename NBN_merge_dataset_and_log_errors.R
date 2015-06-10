# Author: Dario Rodriguez
# Date started: 10/02/2015
# Date finalised: 11/02/2015
# Scope: Merge a NBN dataset with the log error in order to get an error spreadsheet for
#the data provider
# Constraints: the log file must have the extension .txt
# --------------------------------------------------------------------------------------------------

# Load library to work with Excel
library(xlsx)

# Clear any previous data
rm(list=ls())

# Set the working directory to the folder where I have the Marine Resource Planner
setwd("Z:/Programme 110 Access to information/0103 NBN & GBIF/NBN Gateway service/OFFICIAL SENSITIVE/DATA/Ongoing")

# 1) First file to import will be the dataset itself
dataset <- read.csv(file.choose(), header = TRUE, sep = '\t', quote = NULL, colClasses = "character", stringsAsFactors = FALSE)

# 2) Second file to import will be the log file
log_file <- read.csv(file.choose(), header=FALSE, quote = "", colClasses = "character", stringsAsFactors = FALSE)
names(log_file) = c("RecordKey", "Error")

# Make sure that the column RecordKey is spelled like this in the first column of the dataset
colnames(dataset)[1] <- "RecordKey"

# Merge dataset and log_file on the RecordKey to bring the errors
mergedata <- merge(dataset, log_file)

# Export merged data into a spreadsheet
outwb <- createWorkbook()
saveWorkbook(outwb, "Errors_to_be_corrected.xlsx")
file <- "Errors_to_be_corrected.xlsx"

write.xlsx(mergedata, file, sheetName="Errors", col.names = TRUE, row.names=FALSE, append=TRUE)