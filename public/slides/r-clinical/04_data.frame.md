data.frame
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
</style>




Basics
========================================================
class: medium-code

`data.frame` = list of vectors (or even lists) of the same length

To create - base R **data.frame** function, but it's better to use **dplyr::data_frame**

```r
library(dplyr)
df <- data_frame(
    USUBJID = c("A-001", "A-002", "B-001", "B-002"),
    SEX = c("M", "F", "F", "M"),
    AGE = c(69, 54, 71, 57)
)
df
```

```
# A tibble: 4 x 3
  USUBJID SEX     AGE
  <chr>   <chr> <dbl>
1 A-001   M       69.
2 A-002   F       54.
3 B-001   F       71.
4 B-002   M       57.
```

read/write
========================================================


**read.table** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **read.delim** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **read.csv** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...

**write.table** &nbsp;&nbsp;&nbsp;&nbsp; **write.delim** &nbsp;&nbsp;&nbsp;&nbsp; **write.csv** &nbsp;&nbsp;&nbsp;&nbsp; ...

* **readr** package with &nbsp;&nbsp;&nbsp;&nbsp;**read_csv**&nbsp;&nbsp;&nbsp;&nbsp; **read_delim** &nbsp;&nbsp;&nbsp;&nbsp;... 
* **haven** package with &nbsp;&nbsp;&nbsp;&nbsp;**read_sas** &nbsp;&nbsp;&nbsp;&nbsp; **read_xpt**
&nbsp;&nbsp;&nbsp;&nbsp; **read_spss** &nbsp;&nbsp;&nbsp;&nbsp; ...


```r
adsl <- read_sas("data/adsl.sas7bdat")
adsl <- read.csv("data/adsl.csv", sep = ";")
```


First Look
========================================================
class: medium-code


* View in a separate tab: **View**
* dimensions: &nbsp;&nbsp;**dim**&nbsp;&nbsp;&nbsp;&nbsp;**nrow**&nbsp;&nbsp;&nbsp;&nbsp;**ncol**
* variable names: &nbsp;&nbsp;**names**
* **head** and **tail**
* **summary**&nbsp;&nbsp;&nbsp;&nbsp;**dplyr::glimpse**




Extract Columns
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:150%;margin-top:+20px">
names
<br/><br/>
$...
</div>

<div style="color:#4488CC;font-size:150%;margin-top:+240px">
[[...]]
</div>


***


```r
names(df)
```

```
[1] "USUBJID" "SEX"     "AGE"    
```

```r
df$AGE
```

```
[1] 69 54 71 57
```
<br/>


```r
df[[2]]
```

```
[1] "M" "F" "F" "M"
```


Subsetting
========================================================
left: 30%
class: medium-code

<div style="color:#4488CC;font-size:150%;margin-top:+170px">
[rows, cols]
</div>


***


```r
df[3:4, -2]
```

```
# A tibble: 2 x 2
  USUBJID   AGE
  <chr>   <dbl>
1 B-001     71.
2 B-002     57.
```

```r
df[c(T, F, T, F), c("USUBJID")]
```

```
# A tibble: 2 x 1
  USUBJID
  <chr>  
1 A-001  
2 B-001  
```

```r
df[,c("USUBJID", "SEX")]
```

```
# A tibble: 4 x 2
  USUBJID SEX  
  <chr>   <chr>
1 A-001   M    
2 A-002   F    
3 B-001   F    
4 B-002   M    
```

Exercise 1
========================================================


```r
library(haven)
adsl <- read_sas("data/adsl.sas7bdat")
View(adsl)
```

Display `SUBJID`, `SEX`, `AGE`, `BWEIGHT` and `BHEIGHT` for patients older than 75.

Hints:
* subset by logical vector
* you need to extract one specific column for this


dplyr 
========================================================


```r
library(dplyr)

adsl <- read_sas("data/adsl.sas7bdat")
adsl %>% 
    select(ARM, matches("FL$")) %>% 
    group_by(ARM) %>% 
    summarise_all(funs(100*mean(. == "Y")))
```

```
# A tibble: 2 x 5
  ARM       FASFL SAFFL ITTFL ENRLFL
  <chr>     <dbl> <dbl> <dbl>  <dbl>
1 Stratum A  100.  100.  41.7   100.
2 Stratum B  100.  100.  59.1   100.
```



