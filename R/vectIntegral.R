#' @title Integral (vectorized)
#' @description Extend the Integral function from \code{pracma} by accepting vector for the limits of integration.
#' @param f a function to be integrated, that can be used by the function \code{Integral}.
#' @param xmin \code{numeric} vector lower limits of integration.
#' @param xmax \code{numeric} vector upper limits of integration.
#' @param ... arguments to pass to the function \code{Integral}.
#' @return Return a vector, of the same length as xmin and upper, giving the associated value of the integral.
#' @import pracma
#' @export
#' @examples
#' f <- function(x) (x)
#' xmin <- seq(1,10,length.out = 10)
#' xmax <- seq(11,20,length.out = 10)
#' vectIntegral(f, xmin, xmax)
#' 
vectIntegral <- function(f, xmin, xmax, ...){
  #Check length of vectors
  if(length(xmin)!=length(xmax)){
    stop("xmin and xmax arguments must be of the same length")
  }
  
  #Integrate between bounds, returning only its value
  I <- vector("numeric",length = length(xmin))
  for (i in seq_along(xmin)){
    I[i] <- integral(f, xmin[i], xmax[i], ...)
  }
  return(I)
}
