#' @title Time scale
#' @description Evaluate the time elapsed between two bounds (x1, x2) into a scaled domain given a rate model and condtions that represent its variables.
#' @param x1 \code{numeric} vector of initial time from which evaluate the scaling
#' @param x2 \code{numeric} vector of final time until which evaluate the scaling
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method for conditions. Available methods include \code{constant} and \code{linear}.
#' @param inverse \code{logical} indicating if the inverse operation (i.e. scaled time to time transformation) should be performed.
#' @return Return a vector of the same length as \code{x1} and \code{x2} representing the scaled time elapsed between those values.
#' @details Note that \code{x1} and \code{x2} must be in the time range provided by conditions.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = 20+rnorm(10, 10, 5))
#' condModel <- interpolateCond(conditions, method = "linear")
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' x1 = rep(0,10,length.out = 10)
#' x2 = seq(11,20,length.out = 10)
#' z2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param, interpolation = "linear")
#' z1 <- rep(0,10,length.out = 10)
#' timeScale(z1, z2, model = model, conditions = conditions, param = param, interpolation = "linear", inverse = TRUE)
#'
setGeneric("timeScale", function(x1, x2, model , conditions, param = list(), control = list(), interpolation = "linear", inverse = FALSE) standardGeneric("timeScale"))
setMethod("timeScale", signature(x1 = "numeric", x2 = "numeric", model = "character", conditions = "data.frame"), function(x1, x2, model, conditions, param, control, interpolation, inverse) {
  #Validity checks
  validityModel(model)
  validityConditions(conditions, model)
  if(inverse){
    validityScaledTime(x1, model = model, conditions = conditions, param = param, interpolation = interpolation)
    validityScaledTime(x2, model = model, conditions = conditions, param = param, interpolation = interpolation)
  }else{
    validityTime(x1, conditions)
    validityTime(x2, conditions)
  }

  #Interpolation of conditions and composition with the model
  condModel <- interpolateCond(conditions, method = interpolation)
  compModel <- composeModel(model, condModel, param = param, control = control)
  
  if(inverse){
    #Inverse case
    ##Calculate time2-time1 (here as z2-z1) with scaled time x1 as reference, from scaled time x1 and x2
    z0 <- rep(0, length(x1))
    z1 <- timeShift(z0, scaledPeriod = x1, model = model, conditions = conditions, param = param, interpolation = interpolation)
    z2 <- timeShift(z0, scaledPeriod = x2, model = model, conditions = conditions, param = param, interpolation = interpolation)
    z <- z2 - z1
  }else{
    #Direct case
    ##Caclculate scaled time z2-z1 with time x1 as reference, from time x1 and x2
    ##Integration
    z <- vectIntegrate(f = compModel, lower = x1, upper = x2,  subdivisions=2000)
  }

  return(z)
})
