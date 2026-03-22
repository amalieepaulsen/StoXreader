library(baizer)
library(dplyr)

combine_cod <- function() {
  # Empty data frame.
  total_cod <- data.frame()
  # Generic file paths.
  a_path = "data-raw/cod_0000/2_EstimateByPopulationCategory_Reports_Abundance.txt"
  b_path = "data-raw/cod_0000/2_EstimateByPopulationCategory_Reports_Biomass.txt"
  w_path = "data-raw/cod_0000/2_EstimateByPopulationCategory_Reports_MeanWeight.txt"
  # Iterate over every year between 1999 and 2019.
  for (i in c(1999:2019)) {
    a_year <- str_replace_loc(x = a_path, start = 14, end = 17, as.character(i))
    b_year <- str_replace_loc(x = b_path, start = 14, end = 17, as.character(i))
    w_year <- str_replace_loc(x = w_path, start = 14, end = 17, as.character(i))

    cod_year <- read_stox(a_year, b_year, w_year)
    cod_year$"Year" <- rep(i, each = nrow(cod_year))

    total_cod <- dplyr::bind_rows(total_cod, cod_year)
  }
  return(total_cod)
}

cod <- combine_cod()

usethis::use_data(cod, overwrite = TRUE)
