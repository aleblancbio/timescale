#' @title Interval uniroot
#' @description Extend the \code{uniroot} function from \code{stats} by accepting intervals on which the function is constant. The function then return one of the endpoints of the interval.
#' @param f a function for which to find the root, and passed to \code{uniroot}.
#' @param lower the lower end-point of the interval to be searched for the root.
#' @param upper the upper end-point of the interval to be searched for the root.
#' @param constantLower a vector of lower limits of intervals on which the function is constant.
#' @param constantUpper a vector of upper limits of intervals on which the function is constant.
#' @param correction a \code{character} indicating to which value of the interval correct the root, either \code{constantLower} or \code{constantUpper}.
#' @param ... arguments to pass to the function \code{uniroot}.
#' @return Return only the root (a constant), other components returned by \code{uniroot} are dismissed.
#' @details The function does not modify the searching behaviour of \code{uniroot}, but instead correct the root if it falls on a constant interval. Note than intervals are truncated at \code{lower} and \code{upper} if they fall outside the searching interval.
#' @export
#' @examples
#' #Define a function that reach zero at a +- delta
#' f <- function(x, a, delta){
#'  y <- rep(0,length = length(x))
#'  y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
#'  y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
#'  
#'  return(y)  
#'}
#' #Define parameters and range on which the function is known to be constant
#' a <- 5
#' delta <- 1
#' constantLower <- (a - delta)
#' constantUpper <- (a + delta)
#' lower = - 10
#' upper = 10
#' correction = "constantLower"
#' intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
#' 
#' correction = "constantUpper"
#' intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
#' 
#' correction = "constantUpper"
#' lower = 4.5
#' upper = 5.5
#' intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
#' 
#' uniroot(f, lower = lower, upper = upper, a = a, delta = delta)$root
#'
#'
intervalUniroot <- function(f, lower, upper, constantLower, constantUpper, correction = "constantLower", ...){
  #Check length of vectors
  if(length(constantLower)!=length(constantUpper)){
    stop("constantLower and constantUpper arguments must be of the same length")
  }

  #Truncate constant interval if outside searching interval (and eliminate new duplicates)
  constantLower[constantLower < lower] <- lower
  constantUpper[constantUpper > upper] <- upper
  constantLower <- unique(constantLower)
  constantUpper <- unique(constantUpper)
  
  #Compute the root
  root <- uniroot(f, lower = lower, upper = upper, ...)$root
  #root <- uniroot(f, lower = lower, upper = upper, a = a, delta = delta)$root
 
  #Correct the root
  ##Search for the closest interval starting before the root (if it exist)
  closestLogical <- root  >= constantLower
  
  if(length(closestLogical) == 1){
    ##Closest interval values
    closestLower <- min(constantLower[closestLogical])
    closestUpper <- constantUpper[closestLogical]
    
    ##Correction to one of the bound if the value is within the interval

    logicalWithin <- root <= closestUpper 
    if(logicalWithin){
      if(correction == "constantUpper"){
        root <- closestUpper
      }else if (correction == "constantLower"){
        root <- closestLower
      }else{
        stop("wrong input value for correction")
      }
    }
  }

  return(root)
}