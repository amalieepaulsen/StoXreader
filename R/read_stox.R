#' Read StoX report files
#' @description
#' Publicly available StoX files of Barents Sea Northeast Arctic cod bottom
#' trawl index in winter are divided into strata. The way these files are
#' formatted makes them require additional inputs to be converted into data
#' frames.
#'
#' The three files in ~/output/baseline/report are reports on abundance, biomass,
#' and mean weight. read_stox() takes these three files, and imports and merges
#' them into a single data frame.
#' @param a_path Path to abundance txt file.
#' @param b_path Path to biomass txt file.
#' @param w_path Path to mean weight txt file.
#' @returns A `data.frame`
#' @importFrom tidyr drop_na
#' @importFrom rlang .data
#' @examples
#' a_path <- system.file(
#'   "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
#'   package = "StoXreader")
#' b_path <- system.file(
#'   "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Biomass.txt",
#'   package = "StoXreader")
#' w_path <- system.file(
#'   "stox_winter_2019/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
#'   package = "StoXreader")
#'
#' read_stox(a_path, b_path, w_path)
#' @export

read_stox <- function(a_path, b_path, w_path) {
  # Check to confirm the files have been assigned the correct variable names.
  if (!grepl("Abundance", a_path)) {
    stop("a_path must be the path of the abundance report file and contain
         'Abundance' in the file name.")
  }
  if (!grepl("Biomass", b_path)) {
    stop("b_path must be the path of the biomass report file and contain
         'Biomass' in the file name.")
  }
  if (!grepl("MeanWeight", w_path)) {
    stop("w_path must be the path of the mean weight report file and contain
         'MeanWeight' in the file name.")
  }
  # Reports from the same year should all have the same number of lines.
  a_vector <- stox_vector(path = a_path)
  b_vector <- stox_vector(path = b_path)
  w_vector <- stox_vector(path = w_path)

  if (length(a_vector) != length(b_vector) | length(a_vector) != length(w_vector)) {
    stop("Files must have the same number of lines. Have you checked that they
         are from the same year?")
  }
  # When everything has been verified, start calling on functions to read files.
  line_info <- find_all_strata(path = a_path)
  a_data <- import_stox(path = a_path, line_info = line_info, report_type = "Abundance")
  b_data <- import_stox(path = b_path, line_info = line_info, report_type = "Biomass")
  w_data <- import_stox(path = w_path, line_info = line_info, report_type = "MeanWeight")

  # Add biomass and mean weight data to abundance data.frame.
  a_data$"Biomass (kg)" <- b_data$Biomass
  a_data$"MeanWeight (g)" <- w_data$MeanWeight

  as.data.frame(a_data) |>
    tidyr::drop_na(.data$Abundance)
}
