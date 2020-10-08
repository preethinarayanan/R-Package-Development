#' Unit Testing Function
#'
#' @description This function look for objects in R/SQL environment and report the details of the objects if exist
#'
#' @param objects a character string of an object or a list of objects to test. Objects to test can be dataframe, vector, list, tibble, function, etc. For functions, you must enter your parameters.
#' @param test_types a character string or a vector of the test desired. Possible test type can be "class" = class of object, "col" or "row" = number of columns or rows, "length" = length of object, "unique" = if all unique factor are the same, "function" for testing functions.
#' @param expectations a value/character string or a vector of values of expectations of the test
#' @param num_test a value of number of test desired; default is 1. For example, if num_test = 2, there has to be 2 objects, test_types, and expectations.
#' @param envr a character value of an environment. Current available environments are "r" and "pins"; default is "r".
#' @param pins_board a character string of a name of a board your object was pinned to
#'
#' @import tidyverse
#' @import testthat
#' @import pins
#'
#' @return returns test results
#' @export
#'
#' @example
#'
#' # Create a sample data.frame to test inside an R script at a desired destination
#' # Name the R testing script with "test-" as the first word. For example, "test-my-objects.R"
#' testing_data <- data.frame('letters'=c('a', 'b', 'c', 'd'), 'numbers'=seq(1, 4))
#'
#' # Create all desired tests inside the script
#' ## Run
#' # Execute all test store at desire directory
#' testthat::test_dir("the/path/to/my/test/script/")
#'
#' ## Not Run
#' ## Sample of tests can be added in testing script
#' # Successful test responses
#' UnitTesting(testing_data, "class", "data.frame")
#' UnitTesting(testing_data, "ncol", 2)
#'
#' # A failed test response
#' UnitTesting(testing_data, "columns", 3)
#'
#' # More than one test with both success and fail response
#' UnitTesting(objects = list(testing_data, testing_data, testing_data),
#'             test_types = c("class", "col", "columns"),
#'             expectations = c("tbl", 2, 2),
#'             num_test = 3)
#'
#' # Sample of testing factor levels
#' UnitTesting(objects = testing_data$letters, "unique", c("a", "b", "c", "d"))
#'
#' ## Not Run End
#'
#' # Testing function
#' # Write a sample function
#' testing_function <- function(x){x + 1}
#'
#' # Test if function has the same output as expected output
#' UnitTesting(testing_function(1), "function", 2)
#'
#' # Testing object from pins
#' # Make sure you're connected to a server first
#' # pins::board_register_rsconnect(server, version = TRUE)
#' # use default server from R Studio without registering
#'
#' UnitTesting(objects = "A3/housing", "class", expectations = "data.frame", envr = "pins", pins_board = "packages")
#'


UnitTesting <- function(objects, test_types, expectations, num_test = 1, envr = "r", pins_board){

  ## assign objects to a list if there is a single test
  if(num_test == 1){
    objects <- list(objects)
    test_types <- list(test_types)
    expectations <- list(expectations)
  }

  for (i in 1:num_test){
    ## separate each test into a set
    set <- list(objects = objects[[i]],
                test_types = test_types[[i]],
                expectations = expectations[[i]])

    if (envr == "pins"){
      # get object from pins
      set$objects <- pin_get(set$objects, board = pins_board)
    }

    ## Test for class of the object
    if(set$test_types == "class"){
      my_test <- class(set$objects)
      my_expectation <- set$expectations

      test_that(paste("Is the class of my object", i, "as expected"), {
        expect(my_expectation %in% my_test,
               failure_message = "Expected class and test are not the same")
      })
    } else if (set$test_types == "unique" & is.vector(set$objects)) {
      my_test <- sort(unique(set$objects))
      my_expectation <- sort(unique(set$expectations))

      test_that(paste("Is the unique values for my vector object", i, "as expected"), {
        expect_identical(my_expectation, my_test)
      })
    } else if (set$test_type == "function"){
      my_test <- set$objects
      my_expectation <- set$expectations

      test_that(paste("Does my function", i, "as expected", set$test_types), {
        expect_equal(my_test, my_expectation)
      })
    } else {

      ## change class to numeric
      my_expectation <- as.numeric(set$expectations)

      if (set$test_types == "col"){
        my_test <- ncol(set$objects)
      } else if (set$test_types == "row"){
        my_test <- nrow(set$objects)
      } else if (set$test_types == "length"){
        my_test <- length(set$objects)
      }

      test_that(paste("Does my object", i, "as expected", set$test_types), {
        expect_equal(my_test, my_expectation)
      })
    }
  }
}
