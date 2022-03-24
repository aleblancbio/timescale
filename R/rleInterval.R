#' @title rle interval
#' @description Define intervals limit (\code{lower}, \code{upper}) on which a vector (\code{x}) repeat a specified value at least \code{n} time (without any other values occuring). The function relies on the \code{rle} function from \code{base}. 
#' @param x an atomic vector .
#' @param value a single value to find in \code{x}.
#' @param n the minimum of repetition to be considered.
#' @return Return a list of two vectors (\code{lower} and \code{upper}) giving the position ofthe beginning and end of the intervals respecting the criteria. 
#' @export
#' @examples
#' x <- sample(1:3, size = 100, replace = TRUE)
#' rleInterval(x, value = 1, n = 1)
#' rleInterval(x, value = 1, n = 2)
#' rleInterval(x, value = 1, n = 100)
#' 
rleInterval <- function(x, value, n){
  #Identify which element correspond to the value
  logicalValue <- (x == value)
  logicalValueRle <- rle(logicalValue)
  
  #Run rle and convert lengths into position id (upper bound of intervals) 
  rleValue <- logicalValueRle$values
  rleLength <- logicalValueRle$lengths
  id <- cumsum(logicalValueRle$lengths)
  
  #Identify upper and lower bounds
  constantUpper <- id[rleValue == TRUE & rleLength >= n]
  constantLower <- constantUpper - (rleLength[rleValue == TRUE & rleLength >= n] - 1)
  
  L <- list(lower = constantLower, upper = constantUpper)
  
  return(L)
}