% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modelBriere1999.R
\name{modelBriere1999}
\alias{modelBriere1999}
\title{Briere 1999 Model}
\usage{
modelBriere1999(temp, param = list(a, T0, TL, m), control = list())
}
\arguments{
\item{temp}{\code{numeric} vector of temperature (in celcius)}

\item{param}{\code{list} of parameters named: \code{T0} the base temperature under which no development occurs, \code{TL} the temperature above which no development occurs, \code{a} a normalizing factor such as development is completed at 1, \code{m} a constant determining the shape of the function.}

\item{control}{\code{list} of arguments that control the behaviour of the model; empty, kept for consistency with the general structure of rate models.}
}
\value{
return a vector of rate associated to each element of \code{temp}.
}
\description{
Correspond to the non-linear model of Briere et al. (1999), describing growth rate in function of temperature.
}
\details{
The function correspond to equation of (2) of Briere et al. (1999), the rate is \code{r(T) = a*T*(T-T0)*(TL-T)^(1/m)} if \code{T0 <= T <= TL} and zero otherwise. Setting m = 2 correspond to equation (1) of the paper.
}
\examples{
modelBriere1999(temp = seq(8,32,2), param = list(a = 1/100, T0 = 10, TL = 30, m = 2))

}
