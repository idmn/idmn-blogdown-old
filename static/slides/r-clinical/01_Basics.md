R Basics
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


RStudio General
========================================================

<br/>
<h3>Options</h3>

Tools > Global Options
- General - **uncheck** *"restore Rdata ..."*

- Appearance - setup how it looks

<br/>
<h3>Helpful Things</h3>

- Help > Cheatsheets

- Shortcuts: **Alt** + **Shift** + **K**


Assignment
========================================================
left: 35%

<div style="color:#4488CC;font-size:600%;margin-top:+200px">
<-
</div>
<br/><br/>
shortcut: **alt** + **-**

***


```r
x <- 100
x
```

```
[1] 100
```

```r
y <- x/2 - 5
y
```

```
[1] 45
```

<div style="color:#7e7e7e";font-size:30%;margin-left:5em>
Check the "Environment" tab - <b>x</b> and <b>y</b> just showed up
</div>

Vectors
========================================================
left: 30%
class: medium-code

<div style="color:#4488CC;font-size:400%;margin-top:+200px">
c(...)
</div>

***


```r
c(1.4, 3.5, 134)
```

```
[1]   1.4   3.5 134.0
```

```r
c(c(1.4, 3.5), 134)
```

```
[1]   1.4   3.5 134.0
```

```r
c("one", "two")
```

```
[1] "one" "two"
```

```r
c(TRUE, FALSE, T, F)
```

```
[1]  TRUE FALSE  TRUE FALSE
```


More on Vectors
========================================================
left: 30%
class: medium-code
<div style="color:#4488CC;font-size:220%;margin-top:+50px">
:
</div>

<div style="color:#4488CC;font-size:180%;margin-top:+100px">
seq(...)
</div>

<div style="color:#4488CC;font-size:180%;margin-top:+150px">
rep(x, ...)
</div>

***


```r
1:10
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```


```r
seq(from = 1, to = 10, by = 1)
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```


```r
rep(c("a", "b", "c"), times = 2)
```

```
[1] "a" "b" "c" "a" "b" "c"
```


```r
rep(c("a", "b", "c"), each = 2)
```

```
[1] "a" "a" "b" "b" "c" "c"
```

Notice
========================================================
class: medium-code

* Expect everything to be vectorized.

* Even scalars, i.e.&nbsp;&nbsp;  `9.8, "word", TRUE` are vectors of length 1 in fact.

```r
10*1:10 + 1
```

```
 [1]  11  21  31  41  51  61  71  81  91 101
```

* If vector lengths are different -> vector recycling.

```r
1:10 + c(0.1, 0.3)
```

```
 [1]  1.1  2.3  3.1  4.3  5.1  6.3  7.1  8.3  9.1 10.3
```



Classes and Conversion
========================================================
class: medium-code



```r
x <- c(-1.2, 0, 1.1)
s <- c("1", "one", "T")
l <- c(TRUE, FALSE, T, F)
```


```r
class(x)
```

```
[1] "numeric"
```

```r
class(s)
```

```
[1] "character"
```

```r
class(l)
```

```
[1] "logical"
```

***

```r
as.character(x)
```

```
[1] "-1.2" "0"    "1.1" 
```

```r
as.logical(x)
```

```
[1]  TRUE FALSE  TRUE
```

```r
as.numeric(s)
```

```
[1]  1 NA NA
```

```r
as.logical(s)
```

```
[1]   NA   NA TRUE
```

Check for Class
========================================================
class: medium-code


```r
x <- c(-1.2, 0, 1.1)
s <- c("1", "one", "T")
l <- c(TRUE, FALSE, T, F)
```


```r
is.character(x)
```

```
[1] FALSE
```

```r
is.character(s)
```

```
[1] TRUE
```

```r
is.logical(l)
```

```
[1] TRUE
```



More on Character Vectors 
========================================================
left: 35%
class: medium-code

<div style="color:#4488CC;font-size:250%;margin-top:+200px">
paste(...)
</div>

