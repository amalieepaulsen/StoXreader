#' Read StoX report files
#' @description
#' Publicly available StoX files of Barents Sea Northeast Arctic cod bottom
#' trawl index in winter are divided into strata. The way these are formatted
#' makes them require additional inputs to be converted into data frames.
#'
#' The three files in ~/output/baseline/report are reports on abundance, biomass,
#' and mean weight. read_stox() takes these three files, and imports and merges
#' them into a single data frame.
#' @param a_path Path to abundance txt file.
#' @param b_path Path to biomass txt file.
#' @param w_path Path to mean weight txt file.
#' @returns A `data.frame`
#' @importFrom readr read_table
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_integer
#' @importFrom stringr str_locate
#' @importFrom tidyr drop_na
#' @importFrom rlang .data
#' @import dplyr
#' @examples
#' a_path <- system.file(
#' "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
#' package = "StoXreader")
#' b_path <- system.file(
#' "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Biomass.txt",
#' package = "StoXreader")
#' w_path <- system.file(
#' "stox_winter_2019/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
#' package = "StoXreader")
#'
#' read_stox(a_path, b_path, w_path)
#' @export

read_stox <- function(a_path, b_path, w_path) {
  # Reports from the same year should all have the same number of lines.
  a_vector <- stox_vector(path = a_path)
  b_vector <- stox_vector(path = b_path)
  w_vector <- stox_vector(path = w_path)

  if (length(a_vector) != length(b_vector) | length(a_vector) != length(w_vector)) {
    stop("Files must have the same number of lines. Have you checked that they
         are from the same year?")
  }
  find_all_strata(path = a_path)
}
