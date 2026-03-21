#' Locate start or end points of tables in StoX report file based on distinct
#' strings
#' @description
#' locate_startend() is a nested function in find_all_strata() that takes a
#' character vector, string, and n_distance given by find_all_strata(), then
#' passes row numbers back to find_all_strata().
#' @param vector Character vector with identifiable strings.
#' @param string String to locate in file.
#' @param n_distance Distance from string to start/end point.
#' @returns A `numeric vector object` with the line numbers of the start or
#' end points of tables in StoX report files.
#' @importFrom stringr str_locate
#' @importFrom tidyr drop_na
#' @import dplyr
#' @examples
#' vector <- c("LenGrp", NA, "__", "10-15", "LenGrp", "15-20", "___", "LenGrp")
#' string <- "LenGrp"
#' n_distance <- 1 # E.g. if it is the line after "LenGrp" that is of interest.
#'
#' locate_startend(vector, string, n_distance)
#' @export

locate_startend <- function(vector, string, n_distance) {
  # Locating positions of string
  n_locate <- as.data.frame(str_locate(vector, string))

  row_num <- 1:nrow(n_locate) + n_distance
  # Extracting only row numbers associated with string
  data.frame(n_locate, row_num) |>
    tidyr::drop_na(.data$start) |>
    dplyr::pull(row_num)
}
