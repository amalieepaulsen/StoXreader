<<<<<<< HEAD
test_that("test import 2019", {
  path <- system.file(
    "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
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
=======
test_that("import works", {
  path <- system.file(
    "extdata/stox_winter_2019_2019/output/baseline/report/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  x <- count_strata(path)
  expect_equal(x, 26)
>>>>>>> 94a07e5cf4bd0247562027f9213a8002f0983c23
})
