#' Weight-age plot per year
#' @description
#' A simple function that filters data to a single year and plots fish age
#' against mean weight.
#' @param data A data.frame with StoX data.
#' @param condition A character string or number with the year.
#' @param facet Whether the plot should be wrapped into facets by stratum.
#' @returns A `ggplot` object with age on the x axis and mean weight on the y
#' axis. The points represent mean weight at specific ages.
#' @importFrom dplyr filter
#' @importFrom rlang .data
#' @import ggplot2
#' @examples
#' data <- cod
#' condition <- "1999"
#'
#' weight_age_y(data, condition)
#' @export

weight_age_y <- function(data, condition, facet = FALSE) {

  f_data <- data |>
    dplyr::filter(.data$Year == condition)

  if ({{facet}} == FALSE) {
    f_data |>
      ggplot2::ggplot(ggplot2::aes(x = .data$`Age`, y = .data$`Mean Weight (g)`)) +
      ggplot2::geom_point(color = "#22a884", alpha = 0.5) +
      ggplot2::theme_bw()
  }
  else {
    f_data |>
      ggplot2::ggplot(ggplot2::aes(x = .data$`Age`, y = .data$`Mean Weight (g)`)) +
      ggplot2::geom_point(color = "#22a884", alpha = 0.5) +
      ggplot2::theme_bw() +
      ggplot2::facet_wrap(~Stratum)
  }
}
