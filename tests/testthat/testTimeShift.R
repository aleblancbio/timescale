test_that("Composition timeScale on timeShift return initial values of scaledPeriod", {
conditions <- data.frame(time = seq(0,30,length.out = 10), temp = 30 + rnorm(10, 10, 5))
condModel <- interpolateCond(conditions, method = "linear")
model <- "modelLinear"
param = list(a = 1, T0 = 10)

#Initial time
x1 = rep(0,10,length.out = 10)
scaledPeriod = rep(10,10)

#Compute x2 scaled period
x2 <- timeShift(x1, scaledPeriod = scaledPeriod, model = model, conditions = conditions, param = param, interpolation = "linear")
scaledPeriodCalc <- timeScale(x1, x2, model = model, conditions = conditions, param = param, interpolation = "linear")


#Equality given some rounding
expect_equal(scaledPeriod, scaledPeriodCalc, tolerance=1e-3)
})