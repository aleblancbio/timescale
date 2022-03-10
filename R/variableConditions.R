#' @title Model variables
#' @description Access variable from conditions data.frame.
#' @param conditions \code{data.frame} with \code{time} and variables as other columns.
#' @return Return \code{character} vector made of the variable names.
#' @export
#' @example
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5))
#' variableConditions(conditions)
setGeneric("variableConditions", function(conditions) standardGeneric("variableConditions"))
setMethod("variableConditions", signature(conditions = "data.frame"), function(conditions) {
  #Access variable names of conditions
  colConditions <- colnames(conditions)
  varConditions <- setdiff(colConditions,"time")
  
  return(varConditions)
})


