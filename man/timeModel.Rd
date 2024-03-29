% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/timeModel.R
\name{timeModel}
\alias{timeModel}
\title{Express a model in function of time only}
\usage{
timeModel(
  model,
  conditions,
  param = list(),
  control = list(),
  interpolation = "constant"
)
}
\arguments{
\item{model}{\code{character} corresponding to the name of the rate model.}

\item{conditions}{\code{data.frame} with columns named \code{time} and variables expected to correspond to those of the model.}

\item{param}{\code{list} parameters of the model.}

\item{control}{\code{list} of arguments that control the behaviour of the model.}

\item{interpolation}{\code{character} corresponding to the name of the interpolating method of the model variables. Available methods include \code{constant} (default), \code{linear} and \code{spline} (for natural cubic splines).}
}
\value{
Return a new function that only depend on time (represented as \code{time}).
}
\description{
Compose the function of the model and the interpolating functions representing its variables.
}
\examples{
#Example of a rate model in function of time (instead of the original variable(s))
conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
model <- "modelLinear"
param = list(a = 1, T0 = 10)

#Get the function representing the model, can be evaluated at any time within those of conditions
f <- timeModel(model = model, conditions = conditions, param = param)
x <- seq(0,30,length.out = 20)
f(x)

#Plot
x <- seq(0,30,length.out = 1000)
plot(conditions$time,f(conditions$time))
lines(x,f(x))

}
