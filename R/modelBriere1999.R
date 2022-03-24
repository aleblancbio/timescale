#' @title Briere 1999 Model
#' @description Correspond to the non-linear model of Briere et al. (1999), describing growth rate in function of temperature.
#' @param temp \code{numeric} vector of temperature (in celcius)
#' @param param \code{list} of parameters named: \code{T0} the base temperature under which no development occurs, \code{TL} the temperature above which no development occurs, \code{a} a normalizing factor such as development is completed at 1, \code{m} a constant determining the shape of the function.
#' @param control \code{list} of arguments that control the behaviour of the model; empty, kept for consistency with the general structure of rate models.
#' @return return a vector of rate associated to each element of \code{temp}.
#' @details The function correspond to equation of (2) of Briere et al. (1999), the rate is \code{r(T) = a*T*(T-T0)*(TL-T)^(1/m)} if \code{T0 <= T <= TL} and zero otherwise. Setting m = 2 correspond to equation (1) of the paper.
#' @export
#' @examples
#' modelBriere1999(temp = seq(8,32,2), param = list(a = 1/100, T0 = 10, TL = 30, m = 2))
#' 
modelBriere1999 <- function(temp, param = list(a, T0, TL, m), control = list()){
  #Renaming parameters
  a <- param$a
  T0 <- param$T0
  TL <- param$TL
  m <- param$m
  
  #Branch function
  rate <- vector("numeric", length = length(temp))
  logicalZero <- temp <= T0 | temp >= TL
  ##Branch 1
  rate[logicalZero] <- 0
  ##Branch 2
  rate[!logicalZero] <- a*T*(temp[!logicalZero]-T0)*(TL-temp[!logicalZero])^(1/m)
  
  return(rate)
}
