#' @title Scaled time validity
#' @description Check that a scaled time vector (\code{x}) is included in the scaled time range of \code{conditions}.
#' @param x \code{numeric} vector representing scaled time.
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
#' x = seq(1,10,length.out = 10)
#' scaledPeriod = rep(10,10)
#' validityScaledTime(x, model = model, conditions = conditions, param = param)
setGeneric("validityScaledTime", function(x, model , conditions, param = list(), control = list(), interpolation = "constant") standardGeneric("validityScaledTime"))
setMethod("validityScaledTime", signature(x = "numeric", model = "character", conditions = "data.frame"), function(x, model, conditions, param, control, interpolation) {
    #Simply refers to the equivalent function for period
    x1 = rep(0, length(x))
    validityScaledPeriod(x1, scaledPeriod = x, model = model, conditions = conditions, param = param, interpolation = interpolation)
  return(TRUE)
})


