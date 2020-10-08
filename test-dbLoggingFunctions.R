
########### this is a plumber api example to run in rstudio server pro ########
# you can "error out" the database by altering one of the database inputs like dbname or host to test the csv logging



#
#
# library(plumber)
# library(dplyr)
# library(purrr)
# library(lubridate)
# library(magrittr)
# library(pins)
# library(RPostgres)
# library(DBI)
# library(digest)
# library(stringr)
# library(tidyverse)
#
# source("test/funs.R")
#
# #* @apiTitle test
#
#
#
# #* Log information about incoming request
# #* @filter logger
#
# function(req){
#
#   temp <- RequestLogging(req = req, drv = Postgres(), dbname = "datascience", host = "642-452-dataccience-stag.postgres.database.azure.com",
#                          port = 5432, user = Sys.getenv('DB_USER'), password = Sys.getenv('DB_PASS'), db_table_name = "test_req_log",
#                          csv_file_name = "test/test_req_log.csv")
#
#   con <<- temp$con
#
#   key <<- temp$key
#
#   db_valid <<- temp$db_valid
#
#   forward()
# }
#
#
#
#
# #* Return the sum of two numbers
# #* @param a The first number to add
# #* @param b The second number to add
# #* @post /sum
# function(a, b, res) {
#
#   if(nchar(a) <= 4 | nchar(b) <= 4){
#
#     res$status <- 400
#
#     msg <- paste(res$status, "Please keep the digits to more than 4")
#
#     ErrorLogger(db_valid = db_valid, key = key, error_message = msg, input_error = c(a, b),
#                 db_connection = con, db_error_table = "test_error_table", csv_error_table = "test/test_error_table.csv")
#
#     return(msg)
#
#   } else {
#
#     sums <- as.numeric(a) + as.numeric(b)
#
#   }
#
#   return(sums)
# }
#
#
#
#
#
#
#
