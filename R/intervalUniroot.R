#' @title Interval uniroot
#' @description Extend the \code{uniroot} function from \code{stats} by accepting intervals on which the function is constant. The function then return one of the endpoints of the interval. Note than the function must be either increasing or decreasing, although not necessarily strictly.
#' @param f a function for which to find the root, and passed to \code{uniroot}. 
#' @param lower the lower end-point of the interval to be searched for the root.
#' @param upper the upper end-point of the interval to be searched for the root.
#' @param correction a \code{character} indicating to which value of the interval correct the root, either \code{lower}, \code{upper} or \code{none}. The latter return the same value as \code{uniroot}.
#' @param tol \code{numeric}, the absolute tolerance on the argument of \code{f}, specifying when to stop searching for limits of the interval. By default, correspond to the square root of the machine's precision.
#' @param ... additional arguments to pass to the function \code{f} or the function \code{uniroot}.
#' @return Return only the root (a constant), other components returned by \code{uniroot} are dismissed.
#' @details The function first estimate the root using \code{uniroot}. If the derivative is also zero, the function search for an interval and instead return its lowest or highest value (according to \code{correction}). The algorithm stop when increment on the argument of \code{f} reached absolute tolerance specified by \code{tol}.
#' @export
#' @examples
#' #Define a function that reach zero at a +- delta
#' g <- function(x, a, delta){
#'  y <- rep(0,length = length(x))
#'  y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
#'  y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
#'  
#'  return(y)  
#' }
#'
#' #Define parameters and range on which the function is known to be constant
#' a <- 5
#' delta <- 1
#' lower <- -10
#' upper <- 10
#' intervalUniroot(g, lower, upper, correction = "lower", a = a, delta = delta)
#' intervalUniroot(g, lower, upper, correction = "upper", a = a, delta = delta)
#' uniroot(g, lower = lower, upper = upper, a = a, delta = delta)$root
#'
intervalUniroot <- function(f, lower, upper, correction = "lower", tol = .Machine$double.eps^0.5, ...){
  
  #Compute the root
  root <- uniroot(f, lower = lower, upper = upper, ...)$root
  
  #Search for one bound (specified) of a potential stationary interval
  ##Setting the bound for correction
  if(correction == "upper"){
    xBound <- upper
  }else if (correction == "lower"){
    xBound <- lower
  }else if (correction == "none"){
    xBound <- root
  }else{
    stop("wrong name for correction")
  }
  
  ##Split the interval in half (either from the bound or the root side) until tolerance is reached
  xDelta <- root - xBound
  while(abs(xDelta) > tol){
    logicalBoundWithin <- f(xBound+xDelta/2, ...) == 0
    if(!logicalBoundWithin){
      xBound <- xBound+xDelta/2
    }else{
      root <- root-xDelta/2
    }
    xDelta <- root - xBound
  }
  
  return(root)
}
