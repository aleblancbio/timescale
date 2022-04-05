test_that("intervalUniroot returns specified bound (unconstrained)", {
  #Define a function that reach zero at a +- delta
  f <- function(x, a, delta){
    y <- rep(0,length = length(x))
    y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
    y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
    
    return(y)  
  }
  #Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 1
  constantLower <- (a - delta)
  constantUpper <- (a + delta)
  lower = - 10
  upper = 10
  
  #Interval uniroot return constant lower and upper if unconstrained
  correction = "constantLower"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
  expect_equal(y, constantLower, tolerance=1e-3)
  
  correction = "constantUpper"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
  expect_equal(y, constantUpper, tolerance=1e-3)
})

test_that("intervalUniroot returns specified bound (constrained)", {  
  #Define a function that reach zero at a +- delta
  f <- function(x, a, delta){
    y <- rep(0,length = length(x))
    y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
    y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
    
    return(y)  
  }
  #Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 1
  constantLower <- (a - delta)
  constantUpper <- (a + delta)
  lower = 4.5
  upper = 5.5
  
  #Interval if constrained
  correction = "constantLower"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
  expect_equal(y, lower, tolerance=1e-3)
  
  correction = "constantUpper"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, a = a, delta = delta)
  expect_equal(y, upper, tolerance=1e-3)
})

test_that("intervalUniroot returns specified bound or not depending on tol (when numerically outside)", {
  #Define a function that reach zero at a +- delta
  f <- function(x, a, delta){
    y <- rep(0,length = length(x))
    y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
    y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
    
    return(y)  
  }
  #Case outside tolerance
  ##Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 0
  constantLower <- (a - delta) + 1e-2
  constantUpper <- (a + delta) - 1e-2
  lower = -10
  upper = 10
  
  ##Interval if outside 
  tol = 1e-3
  correction = "constantLower"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, tol = tol, a = a, delta = delta)
  expect_true(abs(y - constantLower) >= 1e-3) #expected
  
  correction = "constantUpper"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, tol = tol, a = a, delta = delta)
  expect_true(abs(y - constantUpper) >= 1e-3) #expected
  
  #Case within tolerance
  ##Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 0
  constantLower <- (a - delta) + 1e-2
  constantUpper <- (a + delta) - 1e-2
  lower = -10
  upper = 10
  
  ##Interval if outside (within tolerance)
  tol = 1e-1
  correction = "constantLower"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, tol = tol, a = a, delta = delta)
  expect_equal(y, constantLower, tolerance=1e-3)
  
  correction = "constantUpper"
  y <- intervalUniroot(f, lower, upper, constantLower, constantUpper, correction = correction, tol = tol, a = a, delta = delta)
  expect_equal(y, constantUpper, tolerance=1e-3)
})

