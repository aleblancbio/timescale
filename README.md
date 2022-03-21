# timescale

## Package Installation
The package can be installed from github by entering the following command lines in R.
```
library(devtools)
install_github("aleblancbio/timescale", build_vignettes = TRUE)
```

## Get information on the package
This file give an overview of the package and is available from main folder of the GitHub project. The information has also been replicated as a vignette, to be available once the package is installed. The vignette can be accessed through the following command lines:

```
vignette('Overview', package = 'timescale')
browseVignettes("timescale")
```

To get information on a specific function, one can use ? or the help() function in R. A .pdf manual in the main folder of the GitHub project is also available.

## Description
The package provides tools to compute the time elapsed in a different scaling of time. Direct and inverse transformations are available, as well as the calculation of the period corresponding to a predefined value in the scaled domain. The package was develop to compute development time of ectotherms in function of temperature, but has been built to accept any other time scaling. The package is particularly useful for non-linear thermal response of development and allows interpolation of temperature. 

The package offers predefined models, but is also structured to accept any model defined by the user. Possible applications include :

- Scaling time into development time of insect pests for population dynamics, using hourly temperature and a non-linear thermal response.

- From historical temperature data, calculate when to sow crops to obtain uniform intervals at harvest. This is particularly useful to offer of continuous supply for fast growing crops (e.g. radish, lettuce, ...) or to better manage resources.

- Scaling time according to a model that using more than only temperature as a variable. Hydrothermal time (HTT) for seed germination is an example involving both temperature and water potential of the substrate and temperature.

- The calculation of growing degree days for crop, using daily records of minimum and maximum temperature (use two variables).


## Useful functions
The main functions are `timeScale` and `timeShift`, no other function require to be explicitly called.

- `timeScale`: the function evaluates the time elapsed between two bounds (`x1`, `x2`) into a scaled domain. The later is defined by a rate model (simply called `model` in the package) and `condtions` that represent its variables in function of time. If the option `inverse` is chosen, time in the scaled domain is converted back to time.

- `timeShift`: the function estimates the upper bounds `x2` that would correspond to a specified period elapsed in the scaled domain. 

## Model and conditions
Although \cond{model} and \cond{conditions} are not objects belonging to a defined class (such as in S4 and R6); they must however respect some structure and conditions to be accepted by `timeScale` and `timeScale`.

- 'model' is a function defined by the user that return the rate at which time elapse in the new scale. It takes variables, model parameters (`param` as a `list`) and optional arguments (under a list named `control`). All arguments of the model that is not either `param` or `control` are considered variables; therefore, any number of variables and any name can be chosen, with the exception of the word `time`). The model should accept numeric vectors of the same length as variable and return a value greater or equal to zero. Some models are already included in the package and can serve as template (`modelGDD`, `modelLinear`, `modelBriere1999`).

- 'conditions'  is a `data.frame` that contains one column named `time` and other columns with the same name as the model variables. It represents the evolution of the model variable through time. Checks are made when calling `timeScale` and `timeShift` to ensure `conditions` and the `model` are compatible. Other checks are made on `conditions`, including `time` must be a strictly increasing `numeric` containing `0`. Units of times must simply match the definition of the model, but day is a good choice.

## Package structure
This  section is not required to use the package, but will help understand the mechanics behind.

- `timeScale` and `timeShift` both start by performing validity checks, which are encapsulated in functions with name starting by validity (`validityConditions`, `validityModel`, `validityScaledPeriod`, `validityScaledTime`, `validityTime`).
- For the direct `timeScale`: 
    - `conditions` variables are interpolated using `interpolateCond`, which return a list of functions associated to each variable. Various interpolating functions can be chosen.
    - composite model function is made by substituting the temporal response of variables (the interpolation of conditions) into model variables. The resulting model is a function depending only on time.
    - The composite model is integrated between two time bounds (`x1` and `x2`). They can be any values in the range defined by conditions.
- For the inverse option of `timeScale`: 
    - Models usually can return zero values, the rate therefore cannot be inverted before integration. 
    - The approach preconised is to estimate time difference (from zero) for a defined period corresponding to bounds of scaled time. This operation is accomplished by `timeShift`.
- For `timeShift`: 
    - The idea is to find at which time, the time elapsed in the scaled domain (calculated by the function `timeScale`) would reach a defined period (scaledPeriod). 
    - This can be accomplish by finding the root of the timeScale function minus the objective scaled period.
    - As the rate is positive, the cumulative function is always increasing and there is only one root, or only one interval of roots (if the rate become zero exactly after the objective scaled period is reached).


## A work in progress
The package is still improving. More models, examples and documentation will be added in the future. Functionalities to be added and current issues are detailed in the GitHub issues section. Suggestions to improve the package are always welcome.    

    
 


