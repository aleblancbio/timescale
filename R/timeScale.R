#' @title Time scale
#' @description Evaluate the time elapsed between two bounds (\code{x1}, \code{x2}) into a scaled domain given a rate model and condtions that represent its variables.
#' @param x1 \code{numeric} vector of initial time from which evaluate the scaling
#' @param x2 \code{numeric} vector of final time until which evaluate the scaling
#' @param model \code{character} corresponding to the name of the rate model (see the details section).
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model (see the details section).
#' @param param \code{list} of parameters of the model.
#' @param control \code{list} of arguments that control the behaviour of the model.
#' @param interpolation \code{character} corresponding to the name of the interpolating method for conditions. Available methods only include \code{constant} at the moment and is the default value.
#' @param inverse \code{logical} indicating if the inverse operation (i.e. scaled time to time transformation) should be performed.
#' @param assignConstant \code{character} vector of length 2 indicating how to assign scaled time \code{x1} and \code{x2} to time when it remains constant on a time interval. Choices are \code{lower} and \code{upper} for both end of the interval. The default values are \code{assignConstant = c("lower","lower")}.
#' @return Return a vector of the same length as \code{x1} and \code{x2} representing the scaled time (or time if \code{inverse = TRUE}) elapsed between those values.
#' @details 
#' Both \code{x1} and \code{x2} must be in the time range provided by conditions. \cr \cr
#' \code{model} is a function defined by the user that return the rate at which time elapse in the new scale. It takes variables, model parameters (\code{param} as a \code{list}) and optional arguments (under a \code{list} named \code{control}). All arguments of the model that is not either \code{param} or \code{control} are considered variables; therefore, any number of variables and any name can be chosen, with the exception of the word \code{time}). The model should accept numeric vectors of the same length as variable and return a value greater or equal to zero. Some models are already included in the package and can serve as template (\code{modelGDD}, \code{modelLinear}, \code{modelBriere1999}). \cr \cr
#' \code{conditions} is a \code{data.frame} that contains one column named \code{time} and other columns with the same name as the model variables. It represents the evolution of the model variable through time. Checks are made when calling \code{timeScale} and \code{timeShift} to ensure \code{conditions} and the \code{model} are compatible. Other checks are made on \code{conditions}, including that \code{time} must be a strictly increasing \code{numeric}, but not necessarily of regular interval. Units of times must simply match the definition of the model, but day is a good choice. Conditions values are considered constant in time until the next measurement.\cr \cr
#' For the inverse option, a specified scaled time can be associated on an interval of time instead of a unique value, if the rate specified by the model is zero. The time (\code{z1} and \code{z2}) associated to \code{x1} and \code{x2} are calculated using \code{timeShift}, values are calculated separately using the first and second element of \code{assignConstant}. 
#' 
#' @export
#' @examples
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 25, 5))
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' x1 = rep(0,10)
#' x2 = seq(11,20,length.out = 10)
#' z2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
#' z1 <- rep(0,10,length.out = 10)
#' timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE)
#'
setGeneric("timeScale", function(x1, x2, model , conditions, param = list(), control = list(), interpolation = "constant", inverse = FALSE, assignConstant = c("lower", "lower")) standardGeneric("timeScale"))
setMethod("timeScale", signature(x1 = "numeric", x2 = "numeric", model = "character", conditions = "data.frame"), function(x1, x2, model, conditions, param, control, interpolation, inverse, assignConstant) {

  ##Validity check on interpolation method
  validityElement(interpolation,"constant","interpolation")
  
  #Generate functions of rate model and its integral only in function of time
  timeModelFunction <- timeModel(model = model, conditions = conditions, param = param, control = control, interpolation = interpolation)
  timeModelIntegralFunction <- timeModelIntegral(model = model, conditions = conditions, param = param, control = control, interpolation = interpolation)
  
  if(!inverse){
    #Scale time (direct case)
    ##Validity checks on x1 and x2 (within the definition range of conditions)
    validityTime(x1, conditions)
    validityTime(x2, conditions)

    ##Compute the time elapsed between x1 and x2
    z <- timeModelIntegralFunction(x2) -  timeModelIntegralFunction(x1)
 
  }else{
    ##Validity checks on assignConstant (proper length and values)
    validityElement(assignConstant, c("lower", "upper"), "assignConstant")
    validityLength(assignConstant, 2, "assignConstant")

    ##Calculate time difference z2-z1 with scaled time x1 as reference, from scaled time x1 and x2
    z0 <- rep(min(conditions$time), length(x1))
    z1 <- timeShift(z0, scaledPeriod = x1, model = model, conditions = conditions, param = param, interpolation = interpolation, assignConstant = assignConstant[1])
    z2 <- timeShift(z0, scaledPeriod = x2, model = model, conditions = conditions, param = param, interpolation = interpolation, assignConstant = assignConstant[2])
    z <- z2 - z1
  }

  return(z)
})
