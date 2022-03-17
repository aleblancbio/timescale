#' @title Time validity
#' @description Check that a time vector (\code{x}), is included in the range of \code{conditions} time.
#' @param x \code{numeric} vector representing time.
#' @param conditions \code{data.frame} with \code{time} and variables expected to correspond to those of the model.
#' @return Return \code{TRUE} if the condition is respected and an error otherwise.
#' @details The check serve to ensure conditions can be represented through interpolation on \code{x}.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5))
#' validityTime(x = 1:10,conditions)
setGeneric("validityTime", function(x, conditions) standardGeneric("validityTime"))
setMethod("validityTime", signature(x = "numeric", conditions = "data.frame"), function(x, conditions) {
  #Ensure x is within bounds of the time variable from conditions
  logicalWithinBounds <- (x >= min(conditions$time)) & (x <= max(conditions$time))
  if(!all(logicalWithinBounds)){
    stop("Values of x must be in the range of conditions time")
  }

  return(TRUE)
})


