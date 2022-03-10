#' @title Model variables
#' @description Access variable from a rate model function.
#' @param model \code{character} corresponding to the name of the rate model.
#' @return Return \code{TRUE} if the conditions and models are compatibles and can be used to scale time, return an error otherwise.
#' @details Variables in the model are all function inputs excluding \code{param} and \code{control}.
#' @export
#' @example
#' variableModel(model = "modelLinear")
#' 
setGeneric("variableModel", function(model) standardGeneric("variableModel"))
setMethod("variableModel", signature(model = "character"), function(model) {
  #Access variable names in model (given its structure)
  inputModel <- names(formals(get(model)))
  variableModel <- setdiff(inputModel, c("param","control"))
 
  return(variableModel)
})


