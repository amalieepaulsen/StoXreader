test_that("test import 2019", {
  path <- system.file(
    "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  x <- find_all_strata(path)
  expect_equal(x[1, 1], 9)
})

test_that("test import 2009", {
  path <- system.file(
    "extdata/stox_winter_2009/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  x <- find_all_strata(path)
  expect_equal(x[1, 1], 9)
})

test_that("test import 1999", {
  path <- system.file(
    "extdata/stox_winter_1999/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  x <- find_all_strata(path)
  expect_equal(x[1, 1], 9)
})
