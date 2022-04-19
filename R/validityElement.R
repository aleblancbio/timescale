#' @title Validate if is element
#' @description Check that all values of a vector \code{x} is element of values of \code{y} and return an error otherwise.
#' @inheritParams base::is.element
#' @param name variable name to return in the error message
#' @return Return \code{TRUE} if the condition is respected and an error otherwise.
#' @export
#' @examples
#' x <- c(1,2,3)
#' y <- c(2,3)
#' z <- c(1,2,3,4)
#' validityElement(x, y, name = "w")
#' validityElement(x, z, name = "w")

setGeneric("validityElement", function(x, y, name) standardGeneric("validityElement"))
setMethod("validityElement", signature(name = "character"), function(x, y, name) {
  
  logicalElement <- all(is.element(x,y))
  if(!logicalElement){
    message <- paste0("Innapropriate values for ", name)
    stop(message)
  }
  return(TRUE)
})



