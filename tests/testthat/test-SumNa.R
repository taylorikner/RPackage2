data <- data.frame(
  col1 = c(1, NA, 3, "NA"),
  col2 = c("A", "B", "C", "D")
)

test_that("SumNa works", {
  expect_equal(SumNa(data$col1), 1)
  expect_equal(SumNa(data$col1, na_list = c("NA")), 2)
})