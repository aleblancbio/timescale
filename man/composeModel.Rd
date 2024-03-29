% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/composeModel.R
\name{composeModel}
\alias{composeModel}
\title{Compose a model with its variables representation}
\usage{
composeModel(model, condModel, param = list(), control = list())
}
\arguments{
\item{model}{\code{character} corresponding to the name of the rate model.}

\item{condModel}{\code{list} of functions that represent conditions variables in function of time (\code{v}) as the only argument, and to be substitued into the variables of the model. The \code{names} attribute of the list correspond to the variable names.}
}
\value{
Return a new function that only depend on time (represented as \code{time}).
}
\description{
Compose the function of the model and the functions representing its variables, condModel a list a function  reprensenting each variables.
}
\details{
Note that \code{condModel} must correspond to a list of functions and not of function names. This is safer as these functions are usually not predefined, but generated using \code{interpolateCond}.
}
\examples{
#Example of a call with two variables
conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
condModel <- interpolateCond(conditions, method = "linear")
model <- "modelLinear"
param = list(a = 1, T0 = 10)

g <- composeModel(model, condModel, param)
x <- 1:20
g(x)

}
