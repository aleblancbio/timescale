test_that("Composition of timeScale direct and inverse return initial values (non zero rate)", {
  conditions <- data.frame(time = seq(0,30,length.out = 10), temp = 20 + rnorm(10, 10, 5))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  x1 = rep(0,10,length.out = 10)
  x2 = seq(11,20,length.out = 10)
  
  #Scaled time
  y1 <- rep(0,10,length.out = 10)
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)

  #Scaling back to original time
  x2Calc <- timeScale(y1, y2, model = model, conditions = conditions, param = param, inverse = TRUE)
  
  #Equality given some rounding
  expect_equal(x2, x2Calc, tolerance=1e-3)
})


test_that("timeScale returns increasing values (with zero rate)", {
  set.seed(6)
  conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  n <- 1000
  x1 = rep(0,10,length.out = n)
  x2 = seq(0,30,length.out = n)
  
  #Scaled time
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
  z <- y2[2:n] - y2[seq.int(1,n-1)]
  z[z< 0]
  
  #Within bounds given some rounding
  expect_true(all(x2 >= x2CalcLower - 1e-3 & x2 <= x2CalcUpper + 1e-3))
  ###!!!Case with a few zero on start, problem with upper. Check intervalUniroot.
})

test_that("timeScale inverse return lower and upper bounds encompassing initial values (with zero rate)", {
  set.seed(6)
  conditions <- data.frame(time = seq(0,30,length.out = 10), temp = rnorm(10, 10, 5))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  x1 = rep(0,10,length.out = 10)
  x2 = seq(0,30,length.out = 10)
  
  #Scaled time
  y1 <- rep(0,10,length.out = 10)
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
  
  #Scaling back to original time
  x2CalcLower <- timeScale(y1, y2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = c("upper","lower"))
  x2CalcUpper <- timeScale(y1, y2, model = model, conditions = conditions, param = param, inverse = TRUE, assignConstant = c("lower","upper"))
  
  
  #Within bounds given some rounding
  expect_true(all(x2 >= x2CalcLower - 1e-3 & x2 <= x2CalcUpper + 1e-3))
  ###!!!Case with a few zero on start, problem with upper. Check intervalUniroot.
})

test_that("timeScale give proper values for simple model (constant interpolation)", {
  n = 21
  conditions <- data.frame(time = seq(0,20,length.out = n), temp = seq(0, 20,length.out = n))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  interpolation = "constant"
  
  #Initial time
  x1 = rep(0,n)
  x2 = conditions$time
  
  #Scaled time
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
  answer = c(0,cumsum(modelLinear(conditions$temp[seq(1,n-1)],param = list(a = 1, T0 = 10))))
  
  #Equality given some rounding
  expect_equal(y2, answer, tolerance=1e-3)
})

test_that("timeScale example with modelGDD", {
  n = 21
  conditions <- data.frame(time = seq(0,20,length.out = n), Tmin = seq(0, 20,length.out = n)-1, Tmax = seq(0, 20,length.out = n)+1)
  model <- "modelGDD"
  param <- list(T0 = 10)
  interpolation = "constant"
  control = list(method = 1)
  
  #Initial time
  x1 = rep(0,n)
  x2 = conditions$time
  
  #Scaled time
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param, control = control)
  answer = c(0,cumsum(modelGDD(conditions$Tmin[seq(1,n-1)],conditions$Tmax[seq(1,n-1)],param = list(a = 1, T0 = 10))))
  
  #Equality given some rounding
  expect_equal(y2, answer, tolerance=1e-3)
})

test_that("Composition of timeScale direct and inverse return initial values (non zero rate)", {
  conditions <- data.frame(time = seq(0,365,length.out = 100), temp = 20 + rnorm(10, 10, 5))
  model <- "modelLinear"
  param = list(a = 1, T0 = 10)
  
  #Initial time
  x1 = rep(0,10,length.out = 100)
  x2 = seq(11,20,length.out = 100)
  
  #Scaled time
  y1 <- rep(0,10,length.out = 100)
  y2 <- timeScale(x1, x2, model = model, conditions = conditions, param = param)
  
  #Scaling back to original time
  x2Calc <- timeScale(y1, y2, model = model, conditions = conditions, param = param, inverse = TRUE)
  
  #Equality given some rounding
  expect_equal(x2, x2Calc, tolerance=1e-3)
})
