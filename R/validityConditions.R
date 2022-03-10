#' @title Conditions validity
#' @description Check the validity of conditions with respect to its structure and compatibility with a rate model for scaling time.
#' @param conditions \code{data.frame} with \code{time} and variables expected to correspond to those of the model.
#' @param model \code{character} corresponding to the name of the rate model.
#' @return Return \code{TRUE} if the conditions are compatibles with the model, return an error otherwise.
#' @details Variables in the model are all function inputs excluding \code{param} and \code{control} and those of conditions are the column names except \code{time}. The function test that: 
#' (1) column names include \code{time};
#' (2) column names exclude \code{param} and \code{control}, as those are reserved terms of the model function;
#' (3) variable names are the same in the model and conditions.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5))
#' validityConditions(conditions, model = "modelLinear")
setGeneric("validityConditions", function(conditions, model) standardGeneric("validityConditions"))
setMethod("validityConditions", signature(conditions = "data.frame", model = "character"), function(conditions, model) {
  #Access variable names of the model
  varModel <- variableModel(model)
  
  #Access variable names in conditions
  colConditions <- colnames(conditions)
  varConditions <- setdiff(colConditions,"time")
  
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
  
  #Ensure time is strictly increasing and unique
  #ADD
  
  return(TRUE)
})


