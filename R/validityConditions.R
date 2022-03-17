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
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
#' validityConditions(conditions, model = "modelLinear")
setGeneric("validityConditions", function(conditions, model) standardGeneric("validityConditions"))
setMethod("validityConditions", signature(conditions = "data.frame", model = "character"), function(conditions, model) {
  #Restrtiction on variable names
  ##Access variable names of the model
  varModel <- variableModel(model)
  
  ##Access variable names in conditions
  colConditions <- colnames(conditions)
  varConditions <- setdiff(colConditions,"time")

  ###Ensure time is present in conditions columns
  if(!("time" %in% colConditions)){
    stop("Conditions data.frame must have one column named time")
  }
  ###Ensure param and control are excluded from conditions variables
  if(any(c("param", "control") %in% varConditions)){
    stop("Both param and control are reserved terms in models and should not be used in conditions")
  }
  
  ##Ensure equality between variable names of conditions and the model
  if(length(setdiff(varModel , varConditions)) != 0){
    stop("Variable names of the model differ from column names of conditions")
  }
  
  ##Restriction on conditions dataframe values
  #Ensure time has no NA
  if(any(is.na(conditions$time))){
    stop("Conditions time cannot includes NA")
  }
  
  #Ensure time is unique
  if(length(conditions$time) != length(unique(conditions$time))){
    stop("Conditions time must have unique values")
  }
  
  #Ensure time is strictly increasing and unique
  logicalOrder <- all(order(conditions$time) == seq_len(length(conditions$time)))
  if(!logicalOrder){
    stop("Conditions time must be in an increasing order")
  }
  
  #Ensure time encompasses zero
  if(!(min(conditions$time) <= 0 & max(conditions$time) >= 0)){
    stop("Conditions time must encompasses zero")
  }

  return(TRUE)
})