***


```r
paste("first", "second")
```

```
[1] "first second"
```

```r
paste("n", 1:5, sep = ":")
```

```
[1] "n:1" "n:2" "n:3" "n:4" "n:5"
```

```r
paste0("without", "space")
```

```
[1] "withoutspace"
```

```r
paste(1:10, collapse = "...")
```

```
[1] "1...2...3...4...5...6...7...8...9...10"
```


Exercise 1
========================================================
There are 20 patients with SUBJIDs `102, 104, ..., 140`. First 10 are treated in the site (SITEID) `"A"`, next 7 in cite `"B"`, and last 3 - in `"C"`. The STUDYID is "BO12345".

Create a vector of USUBJIDs in the format STUDYID-SITEID-SUBJID.

Hint: Look up for `seq` and `rep` functions.


Arithmetic
========================================================
left: 40%

<div style="color:#4488CC;font-size:400%;margin-top:+50px">
+&nbsp;&nbsp;&nbsp;   -
</div>

<div style="color:#4488CC;font-size:350%;margin-top:+150px">
*&nbsp;&nbsp;&nbsp; /&nbsp;&nbsp;&nbsp; ^
</div>

<div style="color:#4488CC;font-size:250%;margin-top:+150px">
%% &nbsp;&nbsp;&nbsp;%/%
</div>

***


```r
1:10+.1
```

```
 [1]  1.1  2.1  3.1  4.1  5.1  6.1  7.1  8.1  9.1 10.1
```


```r
((1:5)^2 + 1)^.5
```

```
[1] 1.414214 2.236068 3.162278 4.123106 5.099020
```


```r
21:34 %% 7
```

```
 [1] 0 1 2 3 4 5 6 0 1 2 3 4 5 6
```


More functions
========================================================
class:medium-code

```r
x <- 1:10
sin(x)^2 + cos(x)^2
```

```
 [1] 1 1 1 1 1 1 1 1 1 1
```


```r
y <- log((-1):5); y
```

```
[1]       NaN      -Inf 0.0000000 0.6931472 1.0986123 1.3862944 1.6094379
```


```r
is.nan(y)
```

```
[1]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
is.finite(y)
```

```
[1] FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
```



Numerical summaries
========================================================
left: 40%
class: medium-code

<div style="color:#4488CC;font-size:250%;margin-top:+100px">
length
</div>

<div style="color:#4488CC;font-size:250%;margin-top:+170px">
sum
</div>

<div style="color:#4488CC;font-size:250%;margin-top:+150px">
mean &nbsp;&nbsp; sd
</div>

***

```r
length(1:10)
```

```
[1] 10
```

```r
length(c("word 1", "word 2", "word 3"))
```

```
[1] 3
```

```r
sum(1:10)
```

```
[1] 55
```

```r
sum(c(TRUE, FALSE, TRUE, TRUE))
```

```
[1] 3
```

```r
sd(1:10)
```

```
[1] 3.02765
```

min/max
========================================================
left: 40%
class: medium-code
<div style="color:#4488CC;font-size:250%;margin-top:+50px">
min &nbsp;&nbsp; max
</div>



<div style="color:#4488CC;font-size:250%;margin-top:+150px">
which.min &nbsp;&nbsp;<br/><br/>
which.max
</div>

***


```r
x <- c(234, 6436, 547.6, 1000, 12, 3002)
max(x)
```

```
[1] 6436
```
<br/>


```r
which.min(x)
```

```
[1] 5
```



Exercise 2
========================================================
Patient's glucose test results (mmol/L):

`3.5, 3.8, 4.2, 8.0, 8.2, 5.1, 7.0, 3.0, 3.1, 10.0, 9.9, 8.0, 5.4, 3.1, 4.5, 5.4, 7.1, 7.2, 7.3, 7.4, 7.8, 7.91, 7.9, 6.2`

Convert to mg/dL (*2000/111) and find