Subset Columns:   select
========================================================
class: medium-code
left: 40%

* include by names
<br/><br/><br/>
* exclude with `-` 
<br/><br/><br/>
* use regular expressions
<br/><br/><br/>
* select ranges


***


```r
select(adsl, USUBJID, ARM)
```
<br/>

```r
select(adsl, -TRT01A, -TRT01AN)
```
<br/>

```r
select(adsl, USUBJID, matches("FL$"))
```
<br/>

```r
select(adsl, STUDYID:SEX)
```


Subset Rows: filter
========================================================
class: medium-code


```r
adsl %>% 
    select(USUBJID, SEX, BWEIGHT) %>% 
    filter(BWEIGHT >= 70, SEX == "M")
```

```
# A tibble: 18 x 3
   USUBJID                 SEX   BWEIGHT
   <chr>                   <chr>   <dbl>
 1 DBTVC15Y2014-0001-00002 M        78.2
 2 DBTVC15Y2014-0002-00002 M        76.0
 3 DBTVC15Y2014-0002-00004 M        86.0
 4 DBTVC15Y2014-0003-00001 M        77.6
 5 DBTVC15Y2014-0004-00001 M        75.0
 6 DBTVC15Y2014-0005-00001 M        77.0
 7 DBTVC15Y2014-0006-00003 M        73.0
 8 DBTVC15Y2014-0006-00004 M        80.0
 9 DBTVC15Y2014-0007-00001 M        70.5
10 DBTVC15Y2014-0007-00002 M        71.0
# ... with 8 more rows
```

Create Columns: mutate
========================================================
class: medium-code


```r
adsl %>% 
    select(SUBJID, BWEIGHT, BHEIGHT) %>% 
    mutate(BHIGHT_M = BHEIGHT/100, BBMI = BWEIGHT/BHIGHT_M^2)
```

```
# A tibble: 46 x 5
   SUBJID BWEIGHT BHEIGHT BHIGHT_M  BBMI
   <chr>    <dbl>   <dbl>    <dbl> <dbl>
 1 00001     67.0    165.     1.65  24.6
 2 00002     78.2    162.     1.62  29.8
 3 00001     56.5    155.     1.55  23.5
 4 00002     76.0    173.     1.73  25.4
 5 00003     68.0    172.     1.72  23.0
 6 00004     86.0    181.     1.81  26.3
 7 00001     77.6    170.     1.70  26.9
 8 00002     67.0    158.     1.58  26.8
 9 00003     57.0    160.     1.60  22.3
10 00001     75.0    172.     1.72  25.4
# ... with 36 more rows
```

Sort: arrange
========================================================
class: medium-code


```r
adsl %>% 
    select(USUBJID, ARM, AGE) %>% 
    arrange(ARM, desc(AGE))
```

```
# A tibble: 46 x 3
   USUBJID                 ARM         AGE
   <chr>                   <chr>     <dbl>
 1 DBTVC15Y2014-0012-00001 Stratum A   83.
 2 DBTVC15Y2014-0003-00001 Stratum A   81.
 3 DBTVC15Y2014-0007-00002 Stratum A   77.
 4 DBTVC15Y2014-0001-00002 Stratum A   76.
 5 DBTVC15Y2014-0008-00001 Stratum A   74.
 6 DBTVC15Y2014-0022-00002 Stratum A   72.
 7 DBTVC15Y2014-0019-00001 Stratum A   71.
 8 DBTVC15Y2014-0043-00001 Stratum A   68.
 9 DBTVC15Y2014-0001-00001 Stratum A   66.
10 DBTVC15Y2014-0009-00004 Stratum A   66.
# ... with 36 more rows
```


Grouping: group_by
========================================================
class: medium-code

with **summarise**

```r
adsl %>% 
  group_by(SEX) %>% 
  summarise(
    MEAN_H = mean(BHEIGHT, na.rm = T),
    MAX_H = max(BHEIGHT, na.rm = T)
  )
```

```
# A tibble: 2 x 3
  SEX   MEAN_H MAX_H
  <chr>  <dbl> <dbl>
1 F       165.  182.
2 M       173.  185.
```
***

