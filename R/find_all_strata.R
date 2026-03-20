#' Find locations of all abundance tables per stratum
#' @description
#' A helper function designed to locate all tables in a StoX file if they are
#' separated by stratum. To extract the desired rows and columns, the location
#' to extract data from is needed.
#' @param path Path to the txt file
#' @returns A `data.frame`
#' @importFrom stringr str_count
#' @examples
#' path <- system.file("extdata/stox_winter_2019_2019/output/baseline/report/2_EstimateByPopulationCategory_Reports_Abundance.txt", package = "StoXreader")
#' find_all_strata(path)
#' @export

# insert function below. still a work in progress. temporary function to create
# documentation file:
find_all_strata <- function(path) {
  print("hi")
}
