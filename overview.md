## Package Installation

The package can be installed from github by entering the following
command lines in R.

    library(devtools)
    install_github("aleblancbio/timescale", build_vignettes = TRUE)

## Get information on the package

This file give an overview of the package and is available from main
folder of the GitHub project. The information has also been replicated
as a vignette, to be available once the package is installed. The
vignette can be accessed through the following command lines:

    library(timescale)
    browseVignettes("timescale")

To get information on a specific function, one can use ? or the help()
function in R. A .pdf manual in the main folder of the GitHub project is
also available.

## Description

The package provides tools to compute the time elapsed in a different
<<<<<<< HEAD
scaling of time. The package was developed to calculate development time
of ectotherms in function of temperature, but has been built to deal
with any other time scaling. The package offers predefined models, but
models defined by the user are also accepted.

## Why use this package for development time?

Calculating development over a temperature series is relatively
straightforward and does not require a whole package. The `timescale`
package was developed to bring two important operations that become
useful when manipulating development time beyond simple cases:
=======
scaling of time. The package was developed to compute development time
of ectotherms in function of temperature, but has been built to accept
any other time scaling. The package offers predefined models, but is
also structured to accept any model defined by the user.

## Why use this package for development time?

Summing over time the development, calculated from temperature series,
is relatively straightforward and does not require a whole package. The
`timescale` package was developed to bring two important operations that
become useful when manipulating development time beyond simple cases:
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

1.  Computes development between any time, and not only at those of the
    temperature dataset
2.  Computes the inverse operation and estimate precisely when some
    development would be achieved

Less important aspects brought by the package, but still noteworthy, are
that it:

1.  Contains preexisting models (linear and non-linear) and is
    structured to accept any model defined by the user
2.  Validates appropriate inputs
3.  Provides a structure to handle more than only temperature

Here are some applied contexts in which we could use the package:

-   Scaling time into development time of insect pests for population
    dynamics, using hourly temperature and a non-linear thermal
    response.

<<<<<<< HEAD
-   From historical temperature data, calculating when to sow crops to
=======
-   From historical temperature data, calculate when to sow crops to
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
    obtain uniform intervals at harvest and provide a continuous supply
    at market.

-   Scaling time according to a model that use more than only
    temperature as a variable. Hydrothermal time (HTT) for seed
    germination is an example involving both temperature and water
    potential of the substrate and temperature.

<<<<<<< HEAD
-   Calculating growing degree days for crop, using daily records of
    minimum and maximum temperature (use two variables).
=======
-   The calculation of growing degree days for crop, using daily records
    of minimum and maximum temperature (use two variables).
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

## Useful functions

The main functions are `timeScale` and `timeShift`, no other function
require to be explicitly called.

-   `timeScale`: the function evaluates the time elapsed between two
    bounds (`x1`, `x2`) into a scaled domain. The later is defined by a
<<<<<<< HEAD
    rate model (simply called `model` in the package) and `conditions`
=======
    rate model (simply called `model` in the package) and `condtions`
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
    that represent its variables in function of time. If the option
    `inverse` is chosen, time in the scaled domain is converted back to
    time.

-   `timeShift`: the function estimates the upper bounds `x2` that would
    correspond to a specified period elapsed in the scaled domain.

## Model and conditions

Although `model` and `conditions` are not objects belonging to a defined
class (such as in S4 and R6); they must however respect some structure
<<<<<<< HEAD
and conditions to be accepted by `timeScale` and `timeShift`.

-   ‘model’ is a function defined by the user that return the rate at
    which time elapse in the new scale. It takes variables, model
    parameters (under a `list` named `param`) and optional arguments
    (under a list named `control`). All arguments of the model that is
    not either `param` or `control` are considered variables; therefore,
    any number of variables and any name can be chosen (with the
    exception of the word `time`). The model should accept numeric
    vectors of the same length as variable and return a value greater or
    equal to zero. Some models are already included in the package and
    can serve as template (`modelGDD`, `modelLinear`,
    `modelBriere1999`).
=======
and conditions to be accepted by `timeScale` and `timeScale`.

-   ‘model’ is a function defined by the user that return the rate at
    which time elapse in the new scale. It takes variables, model
    parameters (`param` as a `list`) and optional arguments (under a
    list named `control`). All arguments of the model that is not either
    `param` or `control` are considered variables; therefore, any number
    of variables and any name can be chosen, with the exception of the
    word `time`). The model should accept numeric vectors of the same
    length as variable and return a value greater or equal to zero. Some
    models are already included in the package and can serve as template
    (`modelGDD`, `modelLinear`, `modelBriere1999`).
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

