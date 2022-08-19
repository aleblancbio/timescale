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
scaling of time. The package was developed to calculate development time
of ectotherms in function of temperature, but has been built to deal
with any other time scaling. The package offers predefined models, but
models defined by the user are also accepted.

## Why use this package for development time?

Calculating development over a temperature series is relatively
straightforward and does not require a whole package. The `timescale`
package was developed to bring two important operations that become
useful when manipulating development time beyond simple cases:

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

-   From historical temperature data, calculating when to sow crops to
    obtain uniform intervals at harvest and provide a continuous supply
    at market.

-   Scaling time according to a model that use more than only
    temperature as a variable. Hydrothermal time (HTT) for seed
    germination is an example involving both temperature and water
    potential of the substrate and temperature.

-   Calculating growing degree days for crop, using daily records of
    minimum and maximum temperature (use two variables).

## Useful functions

The main functions are `timeScale` and `timeShift`, no other function
require to be explicitly called.

-   `timeScale`: the function evaluates the time elapsed between two
    bounds (`x1`, `x2`) into a scaled domain. The later is defined by a
    rate model (simply called `model` in the package) and `conditions`
    that represent its variables in function of time. If the option
    `inverse` is chosen, time in the scaled domain is converted back to
    time.

-   `timeShift`: the function estimates the upper bounds `x2` that would
    correspond to a specified period elapsed in the scaled domain.

## Model and conditions

Although `model` and `conditions` are not objects belonging to a defined
class (such as in S4 and R6); they must however respect some structure
and conditions to be accepted by `timeScale` and `timeShift`.

-   `model` is a function defined by the user that return the rate at
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

-   `conditions` is a `data.frame` that contains one column named `time`
    and other columns with the same name as the model variables. It
    represents the evolution of the model variable through time. Checks
    are made when calling `timeScale` and `timeShift` to ensure
    `conditions` and the `model` are compatibles. Other checks are made
    on `conditions`, including `time` must be a strictly increasing
    `numeric` vector. Units of times must simply match the definition of
    the model, with day usually being used.

## Examples

### Specifying conditions and model

We will first load libraries and generate random hourly temperature data
for a month, with time represented in days as `numeric`.

    library(timescale)
    library(ggplot2)
    set.seed(11)
    time <- seq(0, 30, by = 1/24)
    temp <- 0.15*time + 5*sin(2*pi*time) + rnorm(length(time), mean = 10, sd = 2.5)
    conditions <- data.frame(time = time, temp = temp)

Plotting the data we have:

    p<-ggplot(conditions, aes(x=time, y=temp)) + 
      geom_point() +
      geom_line() +
      theme_classic()
    p

![](C:/Users/alebl/AppData/Local/Temp/RtmpecTEt9/preview-411412b522f9.dir/overview_files/figure-markdown_strict/unnamed-chunk-3-1.png)

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
    #> <bytecode: 0x0000000012d235b0>
    #> <environment: namespace:timescale>

Once we have defined the function, we can simply refer to the function
name. Here, we will also arbitrarily set the base temperature `T0 = 10`
<sup>∘</sup>C and the normalizing constant `a = 1/GDD`, with the total
degree day to complete development `GDD = 25`; a development of 1 then
correspond to its completion. Alternatively, we could have chosen
`a = 1` in order to accumulate degree days.

    model <- "modelLinear"
    param <- list(T0 = 10, a = 1/25)

### Function timeScale

We then use the `timeScale` function to compute the development (`z2`)
between a reference `x1` and some other time `x2` (it can differ from
the one of `conditions`).

    x1 = rep(0,length.out = 7)
    x2 = seq(0,30, by = 5)
    z2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
    z2
    #> [1] 0.0000000 0.3681821 0.9185467 1.4634378 2.1620458 2.9934984 3.9490163

The function `timeScale` integrates the model over time, which requires
to define conditions variables between measurements. For the sake of
simplicity and performance, conditions values are considered constant in
time until the next measurement. This should be reasonable in most
context as meteorological data now tend to be available at short
intervals.

### Function timeShift

Function `timeShift` calculates the time `x2`, from a reference `x1`,
after which a specific period (`scaledPeriod`) has elapsed in the scaled
domain. Both `x1` and `scaledPeriod` are vectors. Here, we set different
initial time (`x1`) for a period of one. The resulting vector correspond
to the end of development of different cohorts.

    x1 = seq(0,20,length.out = 5)
    scaledPeriod = rep(1,length.out = 5)

    x2Lower <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param, assignConstant = "lower")
    x2Lower
    #> [1] 10.31953 13.97435 18.14138 21.50734 25.99118

