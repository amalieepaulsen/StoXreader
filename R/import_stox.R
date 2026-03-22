#' Import and elongate individual StoX report files
#' @description
#' import_stox() is a nested function in read_stox(). Its purpose is to import
#' the raw Stox files, then iterate over every table using the location
#' information given by line_info() and combine the tables into a single
#' data frame.
#' @param path Path to the txt file. Passed on from read_stox()
#' @param line_info A `data.frame` with three columns; n_skip, n_rows, and
#' stratum_n that provides information about table locations and their
#' associated stratum number.
#' @param report_type A character string to name value column after elongating.
#' @returns A `data.frame` with the number of lines to skip on import (n_skip),
#' the number of rows (n_rows), and stratum number (stratum_n).
#' @importFrom readr read_table
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_number
#' @importFrom tidyr pivot_longer
#' @importFrom rlang .data
#' @importFrom utils head
#' @import dplyr
#' @examples
#' path <- system.file(
#'   "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
#'   package = "StoXreader")
#' line_info <- data.frame(
#'   n_skip = c(9, 51, 93, 135),
#'   n_rows = c(26, 26, 26, 26),
#'   stratum_n = c(1, 2, 3, 4))
#' report_type <- "Abundance"
#'
#' import_stox(path, line_info, report_type)
#' @export

import_stox <- function(path, line_info, report_type) {
  # Empty data.frame.
  output_df <- data.frame()

  for(i in 1:nrow(line_info)) {
    suppressWarnings({input_df <- read_table(
      path, col_types = cols(.default = col_number(), "LenGrp" = col_character()),
      na = "-", skip = line_info[i, 1], n_max = line_info[i, 2])})

    # File structure causes column names and values to be misaligned. Fix
    # before binding rows.
    oldcolnames <- head(colnames(input_df), -3)
    tempcolnames <- append(oldcolnames, "skip", 1)
    newcolnames <- head(tempcolnames, -1)
    # Columns with total values are not desired. Remove rows in "LenGrp" that
    # are not length groups.
    small_df <- input_df |>
      select(1:(ncol(input_df)-3)) |>
      dplyr::rename_at(vars(oldcolnames), ~newcolnames) |>
      dplyr::select(- .data$skip) |>
      dplyr::filter(grepl("-", .data$LenGrp))

    complete_df <- small_df |>
      dplyr::mutate(Stratum = rep(as.character(line_info[i, 3]), each = nrow(small_df)))

    output_df <- dplyr::bind_rows(output_df, complete_df)
  }
  output_df |>
    dplyr::relocate(.data$Stratum, .after = dplyr::last_col()) |>
    tidyr::pivot_longer(
      cols = colnames(output_df)[2]:colnames(output_df)[ncol(output_df)],
      names_to = "Age", values_to = report_type
    ) |>
    dplyr::mutate(Age = as.numeric(.data$Age))
}