1. **number** of observations
2. **max**/**min** concentrations
3. **mean** concentration
4. 95% CI for **mean**

Hint: CI = mean +- 1.96/sqrt(n)*sd



Logical Operators
========================================================
left: 40%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+50px">
==&nbsp;&nbsp; != &nbsp;&nbsp; !(...)
</div>

<div style="color:#4488CC;font-size:200%;margin-top:+150px">
>&nbsp;&nbsp < &nbsp;&nbsp; >= &nbsp;&nbsp; >=
</div>

<div style="color:#4488CC;font-size:250%;margin-top:+150px">
& &nbsp;&nbsp;&nbsp;&nbsp;|
</div>

***

```r
x <- 1:5
x == 3
```

```
[1] FALSE FALSE  TRUE FALSE FALSE
```

```r
!(x != 3)
```

```
[1] FALSE FALSE  TRUE FALSE FALSE
```

```r
x >= 4
```

```
[1] FALSE FALSE FALSE  TRUE  TRUE
```

```r
(x >= 4) | (x <= 1)
```

```
[1]  TRUE FALSE FALSE  TRUE  TRUE
```

Logical Summaries
========================================================
left: 40%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+50px">
any
</div>


<div style="color:#4488CC;font-size:250%;margin-top:+150px">
all
</div>

***


```r
x <- seq(from = 1, to = 11, by = 2)
x
```

```
[1]  1  3  5  7  9 11
```

```r
any(x %% 2 == 0)
```

```
[1] FALSE
```

```r
any(x > 7)
```

```
[1] TRUE
```

```r
all(x %% 2 == 1)
```

```
[1] TRUE
```


Exercise 3
========================================================
Patient's glucose test results (mmol/L):

`3.5, 3.8, 4.2, 8.0, 8.2, 5.1, 7.0, 3.0, 3.1, 10.0, 9.9, 8.0, 5.4, 3.1, 4.5, 5.4, 7.1, 7.2, 7.3, 7.4, 7.8, 7.91, 7.9, 6.2`

Lower and upper normal limits are `3.9` and `7.8`.

Find:

1. indices of observations which don't fall into normal ranges

Hint: use **which** function 

2. How many and what proportion of observations doesn't fall into normal ranges?

Hint: Use **sum** and **mean** for logical vectors.




Vector Subsetting
========================================================
class: medium-code

* by indices

```r
x <- 10:1
x[1:3]
```

```
[1] 10  9  8
```

```r
x[c(2, 5)]
```

```
[1] 9 6
```

* by logical vector

```r
x[x <= 3]
```

```
[1] 3 2 1
```


Names and subsetting by Names
========================================================
class: medium-code
left: 55%

* Name inside <font style="color:#4488CC;font-weight:bold">c</font>

```r
heights <- c(dad = 187, mom = 167, me = 182, brother = 189)
```

* Or use <font style="color:#4488CC;font-weight:bold">names</font> function

```r
heights <- c(187, 167, 182, 189)
names(heights) <- c("dad", "mom", "me", "brother")
```


```r
heights
```

```
    dad     mom      me brother 
    187     167     182     189 
```

```r
names(heights)
```

```
[1] "dad"     "mom"     "me"      "brother"
```

***
<h3>Subsetting</h3>


```r
heights[c("mom", "dad")]
```

```
mom dad 
167 187 
```


Exercise 4
========================================================
[Project Euler Problem #1](https://projecteuler.net/problem=1)

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

Hint: `x` is divisible by `y` if `(x %% y) == 0`


Assign to subsets
========================================================

```r
x <- c("Nausea", "Konstipation", "Fever")
x[x == "Konstipation"] <- "Constipation"
x
```

```
[1] "Nausea"       "Constipation" "Fever"       
```


<h3>Exercise 5</h3>
Test results: `9, 8, 5, NA, 3, 4, NA, 9, 1, NA`.

Calculate mean counting `NA`s as `1`s

Hint: You need `is.na` function.