with **mutate**

```r
avs %>%
  select(SUBJID, PARAMCD, AVAL) %>%
  group_by(SUBJID, PARAMCD) %>%
  mutate(MAX = max(AVAL, na.rm = T)) %>% 
  ungroup()
```

```
# A tibble: 1,411 x 4
   SUBJID PARAMCD  AVAL   MAX
   <chr>  <chr>   <dbl> <dbl>
 1 00001  DIABP     85.   91.
 2 00001  DIABP     78.   91.
 3 00001  DIABP     80.   91.
 4 00001  DIABP     72.   91.
 5 00001  DIABP     78.   91.
 6 00001  DIABP     61.   91.
 7 00001  DIABP     72.   91.
 8 00001  HEIGHT   165.  185.
 9 00001  PULSE     80.  126.
10 00001  PULSE     80.  126.
# ... with 1,401 more rows
```


Counts: count, add_count
========================================================
class: medium-code
left: 50%

Count subgroups 

```r
count(adsl, ARM, SEX)
```

```
# A tibble: 4 x 3
  ARM       SEX       n
  <chr>     <chr> <int>
1 Stratum A F         9
2 Stratum A M        15
3 Stratum B F        11
4 Stratum B M        11
```
Attach counts to data

```r
add_count(adsl, ARM, SEX)
```
***

Variable correspondence

```r
avs <- read_sas("data/avs.sas7bdat")
count(avs, PARAMCD, AVALU)
```

```
# A tibble: 14 x 3
   PARAMCD AVALU           n
   <chr>   <chr>       <int>
 1 DIABP   ""             22
 2 DIABP   mmHg          207
 3 HEIGHT  ""              2
 4 HEIGHT  cm             44
 5 PULSE   ""             21
 6 PULSE   BEATS/MIN     208
 7 RESP    ""             61
 8 RESP    BREATHS/MIN   160
 9 SYSBP   ""             22
10 SYSBP   mmHg          207
# ... with 4 more rows
```



Advanced
========================================================

**mutate_all** &nbsp;&nbsp;&nbsp;&nbsp;**mutate_at** &nbsp;&nbsp;&nbsp;&nbsp;**mutate_if** 

**summarise_all**&nbsp;&nbsp;&nbsp;&nbsp; **summarise_at**&nbsp;&nbsp;&nbsp;&nbsp; **summarise_if**

...



```r
adsl %>% mutate_at(
    funs(. == "Y"),
    .vars = vars(matches("FL$"))
)
```

Exercise 2
========================================================
class: medium-code


```r
avs <- read_sas("data/avs.sas7bdat")
adae <- read_sas("data/adae.sas7bdat")
```

1. avs: Select SUBJID, PARAMCD, AVAL varialbes. Create a logical variable, showing when AVAL equals to the maximum value among all the measurements of this SUBJID-PARAMCD.

2. adae: For all patients calculate the highest grade of each type of event they had.

3. adae: Extract the summary for "Thrombocytopenia" AEDECOD only


Data merging: base R merge and dplyr join functions
========================================================
class: medium-code
left: 30%


Intersection
<br/><br/>
Full
<br/><br/>
All from first
<br/><br/>
All from second
***



```r
merge(adae, adsl, by = "USUBJID")                #base
inner_join(adae, adsl, by = "USUBJID")           #dplyr
```


```r
merge(adae, adsl, by = "USUBJID", all = TRUE)    #base
full_join(adae, adsl, by = "USUBJID")            #dplyr
```


```r
merge(adae, adsl, by = "USUBJID", all.x = TRUE)  #base
left_join(adae, adsl, by = "USUBJID")            #dplyr
```


```r
merge(adae, adsl, by = "USUBJID", all.y = TRUE)  #base
right_join(adae, adsl, by = "USUBJID")           #dplyr
```

semi_join, anti_join
========================================================

**semi_join**: keep all records that have matches in the second dataframe

**anti_join**: drop all records that have matches in the second dataframe


```r
adae %>% semi_join(filter(adsl, AGE >= 70), by = "USUBJID")
```

Exercise 3
========================================================
How many patients did not have any AEs? No vs measurements?

