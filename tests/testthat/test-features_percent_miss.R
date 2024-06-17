x <- tibble::tribble(
  ~feature, ~SumNa, ~SumComp, ~PctNa, ~PctComp,
  'mpg',         0,      32,        0,       1,
  'cyl',         0,      32,        0,       1,
  'disp',        0,      32,        0,       1,
  'hp',          0,      32,        0,       1,
  'drat',        0,      32,        0,       1,
  'wt',          0,      32,        0,       1,
  'qsec',        0,      32,        0,       1,
  'vs',          0,      32,        0,       1,
  'am',          0,      32,        0,       1,
  'gear',        0,      32,        0,       1,
  'carb',        0,      32,        0,       1
)

class(x) <- c("features_percent_miss", class(x))


test_that("features_percent_miss works mtcars", {
  expect_equal(
    features_percent_miss(mtcars) |>
      dplyr::arrange(feature)
    ,
    x |>
      dplyr::arrange(feature)
    )
})

# nrow(mtcars)
#
# y <- mtcars
# y$mpg <- NA
#
# test_that("features_percent_miss works mtcars 2", {
#   expect_equal(features_percent_miss(mtcars), x)
# })

treatment <- tribble(
  ~person,           ~treatment, ~response,
  "Derrick Whitmore", 1,         7,
  NA,                 2,         10,
  NA,                 3,         NA,
  "Katherine Burke",  1,         4
)

x <- tibble(feature  = c('person', 'response', 'treatment'),
       SumNa    = c(  2,           1,             0      ),
       SumComp  = c(  2,           3,             4      ),
       PctNa    = c( 1/2,         1/4,            0    ),
       PctComp  = c( 1/2,         3/4,            1    ) )

class(x) <- c("features_percent_miss", class(x))

test_that("features_percent_miss works treatment", {
  expect_equal(
    features_percent_miss(treatment) |>
      dplyr::arrange(feature)
    ,
    x |>
      dplyr::arrange(feature)
    )
})
