Dates in R
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
    tab1 { padding-left: 4em; }
    tab2 { padding-left: 8em; }
    tab3 { padding-left: 12em; }
    tab4 { padding-left: 16em; }
    tab5 { padding-left: 20em; }
    tab6 { padding-left: 24em; }
    tab7 { padding-left: 28em; }
    tab8 { padding-left: 32em; }
    tab9 { padding-left: 36em; }
    tab10 { padding-left: 40em; }
    tab11 { padding-left: 44em; }
    tab12 { padding-left: 48em; }
    tab13 { padding-left: 52em; }
    tab14 { padding-left: 56em; }
    tab15 { padding-left: 60em; }
    tab16 { padding-left: 64em; }
</style>


Warm Up
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+200px">
Sys.Date()
<br/><br/>
Sys.time()
</div>


***


```r
Sys.Date()
```

```
[1] "2019-06-05"
```

```r
Sys.time()
```

```
[1] "2019-06-05 12:39:15 EEST"
```

```r
class(Sys.Date())
```

```
[1] "Date"
```

```r
class(Sys.time())
```

```
[1] "POSIXct" "POSIXt" 
```


DateTime classes
========================================================
left: 50%
class: medium-code

*POSIXct*

```r
Sys.time()
```

```
[1] "2019-06-05 12:39:15 EEST"
```

```r
t <- Sys.time(); class(t)
```

```
[1] "POSIXct" "POSIXt" 
```
Time (sec) since the beginning of 1970

```r
as.numeric(t)
```

```
[1] 1559727555
```

DateTime classes
========================================================
class: medium-code

*POSIXlt*


```r
lt <- as.POSIXlt(t)
lt
```

```
[1] "2019-06-05 12:39:15 EEST"
```

```r
class(lt)
```

```
[1] "POSIXlt" "POSIXt" 
```

```r
as.matrix(lt)
```

```
     sec        min  hour mday mon year  wday yday  isdst zone   gmtoff 
[1,] "15.38083" "39" "12" "5"  "5" "119" "3"  "155" "1"   "EEST" "10800"
```


Date
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+200px">
as.Date(...)

</div>

***


```r
as.Date(c("2018-02-14", "2018-03-18"))
```

```
[1] "2018-02-14" "2018-03-18"
```

```r
as.Date(c("2018/02/14", "2018/03/18"))
```

```
[1] "2018-02-14" "2018-03-18"
```

```r
as.Date(c("2018-02-14", "2018/03/18"))
```

```
[1] "2018-02-14" NA          
```

```r
as.Date(c("2018-02-14", "2018/03/18"), format = "%Y/%m/%d")
```

```
[1] NA           "2018-03-18"
```

strptime
========================================================
left: 25%
class: medium-code
<pre>
<div style="color:#4488CC;font-size:180%;margin-top:+100px">
strptime(

   x = ,

   format = ,
    
   tz = 

)

</div>
</pre>


***


```r
strptime(c("2018-02-14", "2018-03-18"), format = "%Y-%m-%d")
```

```
[1] "2018-02-14 EET" "2018-03-18 EET"
```

```r
strptime(c("2018Feb14", "2018Mar18"), format = "%Y%b%d")
```

```
[1] NA NA
```


```r
Sys.setlocale(locale = "eng")
```


```r
strptime(c("2018Feb14-00:12:33", "2018Mar18-14:44:44"), format = "%Y%b%d-%H:%M:%S")
```

```
[1] "2018-02-14 00:12:33 EET" "2018-03-18 14:44:44 EET"
```


readr
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:150%;margin-top:+200px">
parse_datetime

</div>

***


```r
library(readr)
parse_datetime(c("2018Feb14", "2018Mar18"), format = "%Y%b%d")
```

```
[1] "2018-02-14 UTC" "2018-03-18 UTC"
```

```r
parse_datetime(c("2018Feb14", "2018Mar18"), format = "%Y%b%d", locale = locale("fr"))
```

```
[1] NA NA
```

```r
locale("fr")
```

```
<locale>
Numbers:  123,456.78
Formats:  %AD / %AT
Timezone: UTC
Encoding: UTF-8
<date_names>
Days:   dimanche (dim.), lundi (lun.), mardi (mar.), mercredi (mer.),
        jeudi (jeu.), vendredi (ven.), samedi (sam.)
Months: janvier (janv.), février (févr.), mars (mars), avril (avr.), mai
        (mai), juin (juin), juillet (juil.), août (août),
        septembre (sept.), octobre (oct.), novembre (nov.),
        décembre (déc.)
AM/PM:  AM/PM
```


Exercise
========================================================
class: medium-code

Given dates:

```r
dates <- c("2001-09-02", "2012-03", "2017", "2005-05-05", "2013", "2012-12-29", "2011-11", "2007", "2010-04-16")
```

1. Impute: missing day as 01, missing month and day as 01-01.
2. Read the imputed dates.
3. Find the latest and the earliest date.
4. Arrange the dates.
5. Calculate "study days" (date - ref. date + 1) with regards to today's date.

Hints: 
* `nchar`,&nbsp;&nbsp;&nbsp;&nbsp; `[...] <-`,&nbsp;&nbsp;&nbsp;&nbsp; `parse_date`
* remember: dates are just formatted numbers



lubridate [parsing]
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:130%;margin-top:+100px">
ymd, mdy, dmy
</div>

<div style="color:#4488CC;font-size:130%;margin-top:+100px">
..._hms
</div>

<div style="color:#4488CC;font-size:130%;margin-top:+100px">
make_date(time)
</div>

***

```r
library(lubridate)
mdy("06-04-2011")
```

```
[1] "2011-06-04"
```

```r
dmy("04/06/2011")
```

```
[1] "2011-06-04"
```

```r
ymd_hms("2011-06-04 12:00:00", tz = "GMT")
```

```
[1] "2011-06-04 12:00:00 GMT"
```

```r
make_date(2011, 07, 31)
```

```
[1] "2011-07-31"
```

lubridate [extracting/setting]
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:130%;margin-top:+50px">
year, month, day, hour, ...
</div>
<div style="color:#4488CC;font-size:130%;margin-top:+100px">
date
</div>
<div style="color:#4488CC;font-size:130%;margin-top:+100px">
...(...) <-
</div>

***

```r
t <- ymd_hms("2011-06-04 12:00:00")
year(t)
```

```
[1] 2011
```

```r
date(t)
```

```
[1] "2011-06-04"
```

```r
second(t) <- 25; t
```

```
[1] "2011-06-04 12:00:25 UTC"
```

lubridate [duration]
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:130%;margin-top:+50px">
dyears, ddays, dhours ...
</div>

***


```r
dyears()
```

```
[1] "31536000s (~52.14 weeks)"
```

```r
ymd("2012/11/10") + dyears(1)
```

```
[1] "2013-11-10"
```

Exercise
========================================================
class: medium-code

Datetimes of procedure start:

```r
dt_chr <- c("2015-02-13T00:51:00", "2015-02-14T23:58:00", "2015-02-16T22:59:00")
```
1. Read datetimes from the character vector. 
2. Calculate datetimes of procedure end as pr. start + 1 hour.

Hints:
* `ymd_hms` will work here, but it's better to use `parse_datetime` to avoid unexpected surprises
* previous slide

More
========================================================
* `vignette("lubridate")`
* [Dates and Times in R](https://www.stat.berkeley.edu/~s133/dates.html)
* ["Dates and times" chapter in R4DS](http://r4ds.had.co.nz/dates-and-times.html)
* [Overview](https://rpubs.com/davoodastaraky/lubridate)