-   ‘conditions’ is a `data.frame` that contains one column named `time`
    and other columns with the same name as the model variables. It
    represents the evolution of the model variable through time. Checks
    are made when calling `timeScale` and `timeShift` to ensure
<<<<<<< HEAD
    `conditions` and the `model` are compatibles. Other checks are made
    on `conditions`, including `time` must be a strictly increasing
    `numeric` vector containing `0`. Units of times must simply match
    the definition of the model, with day usually being used.
=======
    `conditions` and the `model` are compatible. Other checks are made
    on `conditions`, including `time` must be a strictly increasing
    `numeric` containing `0`. Units of times must simply match the
    definition of the model, but day is a good choice.
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

## Examples

### Specifying conditions and model

<<<<<<< HEAD
We will first load libraries and generate random hourly temperature
=======
We will first load librairies and generate random hourly temperature
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
data, with time represented in days as `numeric`.

    library(timescale)
    library(ggplot2)
    set.seed(6)
    time <- seq(0, 5, by = 1/24)
    temp <- 5*sin(2*pi*time) + rnorm(length(time), mean = 10, sd = 2.5)
    conditions <- data.frame(time = time, temp = temp)

<<<<<<< HEAD
Plotting the data we have:

    p<-ggplot(conditions, aes(x=time, y=temp)) + 
      geom_point() +
      geom_line() +
      theme_classic()
    p

![](C:/Users/alebl/AppData/Local/Temp/RtmpGu74ki/preview-47c47bad286d.dir/overview_files/figure-markdown_strict/unnamed-chunk-3-1.png)

=======
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
For the model, we use the function called `modelLinear`, already
included in the package. The function linearly accumulate development at
a temperature (`temp`) greater or equal to a base temperature (`T0`)
given a normalizing constant (`a`). We can overview the structure of the
function.

    modelLinear
    #> function(temp, param = list(a, T0), control = list()){
    #>   #Renaming parameters
    #>   a <- param$a
    #>   T0 <- param$T0
    #>   
    #>   #Branch function
    #>   rate <- vector("numeric", length = length(temp))
    #>   logicalZero <- temp <= T0
    #>   ##Branch 1
    #>   rate[logicalZero] <- 0
    #>   ##Branch 2
    #>   rate[!logicalZero] <- a*(temp[!logicalZero]-T0)
    #>   
    #>   return(rate)
    #> }
<<<<<<< HEAD
    #> <bytecode: 0x0000000019dcbac8>
=======
    #> <bytecode: 0x0000000019dd1568>
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
    #> <environment: namespace:timescale>

Once we have defined the function, we can simply refer to the function
name. Here we will specify also `T0` to 10<sup>∘</sup>C and set the
normalizing constant `a` to 1 over the total degree day to complete
<<<<<<< HEAD
development (we set it to 10 degree days); a development of 1 then
correspond to its completion. Alternatively, we could have chosen
=======
development (we set it to 10 degree days); a value of 1 then correspond
to completion of development. Alternatively, we could have chosen
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
`a = 1` in order to accumulate degree days.

    model <- "modelLinear"
    param <- list(T0 = 10, a = 1)

### Function timeScale

We then use the `timeScale` function to compute the development (`z2`)
<<<<<<< HEAD
between a reference ‘x1’ and some other time ‘x2’ (it can differ from
the one of `conditions`).
=======
between a reference ‘x1’ and some other time ‘x2’ (it doesn’t have to be
same as the one of `conditions`).
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

    x1 = rep(0,length.out = 6)
    x2 = seq(0,5,length.out = 6)
    z2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
    z2
    #> [1] 0.000000 2.032425 4.075210 5.503463 7.787138 9.103891

For the inverse operation, we simply have to use the option
`inverse = TRUE` and specify entries as development instead of time. For
this example, we would calculate `z2` back into `x2` using zero as a
reference for `z1` (since `x1` and `z1` both coincide at zero).

    z1 <- rep(0,length.out = 6)
    x2CalcLower <- timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = "lower")
    x2CalcLower
    #> [1] 0.0000000 0.9975504 2.0003153 3.0225882 3.9559027 5.0000000

Note that `x2Calc` differs from `x2`, when the development rate defined
<<<<<<< HEAD
by the model is zero for some period. As the corresponding scaled time
`z2` remain constant over that period of time, the scaling function is
not invertible. What the inverse option calculates is one of the time
interval limits associated to the scaled time `z2`. With the option
`assignConstant = "lower"` (the default), the function returns the first
time the organism reached the specified development (`z2`), while
`assignConstant = "upper"` make the function return the last occurrence.