Note that when development rate defined by the model is zero for some
period, the corresponding scaled time `z2` remain constant over that
period. In that case, there is no unique value of `x2` that correspond
to `z2`. The function `timeShift` return one of the time interval limits
associated to the scaled time `z2` (i.e. either the first or last time
the organism reached the specified development (`z2`)). The interval
limit is specified by the option `assignConstant` which can take either
`"lower"` (default) or `"upper"` as values. In practice, it is however
unlikely that `z2` is both exactly reached and maintained. Here is a
case in which we look for the situation.

    x2Problem <- max(conditions$time[conditions$temp <= param$T0])
    x1Problem <- rep(0,length.out = length(x2Problem))
    z2Problem <- timeScale(x1Problem, x2Problem, model = model, conditions = conditions, param = param)
    z2Problem
    #> [1] 3.932317

    x2Lower <- timeShift(x1Problem, scaledPeriod = z2Problem , model = model, conditions = conditions, param = param, assignConstant = "lower")
    x2Lower
    #> [1] 29.83333

    x2Upper <- timeShift(x1Problem, scaledPeriod = z2Problem, model = model, conditions = conditions, param = param, assignConstant = "upper")
    x2Upper
    #> [1] 29.875

### Function timeScale (inverse)

For the inverse operation of `timeScale`, we simply have to use the
option `inverse = TRUE` and specify entries as development instead of
time. The function compute the time elapsed between bounds `z1` (a
reference) and `z2`, provided in the scaled domain. From the first
example, we would calculate `z2` back into `x2`, using zero as a
reference for `z1` (since `x1` and `z1` both coincide at zero).

    z1 <- rep(0,length.out = 7)
    x2CalcLower <- timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = c("lower", "lower"))
    x2CalcLower
    #> [1]  0.000000  4.666667  9.999999 15.000053 20.000006 24.999985 30.000000

The calculation is really similar to `timeShift`, and time associated to
`z1` and `z2` are not always unique if they fall at moments when the
development rate is zero. The situation is more likely to happen for
`timeScale` inverse than for `timeShift`, mostly because the reference
`z1` is set by the user, although one can also choose it to avoid the
problem. The function require to specify `assignConstant` for both `z1`
and `z2`, with the default value `assignConstant = c("lower", "lower")`.
Note that the original values `x2` is always confined between
estimations from `assignConstant = c("upper", "lower")` and
`assignConstant = c("lower", "upper")` (within some numerical error).

    z1 <- rep(0,length.out = 7)
    x2CalcIn <- timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = c("upper", "lower"))
    x2CalcIn 
    #> [1] -0.04166666  4.62500000  9.95833235 14.95838589 19.95833930 24.95831813
    #> [7] 29.95833334

    x2
    #> [1]  0  5 10 15 20 25 30

    x2CalcOut <- timeScale(z1, z2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = c("lower", "upper"))
    x2CalcOut
    #> [1]  0.04166666  5.00000000  9.99999902 15.00005255 20.00000596 24.99998480
    #> [7] 30.00000000

## Package structure

This section is not required to use the package, but will help
understand the mechanics behind.

-   `timeScale` and `timeShift` both start by performing validity
    checks, which are encapsulated in functions with a name starting by
    validity (`validityConditions`, `validityModel`,
    `validityScaledPeriod`, `validityTime`).
-   For the direct `timeScale`:
    -   `conditions` variables are interpolated using `interpolateCond`,
        which return a list of functions describing each variable in
        function of time. At the moment, only constant interpolation is
        possible, which only require evaluation at conditions time.
        However, the approach allows to incorporate more easily other
        interpolation methods in the future.
    -   A composite model function is made by substituting the temporal
        response of variables (the interpolation of conditions) into
        model variables. The resulting model is a function depending
        only on time.
    -   The composite model (available from `timeModel`) is integrated
        between two time bounds (`x1` and `x2`), using
        `timeModelIntegral`. They can be any values in the range defined
        by conditions.
    -   In the case of constant interpolation, `timeModelIntegral`
        correspond to an analytical integration. The function
        `timeModel` compute once the summation of development at
        conditions time, the function `timeModelIntegral` simply refer
        to the the linear interpolation of this function.
-   For the inverse option of `timeScale`:
    -   Models usually can return zero values, the rate therefore cannot
        be inverted before integration.
    -   The approach adopted is to estimate time difference (from zero)
        for a defined period corresponding to bounds of scaled time.
        This operation is accomplished by `timeShift`.
-   For `timeShift`:
    -   The idea is to find at which time, the time elapsed in the
        scaled domain (calculated by the function `timeScale`) would
        reach a defined period (`scaledPeriod`).
    -   This can be accomplish by finding the root of the `timeScale`
        function minus the objective scaled period.
    -   As the rate is positive, the cumulative function is always
        increasing and there is only one root, or only one interval of
        roots.
    -   The latter case is encountered when the objective scaled period
        is reached at the same time the rate become zero; it would then
        be associated to a time interval rather than a unique solution.
        In this situation, the function give the choice to return either
        the upper or lower bound. This operation is performed by the
        function `intervalUniroot`.

## A work in progress

The package is still in development. Incorporating predefined models and
improving tests are the priority. Other functionalities to be added and
current issues are detailed in the GitHub issues section. Suggestions to
improve the package are always welcome.
