
<!-- README.md is generated from README.Rmd. Please edit that file -->

# StoXreader

<!-- badges: start -->

<!-- badges: end -->

The primary goal of StoXreader is to smoothly import and combine public
StoX estimate reports from the Institute of Marine Research, available
at:
<https://www.hi.no/hi/forskning/marine-data-forskningsdata/bestandovervakning>.
The package also includes simple functions to visualize weight-at-age by
year or stratum.

A data frame from Barents Sea Northeast Arctic cod bottom trawl index in
winter is included in this package and contains data from 1999 to 2019.
This can be used for data exploration and visualization.

## Installation

You can install the development version of StoXreader from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("amalieepaulsen/StoXreader")
```

## About read_stox()

read_stox() is the primary import function in the StoXreader package.
StoX data folders downloaded from IMR’s website contain three text files
in ~/output/baseline/report. These files are estimate reports on
abundance, biomass, and mean weight. They all contain tables with length
groups and age, and are separated by stratum. read_stox() is a function
that can import any three StoX files with the same format as long as the
file names are unchanged.

## Examples

The text files in the example have been downloaded from:
<https://metadata.nmdc.no/metadata-api/landingpage/4abaafc79163a4ffed0b2ec7f2aca002>.

``` r
library(StoXreader)

a_path <- system.file(
  "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Abundance.txt",
  package = "StoXreader")
b_path <- system.file(
  "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_Biomass.txt",
  package = "StoXreader")
w_path <- system.file(
  "extdata/stox_winter_2019/2_EstimateByPopulationCategory_Reports_MeanWeight.txt",
  package = "StoXreader")

head(read_stox(a_path, b_path, w_path))
#>   LenGrp Stratum Age Abundance Biomass (kg) Mean Weight (g)
#> 1   5-10       1   1        86          0.7             8.0
#> 2  10-15       1   1      2381         31.8            13.3
#> 3  15-20       1   1       158          4.5            28.8
#> 4  15-20       1   2       211          9.0            42.4
#> 5  20-25       1   2       129          8.2            63.4
#> 6  25-30       1   2        59          7.4           125.0
```
