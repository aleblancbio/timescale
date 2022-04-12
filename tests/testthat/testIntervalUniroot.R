test_that("intervalUniroot returns specified bound (continuous, no gradient)", {
  #Define a function that reach zero at a +- delta
  g <- function(x, a, delta){
   y <- rep(0,length = length(x))
   y[x <= a - delta] <- x[x <= a - delta] - (a - delta)
   y[x >= a + delta] <- x[x >= a + delta] - (a + delta)
   
   return(y)  
  }
  
  #Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 1
  lower = - 10
  upper = 10
  
  #Without gradient provided
  y <- intervalUniroot(g, lower, upper, correction = "lower", a = a, delta = delta)
  answer <- (a - delta)
  expect_equal(y, answer, tolerance=1e-3)
  
  y <- intervalUniroot(g, lower, upper, correction = "upper", a = a, delta = delta)
  answer <- (a + delta)
  expect_equal(y, answer, tolerance=1e-3)
 
  y <- intervalUniroot(g, lower, upper, correction = "none", a = a, delta = delta)
  answer <-   uniroot(g, lower = lower, upper = upper, a = a, delta = delta)$root
  expect_equal(y, answer, tolerance=1e-3)
  
})

test_that("intervalUniroot returns specified bound (step function, no gradient)", {
  #Define a function that reach zero at a +- delta
  g <- function(x, a, delta){
    y <- rep(0,length = length(x))
    y[x < a - delta] <- -1
    y[x >= a + delta] <- 1
    
    return(y)  
  }
  
  #Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 1
  lower = - 10
  upper = 10
  
  #Without gradient provided
  y <- intervalUniroot(g, lower, upper, correction = "lower", a = a, delta = delta)
  answer <- (a - delta)
  expect_equal(y, answer, tolerance=1e-3)
  
  y <- intervalUniroot(g, lower, upper, correction = "upper", a = a, delta = delta)
  answer <- (a + delta)
  expect_equal(y, answer, tolerance=1e-3)
  
  y <- intervalUniroot(g, lower, upper, correction = "none", a = a, delta = delta)
  answer <-   uniroot(g, lower = lower, upper = upper, a = a, delta = delta)$root
  expect_equal(y, answer, tolerance=1e-3)
  
})

test_that("intervalUniroot returns specified bound (unique root)", {
  #Define a function that reach zero at a +- delta
  g <- function(x, a, delta){
    y <- rep(0,length = length(x))
    y[x < a - delta] <- -1
    y[x >= a + delta] <- 1
    
    return(y)  
  }
  
  #Define parameters and range on which the function is known to be constant
  a <- 5
  delta <- 0
  lower = - 10
  upper = 10
  
  #Without gradient provided
  y <- intervalUniroot(g, lower, upper, correction = "lower", a = a, delta = delta)
  answer <- (a - delta)
  expect_equal(y, answer, tolerance=1e-3)
  
  y <- intervalUniroot(g, lower, upper, correction = "upper", a = a, delta = delta)
  answer <- (a + delta)
  expect_equal(y, answer, tolerance=1e-3)
  
  y <- intervalUniroot(g, lower, upper, correction = "none", a = a, delta = delta)
  answer <-   uniroot(g, lower = lower, upper = upper, a = a, delta = delta)$root
  expect_equal(y, answer, tolerance=1e-3)
  
})

