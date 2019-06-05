Functions and Loops
========================================================
author: Iaroslav Domin
date: 
autosize: false
width: 1300
height: 700

<style>
    .medium-code pre code {
      font-size: 1.2em;
    }
    
    table {
        border-collapse: collapse;
        width: 100%;
    }
    
    tr td:FIRST-CHILD{
        color:#4488CC;
        font-weight:bold;
    }
    
    th {
    background-color: #808080;
    color: white;
}
</style>




Functions
========================================================
class: medium-code
left: 40%

<font style="color:#4488CC;font-weight:bold;font-size:110%">
f <- function(x, y, z<font style = "background-color:#CCCCCC"> = T</font>, ...) {          <br/>
<pre><font style="font-size:260%">
&nbsp;&nbsp;   code    <br/>
</pre></font>
&nbsp;&nbsp;&nbsp;&nbsp;    result  <br/>
}

</font>

<br/>
<font style = "background-color:#CCCCCC">&nbsp;&nbsp;&nbsp;&nbsp;</font> - default value
<br/><br/>
`return` is optional:
<br/>
<font style="color:#4488CC;font-weight:bold;font-size:110%">
return(result)
</font>


***


```r
mean_ci <- function(x, alpha = .95){
    n <- length(x)
    se <- sd(x)/sqrt(n)
    ta <- qt(1 - (1 - alpha)/2, df = n - 1)
    mean(x) + c(-1, 1)*ta*se
}
```

```r
mean_ci(1:10)
```

```
[1] 3.334149 7.665851
```

```r
mean_ci(1:10, alpha = .9)
```

```
[1] 3.744928 7.255072
```


```r
f2c <- function(x){
    (x - 32)*5/9
}
```

Passing Arguments to a Function
========================================================
class: medium-code


* If you write names explicitly - use whatever the order you want.

```r
merge(by = "USUBJID", y = df1, x = df2)
```

* If you omit names - values will be assigned to all the unassigned arguments in the order in which they are listed in the function's definition. The following calls are equivalent:

```r
merge(by = "USUBJID", df1, df2)
```

```r
merge(by = "USUBJID", x = df1, y = df2)
```

* Sometimes functions have `...` (elipsis) argument. It means that the function is designed to take any number of named or unnamed arguments.

```r
dplyr::mutate(df, sum = x + y, diff = x - y) # you can use any names you want
plot(sin(1:100), type = "l") # type is one of the possible optional parameters
```




for
========================================================
class: medium-code
left: 30%

<font style="color:#4488CC;font-weight:bold;font-size:120%">
if (condition) {             <br/>
&nbsp;&nbsp;&nbsp;&nbsp;...  <br/>
} else {                     <br/>
&nbsp;&nbsp;&nbsp;&nbsp;...  <br/>
}
</font>

***


```r
library(lubridate)
day <- lubridate::wday(Sys.Date(), week_start = 1)
if (day == 5) {
    glue::glue("Woo-Hoo, it's Friday!")
} else {
    n <- (5 - day) %% 7
    glue::glue("Meh. Friday comes in {n} day(s).")
}
```

```
Woo-Hoo, it's Friday!
```



```r
conv_temp <- function(x, to = "c"){
    if (to == "c") return((x - 32)*5/9)
    else if (to == "f") return(x*9/5 + 32)
}
```

```r
conv_temp(1:10, to = "c") %>% conv_temp(to = "f")
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```

switch
========================================================
class: medium-code
left: 35%

<font style="color:#4488CC;font-weight:bold;font-size:120%">
switch(variable,                                <br/>
&nbsp;&nbsp;&nbsp;&nbsp;value_1 = expr_1,       <br/>
&nbsp;&nbsp;&nbsp;&nbsp;value_2 = expr_2,       <br/>
&nbsp;&nbsp;&nbsp;&nbsp;...                     <br/>
&nbsp;&nbsp;&nbsp;&nbsp;value_n = expr_n,       <br/>
&nbsp;&nbsp;&nbsp;&nbsp;[default value/action]  <br/>
)
</font>

***


```r
conv_temp <- function(x, to = "c"){
    switch(to,
        c = (x - 32)*5/9,
        f = x*9/5 + 32,
        stop("Unknown <to> parameter!")
    )
}
```

