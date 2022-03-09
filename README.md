# timescale

OBJECTIVES
Obj. 1. Scale time according to a model defining the rate in function of variables given as time series (conditions)
Obj. 2. Allow different number and naming of conditions
Obj. 3. Allow different types of interpolation of conditions.
  Note: step function might cause problem on integration
Obj. 4. Allow back transformation into time
  Note: Inverse of rate does not exist when it reach zero
Obj. 5. Provide models for several examples of applications
  Note: Need to look into the litterature
Obj. 6. Particular case of finding the exact time (positive or negative) associated with a given physiological time

PLAN
Focus on 1-2 with a case of interpolation and simple models as a test (1 then 2 variables)
Broaden interpolations on 3 (constant, linear, splines).
Look for a case of real models in various fields on (part of 5)
More thourough completion of real models in 5

EXAMPLES OF APPLICATIONS
 1. Conversion of time into degree days or other non-linear physiological or development time for ectotherms such as insects.
 2. Conversion of time into development time of fungi, depending on temperature and relative humidity
 3. Conversion of time into physiological time from summarized temperature (min, mean, max) or temperature
 4. Find the harvest time for a crop given a seedling date, or inversely find the seedling date to achieve harvest at the desired date.


DATA TYPES
x: time (numeric)
Model: function name representing an instantaneous rate at which time elapse in the new scale
Conditions: data.frame containing a column called time, and other columns as variables

Problem:
  variable name in the model must correspond to those in the object condition
  variable name in the model must be ditinguished from parameters and time
  The number and name of the variables and parameter can change between models
  Avoid unecessary structure as in S4 or R6

Solution.
  Use var = list('x','y') and param = list('a', 'b') in the model
  Access the variable name under var in the model,
  In interpolateModel, Check that the condition data.frame share the same variable name and also have    time as variable


FUNCTIONS
several rateModelThermal (e.g. modelBriere1999)
  Start name with model
  Variables. var = list(x,y)
  Parameters. args = list(a = 1, b = 2)
  Must be vectorized according to x, y
  Return an object of the same size as x and y, must be greater or equal to zero

compatibility(conditions, model)
  Access the variable name under var in the model,
  Check that the conditions data.frame share the same variable name
  Check conditions have time as variable


interpolateCond(x, conditions, method)
  A function to interpolate conditions
  Act as a function of x (return an object with same number of columns as conditions, but the same length as x)

compoundModel(rateModel,condModel)
  take function name as entries
  A function that represent realized rate (compound of conditions and the model)
  return rateModelTemporal

timeScaleDirect(time, compoundModel)
  A function to integrate realized rate function and evaluate at specified time
  Returning only a vector of the same size as time

timeScaleInverse(time, compoundModel)
  A function to provide the inverse relation of integration (later)
  Identify domain on which the model is zero

timeScale(time, conditions, model, interpolation, parameters)
  Wrapper function to encompass interpolation, composition as well as integration (direct or inverse)
  Ensure proper data flux and error handling
  time (numeric)
  conditions


