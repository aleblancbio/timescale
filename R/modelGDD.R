#' @title Growing degree day (from daily temperature)
#' @description Growing degree day model based on daily approximation of temperature. 
#' @param Tmin \code{numeric} vector of minimum daily temperature (in celcius)
#' @param Tmax \code{numeric} vector of maximum daily temperature (in celcius)
#' @param param \code{list} of parameters named \code{T0}, the base temperature under which no development occurs.
#' @param control \code{list} of arguments that control the behaviour of the model; for this function, \code{method} can be selected among \code{1} and \code{2} (see details).
#' @return Return a vector of rate associated to each element of \code{temp}.
#' @details Two methods, described McMaster and Wilhelm (1997) can be chosen. Method 1 define GDD for one day as \code{(Tmax-Tmin)/2-T0} if greater than zero and zero otherwise; Method 2 define GDD for one day as \code{(Tmax-Tmin)/2-T0} after converting \code{Tmin} and \code{Tmax} into \code{T0} if they were smaller values. 
#' @section Reference:
#' McMaster GS, Wilhelm WW. 1997. Growing degree-days: one equation, two interpretations. Agricultural and Forest Meteorology. 87: 291-300. Available from: https://doi.org/10.1016/S0168-1923(97)00027-0.
#' @export
#' @examples
#' modelGDD(Tmin = seq(0,20,2), Tmax = 5 + seq(0,20,2), param = list(T0 = 10), control = list(method = 1))
#' 
modelGDD <- function(Tmin, Tmax, param = list(T0), control = list(method = 1)){

  #Renaming parameter
  T0 <- param$T0
  
  if(control$method == 1){
    #Compute an estimation of the mean used in GDD
    Tmean = (Tmin + Tmax)/2
    
    #Branch function
    rate <- vector("numeric", length = length(Tmin))
    logicalZero <- Tmean <= T0
    ##Branch 1
    rate[logicalZero] <- 0
    ##Branch 2
    rate[!logicalZero] <- (Tmean[!logicalZero]-T0)
    
  }else if(control$method == 2){
    #Substitute by T0 cases in which Tmin < T0 or Tmax < T0
    Tmin[Tmin < T0] <- T0
    Tmax[Tmax < T0] <- T0
    
    #Compute an estimation of the mean used in GDD
    Tmean = (Tmin + Tmax)/2
    rate <- Tmean - T0
      
  }else{
    stop("GDD method undefined")
  }
   
  return(rate)
}
