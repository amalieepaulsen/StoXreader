test_that("import works", {
  path <- system.file(
    "extdata/stox_winter_2019_2019/output/baseline/report/2_EstimateByPopulationCategory_Reports_Abundance.txt",
    package = "StoXreader")
  x <- count_strata(path)
  expect_equal(x, 26)
})