```r
conv_temp(1:10, "f")
```

```
 [1] 33.8 35.6 37.4 39.2 41.0 42.8 44.6 46.4 48.2 50.0
```

```r
conv_temp(1:10, "cm")
```

```
Error in conv_temp(1:10, "cm"): Unknown <to> parameter!
```


Exercise 1
========================================================
class: medium-code


```r
adsl <- haven::read_sas("data/adsl.sas7bdat")
```

Create a function that:

1. Based on the input dataframe (adsl) creates a BWEIGHT to BHEIGHT scatter plot with regression curves, colored by ARM. Also make it possible to define the plot's title.

2. Make it possible to split the plot by two panels for males and females with the non-splitted layout as default.

Hints:  <br/>
`geom_point`, `geom_smooth`, `ggtitle` <br/>
`facet_wrap`


For loops
========================================================
class: medium-code
left: 40%

<font style="color:#4488CC;font-weight:bold;font-size:120%">
for ([var] in [vector]) {             <br/>
&nbsp;&nbsp;&nbsp;&nbsp;do something  <br/>
}
</font>

***


```r
# ugly version of dplyr::glimpse
for (i in 1:ncol(adsl)) {
    paste0(names(adsl)[[i]], ": ",
           paste(head(adsl[[i]]),
                 collapse = ", ")) %>% 
        cat()
    cat("\n")
}
```



```r
# we can use character vector:
for (name in names(adsl)) {
    paste0(name, ": ",
           paste(head(adsl[[name]]),
                 collapse = ", ")) %>% 
        cat()
    cat("\n")
}
```

while and repeat
========================================================
class: medium-code
left: 40%

<font style="color:#4488CC;font-weight:bold;font-size:120%">
while (condition) {                   <br/>
&nbsp;&nbsp;&nbsp;&nbsp;do something  <br/>
}
</font>

<br/>

<font style="color:#4488CC;font-weight:bold;font-size:120%">
repeat {                   <br/>
&nbsp;&nbsp;&nbsp;&nbsp;do something  <br/>
}
</font>


this will be working until `break` is activated

***


```r
i <- 1
while (i < 5) {
    cat("i = ", i, "\n")
    i <- i + 1
}
```

```
i =  1 
i =  2 
i =  3 
i =  4 
```


```r
i <- 1
repeat {
    cat("i = ", i, "\n")
    i <- i + 1
    if (i == 5) break
}
```

```
i =  1 
i =  2 
i =  3 
i =  4 
```


Exercise 2
========================================================
class: medium-code


```r
avs <- read_sas("data/avs.sas7bdat")
```
The following function creates a VS overview plot for one patient.

```r
g_avs_subj <- function(avs, subj) {
    avs %>% 
        filter(USUBJID == subj, PARAMCD != "HEIGHT") %>%
        ggplot(aes(x = ADY, y = AVAL)) +
        geom_point() + geom_line() +
        facet_wrap(~PARAM, scales = "free_y") +
        ggtitle(glue::glue("{subj} Vital Signs"))
}
g_avs_subj(avs, "DBTVC15Y2014-0001-00001")
```
Use for loop to create such plots for all the patients and save them to PDFs. 

Hints: 

* When getting the list of all patients consider using `unique` function.

* `ggsave` 

apply functions family: apply
========================================================
class: medium-code
left: 45%

To be used with matrices

```r
m <- matrix(sample(1:9), nrow = 3)
m
```

```
     [,1] [,2] [,3]
[1,]    5    4    9
[2,]    6    2    8
[3,]    1    7    3
```

```r
apply(m, MARGIN = 1, sum)
```

```
[1] 18 16 11
```

```r
apply(m, MARGIN = 2, sum)
```

```
[1] 12 13 20
```

***

with an unnamed function:


```r
apply(
    m, MARGIN = 1,
    function(x) paste(sort(x), collapse = "-")
)
```

```
[1] "4-5-9" "2-6-8" "1-3-7"
```


apply functions family: lapply
========================================================
class: medium-code


```r
library(stringr)
files <- list.files("data", full.names = TRUE, pattern = ".sas7bdat$")
files <- files[!str_detect(files, "alb")] # just to save time
files
```