=======
by the model is zero for some period. The corresponding scaled time `z2`
remain constant over that period of time, the scaling function is
therefore not invertible. What the inverse option calculates is one of
the time interval limits associated to the scaled time `z2`. With the
option `assignConstant = "lower"` (the default), the function returns
the time the organism reached the development specified by `z2`, while
`assignConstant = "upper"` make the function return the last occurrence.

    z1 <- rep(0,length.out = 6)
    x2CalcUpper <- timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = "upper")
    x2CalcUpper
    #> [1] 0.0000000 0.9975504 2.0003153 3.0225882 3.9559027 5.0000000

We can verify that there is no development on these interval.

    timeScale(x2CalcLower, x2CalcUpper, model = model, conditions = conditions, param = param)
    #> [1] 0 0 0 0 0 0

>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
WARNING: Numerical problems persist with the inverse (and `timeShift`)
in presence of null rate, you should avoid to use the functions in such
context until it is fixed.

### Function timeShift

<<<<<<< HEAD
Function `timeShift` is similiar to the inverse operation of timeScale,
and calculate the time `x2`, from a reference `x1`, after which a
specific period (`scaledPeriod`) has elapsed in the scaled domain. Both
`x1` and `scaledPeriod` are vectors. Here, we set various initial time
(`x1`) but set the period as a constant (reaching 1). The resulting
vector correspond to the end of development of each cohort.
=======
Function timeShift is similiar to the inverse operation of timeScale,
and calculate the time `x2`, from a reference `x1`, after which a
specific period (`scaledPeriod`) has elapsed in the scaled domain. Both
`x1` and `scaledPeriod` through the entry vectors. Here, we set various
initial time (`x1`) but set the period as a constant (reaching 1). The
resulting vector correspond to the end of development of each cohort.
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09

    x1 = seq(0,3,length.out = 6)
    scaledPeriod = rep(1,length.out = 6)
    x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param)
    x2
    #> [1] 0.265939 1.216326 1.529545 2.270528 3.277050 3.301795

## Package structure

This section is not required to use the package, but will help
understand the mechanics behind.

-   `timeScale` and `timeShift` both start by performing validity
    checks, which are encapsulated in functions with name starting by
    validity (`validityConditions`, `validityModel`,
    `validityScaledPeriod`, `validityScaledTime`, `validityTime`).
-   For the direct `timeScale`:
    -   `conditions` variables are interpolated using `interpolateCond`,
        which return a list of functions associated to each variable. At
        the moment, only constant interpolation is possible, but other
<<<<<<< HEAD
        methods are planned for future versions.
    -   A composite model function is made by substituting the temporal
=======
        methods would likely be considered in future versions.
    -   composite model function is made by substituting the temporal
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
        response of variables (the interpolation of conditions) into
        model variables. The resulting model is a function depending
        only on time.
    -   The composite model is integrated between two time bounds (`x1`
        and `x2`). They can be any values in the range defined by
        conditions.
-   For the inverse option of `timeScale`:
    -   Models usually can return zero values, the rate therefore cannot
        be inverted before integration.
    -   The approach adopted is to estimate time difference (from zero)
        for a defined period corresponding to bounds of scaled time.
        This operation is accomplished by `timeShift`.
-   For `timeShift`:
    -   The idea is to find at which time, the time elapsed in the
        scaled domain (calculated by the function `timeScale`) would
<<<<<<< HEAD
        reach a defined period (`scaledPeriod`).
=======
        reach a defined period (scaledPeriod).
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09
    -   This can be accomplish by finding the root of the timeScale
        function minus the objective scaled period.
    -   As the rate is positive, the cumulative function is always
        increasing and there is only one root, or only one interval of
<<<<<<< HEAD
        roots.
    -   The latter case is encountered when the objective scaled period
        is reached at the same time the rate become zero; it would then
        be associated to a time interval rather than a unique solution.
        In this situation, the function give the choice to return either
        the upper or lower bound. This operation is performed by the
        function `intervalUniroot`. Time intervals with zero rate are
        identified from `conditions` by the function `rleInterval`.

## A work in progress

The package is still in development, but a functional version would be
available soon. Solving numerical problems and improving speed is the
priority. Functionalities to be added and current issues are detailed in
the GitHub issues section. Suggestions to improve the package are always
welcome.
=======
        roots. If the objective scaled period is reached when the rate
        become zero, it would be associated to a time interval rather
        than a unique solution. The upper or lower bound is then return.
        This operation is performed by the function `intervalUniroot`.
        Time intervals with zero rate are identified from `conditions`
        by the function `rleInterval`.

## A work in progress

The package is still improving. A first functional version would be
available soon. More models, examples and documentation will be added in
the future. Functionalities to be added and current issues are detailed
in the GitHub issues section. Suggestions to improve the package are
always welcome.
>>>>>>> df25ab2211929f6ea42dcf141aa2efb0dca3fb09