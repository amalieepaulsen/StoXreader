#' Create character vector object from the first column of a StoX file
#' @description
#' stox_vector() is a nested function in find_all_strata() and read_stox() that
#' takes a file path and converts the first column of the txt file into a
#' character vector so the number of lines can be compared.
#' @param path Path to the txt file. Passed on from find_all_strata() or read_stox()
#' @returns A `character` vector object.
#' @importFrom readr read_table
#' @importFrom dplyr pull
#' @examples
#' path <- system.file(
#'   "stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
#'   package = "StoXreader")
#'
#' stox_vector(path)
#' @export

stox_vector <- function(path) {
  # Suppressing read_table() warnings because the parsing errors do not affect
  # the function.
  suppressWarnings({
    firstcol <- readr::read_table(
      file = path, col_names = FALSE, skip_empty_rows = FALSE)
    dplyr::pull(firstcol, .data$X1)})
}
