test_that("test year plot", {
  data <- cod
  condition <- 1999
  x <- weight_age_y(data, condition)
  expect_equal(class(x)[1], "ggplot2::ggplot")
})

test_that("test stratum plot", {
  data <- cod
  condition <- 1999
  x <- weight_age_y(data, condition)
  expect_equal(class(x)[1], "ggplot2::ggplot")
})
