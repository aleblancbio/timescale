#' @title Scaled period validity
#' @description Check that adding a period in the scaled domain from a time vector (\code{x1}), return a vector of time the range of \code{conditions} time. Also check that \code{x1} ans \code{scaledPeriod} have the same length.
#' @param x1 \code{numeric} vector of initial time from which evaluate the scaling
#' @param scaledPeriod \code{numeric} vector of period in the scaled domain to add to \code{x1}.
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method for conditions. Available methods only include \code{constant} at the moment and is the default value.
#' @return Return \code{TRUE} if the condition is respected and an error otherwise.
#' @export
#' @examples
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
#' condModel <- interpolateCond(conditions, method = "linear")
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' x1 = seq(1,10,length.out = 10)
#' scaledPeriod = rep(10,10)
#' validityScaledPeriod(x1, scaledPeriod, model = model, conditions = conditions, param = param)
setGeneric("validityScaledPeriod", function(x1, scaledPeriod, model , conditions, param = list(), control = list(), interpolation = "constant") standardGeneric("validityScaledPeriod"))
setMethod("validityScaledPeriod", signature(x1 = "numeric", scaledPeriod = "numeric", model = "character", conditions = "data.frame"), function(x1, scaledPeriod, model, conditions, param, control, interpolation) {
  #Check length of entries vectors
  if(length(x1) != length(scaledPeriod)){
    stop("x1 and scaledPeriod arguments must be of the same length")
  }
  
  #Check constrains on scaledPeriod
  ##Set min and max scaledPeriod
  x2Max <- rep(max(conditions$time), length(x1))
  x2Min <- rep(min(conditions$time), length(x1))
  maxDelta <- timeScale(x1 = x1, x2 = x2Max, model = model, conditions = conditions, param = param, control = control, interpolation = interpolation, inverse = FALSE)
  minDelta <- timeScale(x1 = x1, x2 = x2Min, model = model, conditions = conditions, param = param, control = control, interpolation = interpolation, inverse = FALSE)
  
  ##Check validity
  logicalPeriodValidity <- (scaledPeriod >= minDelta) & (scaledPeriod <= maxDelta)
  if(!all(logicalPeriodValidity )){
    stop("scaledPeriod reached time outside conditions limits")
  }
  
  return(TRUE)
})


