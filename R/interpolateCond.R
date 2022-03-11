#' @title Interpolate conditions
#' @description Interpolate variables of conditions
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param method \code{character} corresponding to the name of the interpolating method among. Available methods include \code{constant} or \code{linear}.
#' @return Return a list of functions that interpolate variable according to time. Functions have only \code{v} as an argument which represent the time vector at which the function is to be interpolated. The \code{names} attribute of the list correspond to the variable names.
#' @details The function is a wrapper of \code{approxfun}.
#' @export
#' @examples
#' #Example of a call with two variables
#' conditions <- data.frame(time = seq(1,30,length.out = 10), temp = rnorm(10, 10, 5), hr = rnorm(10, 10, 5))
#' f <- interpolateCond(conditions, method = "linear")
#' f
#' #Plotting the result for temp 
#' plot(conditions$time,conditions$temp)
#' x <- seq(1,30,length.out = 100)
#' lines(x,f$temp(x), lty = 1)
#' 
setGeneric("interpolateCond", function(conditions, method) standardGeneric("interpolateCond"))
setMethod("interpolateCond", signature(conditions = "data.frame", method = "character"), function(conditions, method) {

  #Ensure x is within time limit of conditions
  logicalBeyondLimits <- any(x > max(conditions$time) | x < min(conditions$time))
  if(logicalBeyondLimits){
    stop("x cannot be interpolated beyond time range of conditions")
  }
  
  #Interpolation
  interpolatedCond <- list()
  if(method %in% c("constant","linear")){
    #Constant and linear cases
    for(i in variableConditions(conditions)){
      interpolatedCond[[i]] <- approxfun(x = conditions$time, y = conditions[[i]], method = method, rule = 1, f = 0, ties = mean)
    }
  }else{
    stop("Undefined method of interpolation for conditions")
  }
  return(interpolatedCond)
  
})
