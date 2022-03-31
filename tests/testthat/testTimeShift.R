test_that("Composition timeScale on timeShift return initial values of scaledPeriod (non zero rate)", {
conditions <- data.frame(time = seq(0,30,length.out = 10), temp = 30 + rnorm(10, 10, 5))
model <- "modelLinear"
param = list(a = 1, T0 = 10)

#Initial time
x1 = rep(0,10,length.out = 10)
scaledPeriod = rep(10,10)

#Compute x2 scaled period
x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param)
scaledPeriodCalc <- timeScale(x1, x2, model = model, conditions = conditions, param = param)

#Equality given some rounding
expect_equal(scaledPeriod, scaledPeriodCalc, tolerance=1e-3)
})

test_that("Composition timeScale on timeShift return initial values of scaledPeriod (zero rate)", {
  conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 15, 5))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  x1 = rep(0,10,length.out = 10)
  scaledPeriod = rep(10,10)
  
  #Compute x2 scaled period
  x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param)
  scaledPeriodCalc <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
  
  #Equality given some rounding
  expect_equal(scaledPeriod, scaledPeriodCalc, tolerance=1e-3)
})

test_that("timeShift return proper values for a simple case (with zero rate)", {
#to be written (important)
  
  conditions <- data.frame(time = seq(0,5), temp = c(0,15,10,20,20,0))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  x1 = rep(0,6)
  scaledPeriod = c(0,5,10,15,20,25)
  
  #Compute x2 scaled period
  x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param)
  answer <- c(0,2,3.5,4,4.5,5) #Careful check at the second number
  
  #Equality given some rounding
  expect_equal(x2, answer, tolerance=1e-3)
  
})
