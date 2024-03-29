#' @title Time shift
#' @description Evaluate the time elapsed between two bounds (x1, x2) into a scaled domain given a rate model and condtions that represent its variables.
#' @param x1 \code{numeric} vector of initial time from which evaluate the scaling
#' @param scaledPeriod \code{numeric} vector of period in the scaled domain to add to \code{x1}.
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method for conditions. Available methods only include \code{constant} at the moment and is the default value.
#' @param assignConstant \code{character} indicating how to assign scaled time to time when it remains constant on a time interval. Choices are \code{lower} and \code{upper} for both end of the interval.
#' @return Return a vector of the same length as \code{x1} and \code{x2} representing the scaled time elapsed between those values.
#' @details Note that \code{x1} and the calculated \code{x2} must be in the time range provided by conditions. See the details section of \code{timescale} for the structure of \code{conditions} and \code{model} and the calculation.
#' @import stringr
#' @export
#' @examples
#' #Setting entries
#' conditions <- data.frame(time = seq(0,50,length.out = 100), temp = rnorm(10, 10, 5))
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' x1 = seq(1,10,length.out = 10)
#' scaledPeriod = rep(10,10)
#' 
#' #Calculating x2 time values
#' x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param)
#' x2
setGeneric("timeShift", function(x1, scaledPeriod, model , conditions, param = list(), control = list(), interpolation = "constant", assignConstant = "lower") standardGeneric("timeShift"))
setMethod("timeShift", signature(x1 = "numeric", scaledPeriod = "numeric", model = "character", conditions = "data.frame"), function(x1, scaledPeriod, model, conditions, param, control, interpolation, assignConstant) {
  #Validity checks
  ##Validity checks on scaledPeriod range and length
  validityScaledPeriod(x1 = x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param, interpolation = interpolation)
  
  ##Validity check on interpolation method
  validityElement(interpolation,"constant","interpolation")
  
  #Generate functions of rate model and its integral only in function of time
  #timeModelFunction <- timeModel(model = model, conditions = conditions, param = param, control = control, interpolation = interpolation)
  timeModelIntegralFunction <- timeModelIntegral(model = model, conditions = conditions, param = param, control = control, interpolation = interpolation)
  
  #Find the root of the objective function h (for each element of the entry vector). As h is a monotonic function, there is only one root or interval of roots per element.
  ##Define searching bounds as conditions bounds
  lower = min(conditions$time)
  upper = max(conditions$time)

  ##Find roots of the objective function (return the specified bounds if on an interval)
  x2 <- vector("numeric", length = length(x1))
  for (i in seq_along(x2)){
    x2[i] <- intervalUniroot(h, lower, upper, correction = assignConstant, x1 = x1[i], scaledPeriod = scaledPeriod[i], timeModelIntegralFunction = timeModelIntegralFunction)
   }

  return(x2)
})

#Objective function
h <- function(x, x1, scaledPeriod, timeModelIntegralFunction){
  #Validity checks Both x1 and scaledPeriod are expected to be a single constants
  if(length(x1) != 1 | length(scaledPeriod) != 1){
    stop("x1 and scaledPeriod must be of length one when evaluating the objective function")
  }
  
  #Objective function return zero when elapsed time (delta) reach the scaledPeriod
  x1 <- rep(x1, length(x))
  delta <- timeModelIntegralFunction(x)-timeModelIntegralFunction(x1)
  z <- delta - scaledPeriod
  return(z)
}