```
[1] "data/adae.sas7bdat" "data/adeg.sas7bdat" "data/adsl.sas7bdat"
[4] "data/avs.sas7bdat" 
```

```r
ana <- lapply(files, read_sas)
names(ana) <- basename(files) %>% str_remove(".sas7bdat")
```
result is a list:

```r
lapply(ana, dim)
```

```
$adae
[1] 688  75

$adeg
[1] 2658   35

$adsl
[1] 46 39

$avs
[1] 1411   75
```

apply functions family: sapply
========================================================
class: medium-code

tries to _simplify_ the result


```r
sapply(ana, dim)
```

```
     adae adeg adsl  avs
[1,]  688 2658   46 1411
[2,]   75   35   39   75
```

type-unstable


```r
sapply(ana, nrow)
```

```
adae adeg adsl  avs 
 688 2658   46 1411 
```


purrr package: map functions
========================================================
class: medium-code
left: 30%

<font style="color:#4488CC;font-weight:bold;font-size:120%">
map<font style="color:#808080">_...</font>(.x, .f, ...)
</font>

<font style="font-size:70%">
<font style="color:#4488CC;font-weight:bold">.x</font>  - input object                        <br/>
<font style="color:#4488CC;font-weight:bold">.f</font>  - function to apply to each element   <br/>
<font style="color:#4488CC;font-weight:bold">...</font> - (optional) other parameters to .f  
</font>

<font style="font-size:120%">
<table style="width:100%">
    <tr>
        <th> function </th>
        <th> result </th>
    </tr>
    <tr>
        <td>  `map`</td>
        <td>  list</td>
    </tr>
    <tr>
        <td>  `map_lgl`</td>
        <td>  logical</td>
    </tr>
    <tr>
        <td>  `map_int`</td>
        <td>  integer</td>
    </tr>
    <tr>
        <td>  `map_dbl`</td>
        <td>  double</td>
    </tr>
    <tr>
        <td>  `map_chr`</td>
        <td>  character</td>
    </tr>
</table>
</font>

***

```r
library(purrr)
ana <- map(files, read_sas)
names(ana) <- str_remove(basename(files), ".sas7bdat")
```


```r
map_dbl(ana, nrow)
```

```
adae adeg adsl  avs 
 688 2658   46 1411 
```

```r
1:3 %>% map(rnorm, mean = 10)
```

```
[[1]]
[1] 11.02786

[[2]]
[1] 10.08086 11.12898

[[3]]
[1] 13.007379 11.285054  8.855329
```


Anonymous functions in purrr
========================================================
class: medium-code
left: 40%

* <font style="color:#4488CC;font-weight:bold;font-size:120%">~</font> &nbsp;&nbsp;
<font style="font-size:80%">before the function definition</font>
* <font style="color:#4488CC;font-weight:bold;font-size:120%">.</font> &nbsp;&nbsp;
<font style="font-size:80%">as the argument</font>

***


```r
map_lgl(ana, ~ "AVISIT" %in% names(.))
```

```
 adae  adeg  adsl   avs 
FALSE  TRUE FALSE  TRUE 
```

Filter all the dataframes:

```r
map(ana, ~filter(., USUBJID == "DBTVC15Y2014-0005-00002"))
```
Use pipes!

```r
ana %>% 
    map(~filter(., USUBJID == "DBTVC15Y2014-0005-00002")) %>% 
    map_int(nrow)
```

```
adae adeg adsl  avs 
  15   32    1   19 
```



Exercise 3
========================================================
We take `ana$adae` dataframe and keep only date columns.

```r
df <- select(ana$adae, ends_with("DTM"))
```

1. Use `map_dbl` to find maximum value in each column. Hint: data.frame is a list of vectors underneath.
2. Find the overall maximum.
3. Convert it to dates againg with `lubridate::as_datetime`

Exercise 4
========================================================
Grade 4 AEs:

```r
adae4 <- filter(ana$adae, AETOXGR == 4)
```
Use `semi_join` from dplyr and `map` to filter all the dataframes in ana to have only patients that had gr. 4 AEs.

Links
========================================================

* [R4DS: Functions](http://r4ds.had.co.nz/functions.html)
* [purrr cheat sheet](https://github.com/rstudio/cheatsheets/blob/master/purrr.pdf)
