
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

A demonstration of `currr` by contrasting with `dplyr`.

```r
library(currr)
library(dplyr)
```

How to filter with `dplyr`: we need the data (`mtcars`) and the arguments (`mpg == max(mpg)`) when we call `filter`.

```{r}
# filter mpg == max(mpg)
# with dplyr, data and function are combined
mtcars |> filter(mpg == max(mpg))
```

How to filter with `currr`: `filtering` only requires the arguments (`mpg == max(mpg)`).
This creates a _curried_ `filter` function that fixes the arguments.
We can then call the curried function any time later by passing the data (`mtcars`).

```{r}
# with currr, function is separated from the data
flt_max_mpg = filtering(mpg == max(mpg))
flt_max_mpg(mtcars)
```


The benefit of `currr` becomes more apparent when functions are composed.

With `dplyr`, if I want to apply the same filter step on a _grouped_ data frame, I have to type all of my `filter` code again.

```{r}
# filter max mpg, by am
# with dplyr: must rewrite the filter step
mtcars |> group_by(am) |> filter(mpg == max(mpg))
```

But with `currr`, I already wrote a filter function.
I can recycle that function by composing it with another function (`grouping`).

```{r}
# with currr, pre-defined functions are reusable and composable
by_am = grouping(am)
(by_am %;% flt_max_mpg)(mtcars)
```

As my data analysis code grows more complex, the value of pre-defining small functions pays greater rewards.

**`currr` functions produces _memoized_ functions of data frames**, which cache values according to their inputs.
If a curried function has already computed its result on a data frame, passing the same data frame returns the cached value instead of recomputing it.
This lets us achieve the same efficiency of storing "intermediate data frames" without actually needing to manage those intermediate objects.

