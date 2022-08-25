#' @title Validate if proper length
#' @description Check that a vector \code{x} is of specified length (\code{value}) and return an error otherwise.
#' @inheritParams base::length
#' @param name variable name to return in the error message
#' @return Return \code{TRUE} if the condition is respected and an error otherwise.
#' @export
#' @examples
#' x <- c(1,2,3)
#' validityLength(x, 3, name = "w")
#' validityLength(x, 4, name = "w")
#'
setGeneric("validityLength", function(x, value, name) standardGeneric("validityLength"))
setMethod("validityLength", signature(name = "character"), function(x, value, name) {
  
  logicalLength <- length(x) == value
  if(!logicalLength){
    message <- paste0("Inappropriate length for ", name, " (is ", length(x), " and should be ", value, ")")
    stop(message)
  }
  return(TRUE)
})



