#' @title Compatibility of conditions and models
#' @description Test that conditions is compatible with a rate model to scale time.
#' @param conditions \code{data.frame} with \code{time} and variables expected to correspond to those of the model.
#' @param model \code{character} corresponding to the name of the rate model.
#' @return Return \code{TRUE} if the conditions and models are compatibles and can be used to scale time, return an error otherwise.
#' @details Variables in the model are all function inputs excluding \code{param} and \code{control} and those of conditions are the column names except \code{time}. The function test that: 
#' (1) variable names are the same in the model and conditions; 
#' (2) code{time} is part of column names of conditions but is not a variable of the model;
#' (3) column names of conditions are not code{param} and \code{control}, as those are reserved terms of the model function;
#' (4) model has at least one variable.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5))
#' compatibility(conditions, model = "modelLinear")
#' 
setGeneric("compatibility", function(conditions, model) standardGeneric("compatibility"))
setMethod("compatibility", signature(conditions = "data.frame", model = "character"), function(conditions, model) {
  #Access variable names in model
  inputModel <- names(formals(get(model)))
  varModel <- setdiff(inputModel, c("param","control"))
  
  #Access variable names in conditions
  colConditions <- colnames(conditions)
  varConditions <- setdiff(varModel,"time")
  
  #Restriction on the model
  ##Ensure at least one variable is present in the model
  if(length(varModel) == 0){
    stop("At least one variable must be present in the model")
  }
  ##Ensure time is not present as a model variable name
  if("time" %in% varModel){
    stop("The time cannot be used as a model variable")
  }
  
  #Restriction on conditions dataframe
  ##Ensure time is present in conditions columns
  if(!("time" %in% colConditions)){
    stop("Conditions data.frame must have one column named time")
  }
  ##Ensure param and control are excluded from conditions variables
  if(any(c("param", "control") %in% varConditions)){
    stop("Both param and control are reserved terms in models and should not be used in conditions")
  }
  
  #Ensure equality between variable names
  if(length(setdiff(varModel , varConditions)) != 0){
    stop("Variable names of the model differ from column names of conditions")
  }
  
  return(TRUE)
})


