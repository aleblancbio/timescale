#' @title Model validity
#' @description Check the validity of a rate model for scaling time.
#' @param model \code{character} corresponding to the name of the rate model.
#' @return Return \code{TRUE} if the model is valid, return an error otherwise.
#' @details Variables in the model are all function inputs excluding \code{param} and \code{control}. The function test that: 
#' (1) code{time} is not a variable of the model;
#' (2) the model has at least one variable.
#' @export
#' @example
#' validityModel(model = "modelLinear")
#' 
setGeneric("validityModel", function(model) standardGeneric("validityModel"))
setMethod("validityModel", signature(model = "character"), function(model) {
  #Access variable names in model
  varModel <- variableModel(model)
  
  #Restriction on the model
  ##Ensure at least one variable is present in the model
  if(length(varModel) == 0){
    stop("At least one variable must be present in the model")
  }
  ##Ensure time is not present as a model variable name
  if("time" %in% varModel){
    stop("The time cannot be used as a model variable")
  }
  
  return(TRUE)
})
