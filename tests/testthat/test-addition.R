x <- runif(1,-1000,1000)
y <- runif(1,-2000,2000)

test_that("addition works", {
  expect_equal(addition(2,2), 4)
  expect_equal(addition(2,-2), 0)
  expect_equal(addition(4,5), 9)
  expect_equal(addition(x,y), x+y)
})
