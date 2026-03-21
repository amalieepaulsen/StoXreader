#' Find locations of all tables by stratum in StoX report file
#' @description
#' find_all_strata() is designed to locate all tables in a StoX report file if
#' they are separated by stratum. To import the desired rows and columns, the
#' location to extract data from is needed.
#' @param path Path to the txt file.
#' @returns A `data.frame` with the number of lines to skip on import (n_skip),
#' the number of rows (n_rows), and stratum number (stratum_n).
#' @importFrom readr read_table
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_integer
#' @importFrom stringr str_locate
#' @importFrom tidyr drop_na
#' @importFrom rlang .data
#' @import dplyr
#' @examples
#' path <- system.file(
#' "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
#' package = "StoXreader")
#'
#' find_all_strata(path)
#' @export

find_all_strata <- function(path) {
  if (!endsWith(path, ".txt")) {
    stop("File must end with .txt")
  }
  # Suppressing read_table() warnings because the parsing errors do not affect
  # the function.
  suppressWarnings({
    firstcol <- readr::read_table(
      file = path, col_names = FALSE, skip_empty_rows = FALSE)
    stoxvector <- dplyr::pull(firstcol, .data$X1)})
  # n_distance is the distance between the line number of the string and the
  # start/end point of the table. Negative n_distance implies the start/end
  # points being above the line the strings are located on.
  n_skip <- locate_startend(vector = stoxvector, string = "LenGrp", n_distance = -1)
  n_end <- locate_startend(vector = stoxvector, string = "TSN", n_distance = -3)

  suppressWarnings({
    stratum_n <- readr::read_table(
      file = path, col_names = c("est", "value"),
      col_types = readr::cols("est" = col_character(), "value" = col_integer()),
      skip = n_skip[1] - 4
      ) |>
      dplyr::filter(.data$est == "Stratum:") |>
      dplyr::pull(.data$value)})

  data.frame(n_skip, n_end, stratum_n) |>
    dplyr::mutate(n_rows = n_end - n_skip) |>
    dplyr::select(n_skip, .data$n_rows, stratum_n) |>
    tidyr::drop_na(stratum_n) # Final stratum is always "TOTAL".
}
