#' @title Express the integral of a model in function of time only
#' @description Compose the function of the model and the functions representing its variables, condModel a list a function  reprensenting each variables.
#' @param model \code{character} corresponding to the name of the rate model.
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param param \code{list} parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method of the model variables. Available methods include \code{constant} (default), \code{linear} and \code{spline} (for natural cubic splines). 
#' @return Return a new function that only depend on time (represented as \code{x}).
#' @export
#' @examples
#' #Example of the integral of a rate model in function of time
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' 
#' #Get the function representing the integral of the model, can be evaluated at any time within those of conditions
#' g <- timeModelIntegral(model, conditions, param)
#' x <- seq(0,30,length.out = 20)
#' g(x)
#' 
#' #Plot
#' x <- seq(0,30,length.out = 1000)
#' g <- timeModelIntegral(model, conditions, param)
#' plot(conditions$time,g(conditions$time))
#' lines(x,g(x))
#' 
#' 
setGeneric("timeModelIntegral", function(model, conditions, param = list(), control = list(), interpolation = "constant")  standardGeneric("timeModelIntegral"))
setMethod("timeModelIntegral", signature(model = "character", conditions = "data.frame"), function(model, conditions, param, control, interpolation) {
  #Validity checks
  validityModel(model)
  validityConditions(conditions, model)

  if(interpolation %in% c("constant")){
    #Constant case (integral correspond to linear interpolation of the integral/sum at conditions time)
      timeModelFunction <- timeModel(model = model, conditions = conditions, param = param, control = control, interpolation = interpolation)
      n <- length(conditions$time)
      y <- cumsum(c(0, timeModelFunction(conditions$time)[1:n-1] * (conditions$time[2:n] - conditions$time[1:n-1])))             
      f <- approxfun(x = conditions$time, y = y, method = "linear", rule = 1, f = 0, ties = mean)
      timeModelIntegralFunction <- function(time) f(time)
    }else{
      stop("wrong interpolation method")
    }
    
  return(timeModelIntegralFunction)
  
})
