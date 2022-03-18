# timescale

## Package Installation
devtools::install_github("aleblancbio/timescale") using devtools

## DESCRIPTION
timeScale and timeShift are

Advantage of the approach

Potential application. Underline those

The package is still improving. More models, examples and documentation will be added in the future.

## STRUCTURE OF THE PACKAGE
model and conditions as entries.
model def: rate model (hereafter model), model variables
conditions def:


timeScale. 
1. Checks are performed through functions which name start by validity.
  validityModel. 
  validityConditions ensure conditions respects some constraints, but mostly     ensure time is present, as well as the model variables.

2. conditions variables are interpolated using interpolateCond, which return a function

3. composeModel pass the interpolation of conditions variables into the model. The resulting function is only expressed as time

4. Integration of the composite function between specified bounds (time)

5. For the inverse operation, models usually can return zero values and the rate therfore cannot be inverted before integration. The approach preconised is to estimate time difference (from zero) for a defined period corresponding to bounds of scaled time. This operation is accomplished by timeShift.

6. timeShift idea is to find at which time, the time elapsed in the scaled domain (calculated by the function timeScale) would reach a defined period (scaledPeriod). This can be accomplish by finding the root of the timeScale function minus the objective scalePeriod.


## OBJECTIVES
Obj. 1. Scale time according to a model defining the rate in function of variables given as time series (conditions)

Obj. 2. Allow different number and naming of conditions

Obj. 3. Allow different types of interpolation of conditions.
  Note: step function might cause problem on integration
  
Obj. 4. Allow back transformation into time
  Note: Inverse of rate does not exist when it reach zero
  
Obj. 5. Provide models for several examples of applications
  Note: Need to look into the litterature
  
Obj. 6. Particular case of finding the exact time (positive or negative) associated with a given physiological time

Obj. 7. Allow date as entries of timeScale

## PLAN
Focus on 1-2 with a case of interpolation and simple models as a test (1 then 2 variables)
Broaden interpolations on 3 (constant, linear, splines).
Look for a case of real models in various fields on (part of 5)
Backtransform in 4 and allow date as entries in 7
Find particular time in 6
More thourough completion of real models in 5

## DETAILS TO IMPROVE
See GitHub issues section for details.

## EXAMPLES OF APPLICATIONS
 1. Conversion of time into degree days or other non-linear physiological or development time for ectotherms such as insects.
 2. Conversion of time into development time of fungi using temperature and relative humidity or precipitation;  plant growth with temperature and photoperiod or soil moisture. Look at Hydrothermal time (HTT) models for seed germination.
 3. Conversion of time into physiological time from summarized temperature (min, mean, max) or temperature
 4. Find the harvest time for a crop given a seedling date, or inversely find the seedling date to achieve harvest at the desired date.
 5. More complex cases: Chain models for various stages, distribution over parameters or variables



