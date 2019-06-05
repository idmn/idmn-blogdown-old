### Original task

Create a function that:

1.  Based on the input dataframe (adsl) creates a BWEIGHT to BHEIGHT scatter plot with regression curves, colored by ARM. Also make it possible to define the plot's title.

2.  Make it possible to split the plot by two panels for males and females with the non-splitted layout as default.

``` r
library(ggplot2)
library(dplyr)
library(haven)

adsl <- haven::read_sas("data/adsl.sas7bdat")
```

### Solution

``` r
f <- function(adsl, title, split = FALSE) {
    p <- ggplot(adsl, aes(BHEIGHT, BWEIGHT, color = ARM)) +
        geom_point() +
        geom_smooth() +
        ggtitle(title)
    if(split) p <- p + facet_wrap(~SEX)
    p
}
```

``` r
f(adsl, "Baseline Weight to Height")
```

![](ggplot2_programming_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
f(adsl, "Baseline Weight to Height", split = TRUE)
```

![](ggplot2_programming_files/figure-markdown_github/unnamed-chunk-3-2.png)

### Question

Is it possible to define the variable to split by (not necessarily SEX variable) as a function attribute?

### Solution

`facet_wrap` allows to define facets with a character vector (see `?facet_wrap`)

``` r
f <- function(adsl, title, split = NULL) {
    p <- ggplot(adsl, aes(BHEIGHT, BWEIGHT, color = ARM)) +
        geom_point() +
        geom_smooth() +
        ggtitle(title)
    if(!is.null(split)) p <- p + facet_wrap(split)
    p
}
```

``` r
f(adsl, "Baseline Weight to Height", "ITTFL")
```

![](ggplot2_programming_files/figure-markdown_github/unnamed-chunk-5-1.png)
