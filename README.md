
# currr

<!-- badges: start -->
<!-- badges: end -->

`currr` provides a deferred-evaluation interface for `dplyr` operations. 
`currr` functions create curried versions of `dplyr` verbs; the user provides all arguments except for the data frame.
This allows data-manipulation operations to be composed _as functions_, without the need to provide data up front.


## Installation

``` r
devtools::install_github("mikedecr/currr")
```

## Example

This is a basic example which shows you how to solve a common problem:

```r
library(currr)
library(dplyr)

# filter mpg == max(mpg)
# with dplyr, data and function are combined
mtcars |> filter(mpg == max(mpg))

# with currr, function is separated from the data
flt_max_mpg = filtering(mpg == max(mpg))
flt_max_mpg(mtcars)


# filter max mpg, by am
# with dplyr: must rewrite the filter step
mtcars |> group_by(am) |> filter(mpg == max(mpg))

# with currr, pre-defined functions are reusable and composable
by_am = grouping(am)
(by_am %|% flt_max_mpg)(mtcars)
```

