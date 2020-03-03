
<!-- README.md is generated from README.Rmd. Please edit that file -->

# definer

<!-- badges: start -->

<!-- badges: end -->

The goal of definer is to make it easy to apply field maps / survey data
definitions to datasets with integer coding.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("davisadamw/definer")
```

## Example

A very basic example of what this does:

``` r
# create a definitions dataset linking coded values of various variables to what they represent
def_list <- tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                   value      = c(1,   2,   1,   2,   1),
                   definition = c('cat', 'dog', 'fred', 'george', 'lonely')) %>%
  def_prep(variable, value, definition, drop_solos = FALSE)

# make a little source dataset to run this on
source_data <- tibble(ID = c('A1', 'A2', 'A3'),
                      A  = c(1, 1, 2),
                      B  = c(2, 1, 2),
                      C  = c(1, 1, 1))

# run the mass recoding
updated_values <- def_recode_all(source_data, def_list)

# display the results side-by-side
left_join(source_data, updated_values, 
          by = 'ID', suffix = c('_old', '_new'))
#> # A tibble: 3 x 7
#>   ID    A_old B_old C_old A_new B_new  C_new 
#>   <chr> <dbl> <dbl> <dbl> <chr> <chr>  <chr> 
#> 1 A1        1     2     1 cat   george lonely
#> 2 A2        1     1     1 cat   fred   lonely
#> 3 A3        2     2     1 dog   george lonely
```
