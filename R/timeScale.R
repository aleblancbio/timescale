#' @title Time scale
#' @description Evaluate the time elapsed between two bounds (x1, x2) into a scaled domain given a rate model and condtions that represent its variables.
#' @param x1 \code{numeric} vector of initial time from which evaluate the scaling
#' @param x2 \code{numeric} vector of final time until which evaluate the scaling
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method for conditions. Available methods include \code{constant} and \code{linear}.
#' @return Return a vector of the same length as \code{x1} and \code{x2} representing the scaled time elapsed between those values.
#' @details Note that \code{x1} and \code{x2} must be in the time range provided by conditions.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5))
#' condModel <- interpolateCond(conditions, method = "linear")
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' x1 = seq(1,10,length.out = 10)
#' x2 = seq(10,20,length.out = 10)
#' timeScale(x1, x2, model = model, conditions = conditions, param = param, interpolation = "linear")
#'
setGeneric("timeScale", function(x1, x2, model , conditions, param = list(), control = list(), interpolation = "linear", inverse = FALSE) standardGeneric("timeScale"))
setMethod("timeScale", signature(x1 = "numeric", x2 = "numeric", model = "character", conditions = "data.frame"), function(x1, x2, model, conditions, param, control, interpolation, inverse) {
  #Validity checks
  validityModel(model)
  validityConditions(conditions, model)
  validityTime(x1, conditions)
  validityTime(x2, conditions)
  
  #Interpolation of conditions and composition with Model
  condModel <- interpolateCond(conditions, method = interpolation)
  compModel <- compoundModel(model, condModel, param = param, control = control)
  
  #Direct case
  ##Integration
  xScaled <- vectIntegrate(f = compModel, lower = x1, upper = x2,  subdivisions=2000)

  #Inverse case
  if(inverse){
    ##

    
  }
  
  return(xScaled)
})
