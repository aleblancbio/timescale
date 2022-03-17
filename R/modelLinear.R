#' @title Linear rate model in function of temperature
#' @description Correspond to normalized growing degree day model, without daily approximation of temperature.
#' @param temp \code{numeric} vector of temperature (in celcius)
#' @param param \code{list} of parameters named \code{T0}, the base temperature under which no development occurs, and \code{a} a normalizing factor such as development is completed at 1 (i.e. \code{a = 1/GDD}).
#' @param control \code{list} of arguments that control the behaviour of the model; empty, kept for consistency with the general structure of rate models.
#' @return return a vector of rate associated to each element of \code{temp}.
#' @details The normalizing parameter should be set to one if the model returns units such as growing degree days.
#' @export
#' @examples
#' modelLinear(temp = seq(0,30,2), param = list(a = 1, T0 = 10))
#' 
modelLinear <- function(temp, param = list(a, T0), control = list()){
  #Renaming parameters
  a <- param$a
  T0 <- param$T0
  
  #Branch function
  rate <- vector("numeric", length = length(temp))
  logicalZero <- temp <= T0
  ##Branch 1
  rate[logicalZero] <- 0
  ##Branch 2
  rate[!logicalZero] <- a*(temp[!logicalZero]-T0)
  
  return(rate)
}
