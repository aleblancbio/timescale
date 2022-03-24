#' @description The package provides tools to compute the time elapsed in a different scaling of time.
#' The package was develop to compute development time of ectotherms in function of temperature, but has been built to accept any other time scaling. 
#' It is particularly useful for non-linear thermal response of development and allows interpolation of temperature. 
#' \cr\cr
#' The principal functions of the package are \code{timeScale} and \code{timeShift}, no other function require to be explicitly called.
#' The function \code{timeScale} evaluate the time elapsed between two bounds (\code{x1}, \code{x2}) into a scaled domain, or perform the back-transformation. 
#' The function \code{timeShift} estimate the upper bounds \code{x2} that would correspond to a specified period elapsed in the scaled domain. 

#' @section Installation and help:
#' The package can be installed from github by entering the following command lines in R: \cr
#' \code{devtools::install_github("aleblancbio/timescale", build_vignettes = TRUE)}.
#' \cr\cr
#' An overview of the package can be accessed through: \code{browseVignettes('timescale')}. 
#' To get information on a specific function, one can use ? or the help() function in R.
#' \cr\cr
"_PACKAGE"