#' @title Interpolate conditions
#' @description Interpolate variables of conditions
#' @param conditions \code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.
#' @param method \code{character} corresponding to the name of the interpolating method. Available methods include \code{constant}, \code{linear} and \code{spline} (for natural cubic splines).
#' @return Return a list of functions that interpolate variable according to time. Functions have only \code{v} as an argument which represent the time vector at which the function is to be interpolated. The \code{names} attribute of the list correspond to the variable names.
#' @details The function is a wrapper of \code{approxfun}.
#' @export
#' @examples
#' #Example of a call with two variables
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5), rh = rnorm(10, 10, 5))
#' f <- interpolateCond(conditions, method = "constant")
#' f
#' #Plotting the result for temp 
#' plot(conditions$time,conditions$temp)
#' x <- seq(0,30,length.out = 100)
#' lines(x,f$temp(x), lty = 1)
#' f <- interpolateCond(conditions, method = "spline")
#' #Plotting the result for temp 
#' plot(conditions$time,conditions$temp)
#' x <- seq(0,30,length.out = 100)
#' lines(x,f$temp(x), lty = 1)
setGeneric("interpolateCond", function(conditions, method) standardGeneric("interpolateCond"))
setMethod("interpolateCond", signature(conditions = "data.frame", method = "character"), function(conditions, method) {

     #Define a function that would generate interpolated functions in function of time only, for a predefined conditions variable and method
    interpolatedCondVar <- function(variable, conditions, method){
      force(variable)
      if(method %in% c("constant","linear")){
        #Constant and linear cases
        f <- function(time){
          approx(xout = time, x = conditions$time, y = conditions[[variable]], method = method, rule = 1, f = 0, ties = mean)$y
        }
      }else if(method %in% c("spline")){
        #Spline case (natural cubic)
        f <- function(time){
          spline(xout = time, x = conditions$time, y = conditions[[variable]], method = "natural", ties = mean)$y
        }
      }else{
        stop("Undefined method of interpolation for conditions")
      }

      return(f)
    }

    ##Generate and store functions
    interpolatedCond <- list()
    for(i in variableConditions(conditions)){
      interpolatedCond[[i]] <- interpolatedCondVar(i, conditions, method)
    }

  return(interpolatedCond)
})
