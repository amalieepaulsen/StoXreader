#' Count number of strata in a StoX file
#' @description
#' A short description...
#' @param path Path to the txt file
#' @returns A `number`
#' @importFrom stringr str_count
#' @examples
#' path <- system.file("extdata/stox_winter_2019_2019/output/baseline/report/2_EstimateByPopulationCategory_Reports_Abundance.txt", package = "StoXreader")
#' count_strata(path)
#' @export

count_strata <- function(path) {
  if (!endsWith(path, ".txt")) {
    stop("Path must be a TXT file")
  }
  stoxstring <- readLines(path)
  strata <- stringr::str_count(string = stoxstring, pattern = "Stratum")
  sum(strata) - 1
}
