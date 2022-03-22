#' @title Integrate (vectorized)
#' @description Extend the integrate function from \code{stats} by accepting vector for the limits of integration.
#' @param f a function to be integrated, that can be used by the function \code{integrate}.
#' @param lower \code{numeric} vector lower limits of integration.
#' @param upper \code{numeric} vector upper limits of integration.
#' @param ... arguments to pass to the function \code{integrate}.
#' @return Return a vector, of the same length as lower and upper, giving the associated \code{value} of the integral, other components returned by \code{integrate} are dismissed.
#' @export
#' @examples
#' f <- function(x) (x)
#' lower <- seq(1,10,length.out = 10)
#' upper <- seq(11,20,length.out = 10)
#' vectIntegrate(f, lower, upper)
#' 
vectIntegrate <- function(f, lower, upper, ...){
  #Check length of vectors
  if(length(lower)!=length(upper)){
    stop("lower and upper arguments must be of the same length")
  }
  
  #Integrate between bounds, returning only its value
  I <- vector("numeric",length = length(lower))
  for (i in seq_along(lower)){
    I[i] <- integrate(f, lower[i], upper[i], ...)$value
  }
  return(I)
}
