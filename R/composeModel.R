#' @title Compose a model with its variables representation
#' @description Compose the function of the model and the functions representing its variables, condModel a list a function  reprensenting each variables.
#' @param condModel \code{list} of functions that represent conditions variables in function of time (\code{v}) as the only argument, and to be substitued into the variables of the model. The \code{names} attribute of the list correspond to the variable names.
#' @param model \code{character} corresponding to the name of the rate model.
#' @return Return a new function that only depend on time (represented as \code{time}).
#' @details Note that \code{condModel} must correspond to a list of functions and not of function names. This is safer as these functions are usually not predefined, but generated using \code{interpolateCond}.
#' @export
#' @examples
#' #Example of a call with two variables
#' conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
#' condModel <- interpolateCond(conditions, method = "linear")
#' model <- "modelLinear"
#' param = list(a = 1, T0 = 10)
#' 
#' g <- composeModel(model, condModel, param)
#' x <- 1:20
#' g(x)
#' 
setGeneric("composeModel", function(model, condModel, param = list(), control = list())  standardGeneric("composeModel"))
setMethod("composeModel", signature(model = "character", condModel = "list"), function(model, condModel, param, control) {
  #Validity
  ##Check variable names
  var <- variableModel(model)
  condVar <- names(condModel)
  if(!all(var %in% condVar)){
    stop("Names of condModel elements  differ from model variable names")
  }
  
  ##Check elements of condModel are functions
  if(!all(sapply(condModel, class) == "function")){
    stop("Elements of condModel must be functions")
  }
  
  #Generate the composite function of the model and its variables in function of time (x).
  compFunction <- function(time) {
    #Define condModel list as functions of the present function
    condModelCall <- list()
    for (i in names(condModel)){
      condModelCall[[i]] <- do.call(condModel[[i]], args = list(time=time))
    }
    #Pass condModel functions as variables in model
    args = c(condModelCall, list(param = param, control = control))
    f <- do.call(model, args = args)
    
    return(f)
  }

  return(compFunction)
  
})
