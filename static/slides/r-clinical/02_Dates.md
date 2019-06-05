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
[1] "2018-04-05"
```

```r
Sys.time()
```

```
[1] "2018-04-05 18:27:09 EEST"
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
<div style="color:#4488CC;font-size:160%;margin-top:+100px">
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
strptime(c("2018Feb14", "2018Mar18"), format = "%Y%b%d", tz = "UTC+2")
```

```
[1] "2018-02-14 UTC" "2018-03-18 UTC"
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



DateTime classes
========================================================
left: 50%
class: medium-code

POSIXct

```r
Sys.time()
```

```
[1] "2018-04-05 18:27:10 EEST"
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
[1] 1522942031
```

***

POSIXlt





lubridate
========================================================
<div style="color:#4488CC;font-size:200%;margin-top:+200px">
Sys.time()
</div>
