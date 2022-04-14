#' @title Express a model in function of time only
#' @description Compose the function of the model and the interpolating functions representing its variables.
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method of the model variables. Available methods include \code{constant} (default), \code{linear} and \code{spline} (for natural cubic splines). 
#' @return Return a new function that only depend on time (represented as \code{time}).
#' @export
#' @examples
#' #Example of a rate model in function of time (instead of the original variable(s))
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' 
#' #Get the function representing the model, can be evaluated at any time within those of conditions
#' f <- timeModel(model = model, conditions = conditions, param = param)
#' x <- seq(0,30,length.out = 20)
#' f(x)
#' 
#' #Plot
#' x <- seq(0,30,length.out = 1000)
#' plot(conditions$time,f(conditions$time))
#' lines(x,f(x))
#' 
setGeneric("timeModel", function(model, conditions, param = list(), control = list(), interpolation = "constant")  standardGeneric("timeModel"))
setMethod("timeModel", signature(model = "character", conditions = "data.frame"), function(model, conditions, param, control, interpolation) {
  #Validity checks
  validityModel(model)
  validityConditions(conditions, model)
  
  condModel <- interpolateCond(conditions, method = interpolation)
  timeModel <- composeModel(model, condModel, param = param, control = control)
  
  return(timeModel)
  
})
