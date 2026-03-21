test_that("test mainfunc 2019", {
  a_path <- system.file(
    "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  b_path <- system.file(
    "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Biomass.txt",
    package = "StoXreader")
  w_path <- system.file(
    "stox_winter_2019/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
    package = "StoXreader")
  x <- read_stox(a_path, b_path, w_path)
  expect_equal(x$Abundance[1], 86)
})

test_that("test mainfunc 2009", {
  a_path <- system.file(
    "stox_winter_2009/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  b_path <- system.file(
    "stox_winter_2009/2_EstimateByPopulationCategory_Reports_Biomass.txt",
    package = "StoXreader")
  w_path <- system.file(
    "stox_winter_2009/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
    package = "StoXreader")
  x <- read_stox(a_path, b_path, w_path)
  expect_equal(x$Abundance[1], 550)
})

test_that("test mainfunc 1999", {
  a_path <- system.file(
    "stox_winter_1999/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  b_path <- system.file(
    "stox_winter_1999/2_EstimateByPopulationCategory_Reports_Biomass.txt",
    package = "StoXreader")
  w_path <- system.file(
    "stox_winter_1999/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
    package = "StoXreader")
  x <- read_stox(a_path, b_path, w_path)
  expect_equal(x$Abundance[1], 3157)
})
