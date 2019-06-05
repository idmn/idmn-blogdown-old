Matrices
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

Create
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:140%;margin-top:+45px">
matrix(data, ...)
</div>

<div style="color:#4488CC;font-size:140%;margin-top:+130px">
nrow &nbsp;&nbsp;&nbsp;&nbsp; ncol
</div>

<div style="color:#4488CC;font-size:140%;margin-top:+130px">
dim
</div>
***

```r
m <- matrix(1:6, nrow = 2); m
```

```
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

```r
c(nrow = nrow(m), ncol = ncol(m))
```

```
nrow ncol 
   2    3 
```

```r
dim(m)
```

```
[1] 2 3
```

```r
matrix(letters[1:6], ncol = 3, byrow = TRUE)
```

```
     [,1] [,2] [,3]
[1,] "a"  "b"  "c" 
[2,] "d"  "e"  "f" 
```

as, is
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:160%;margin-top:+130px">
as.matrix <br/><br/>
is.matrix
</div>

***


```r
m <- as.matrix(1:3); m
```

```
     [,1]
[1,]    1
[2,]    2
[3,]    3
```

```r
class(m)
```

```
[1] "matrix"
```

```r
is.matrix(m)
```

```
[1] TRUE
```

```r
as.numeric(m)
```

```
[1] 1 2 3
```


Bind
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:160%;margin-top:+130px">
rbind <br/><br/>
cbind
</div>

***


```r
m <- matrix(1:4, nrow = 2)
```



```r
cbind(m, m)
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    3    1    3
[2,]    2    4    2    4
```

```r
rbind(1:3, 3:1)
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    3    2    1
```


```r
cbind(m, 13)
```

```
     [,1] [,2] [,3]
[1,]    1    3   13
[2,]    2    4   13
```

Subset
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:200%;margin-top:+130px">
[&nbsp;&nbsp;, &nbsp;&nbsp;]
</div>


***


```r
m <- matrix(1:6, nrow = 2); m
```

```
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

```r
m[1,]
```

```
[1] 1 3 5
```

```r
m[1, 3]
```

```
[1] 5
```

```r
m[, c(F, T, T)]
```

```
     [,1] [,2]
[1,]    3    5
[2,]    4    6
```


Dimnames and Subset by Dimnames
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:160%;margin-top:+130px">
rownames <br/><br/>
colnames <br/><br/>
dimnames  <br/><br/>
</div>

***

```r
rownames(m) <- c("SUBJ1", "SUBJ2")
colnames(m) <- c("DAY1", "DAY2", "DAY3")
m
```

```
      DAY1 DAY2 DAY3
SUBJ1    1    3    5
SUBJ2    2    4    6
```

```r
dimnames(m)
```

```
[[1]]
[1] "SUBJ1" "SUBJ2"

[[2]]
[1] "DAY1" "DAY2" "DAY3"
```

```r
m["SUBJ1", c("DAY1", "DAY3")]
```

```
DAY1 DAY3 
   1    5 
```

Assign to Subset
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:200%;margin-top:+130px">
[&nbsp;&nbsp;, &nbsp;&nbsp;]&nbsp;&nbsp; <-
</div>

***

```r
m[m <= 3] <- 0; m
```

```
      DAY1 DAY2 DAY3
SUBJ1    0    0    5
SUBJ2    0    4    6
```

```r
m[, "DAY1"] <- m[, "DAY2"] + m[, "DAY3"]; m
```

```
      DAY1 DAY2 DAY3
SUBJ1    5    0    5
SUBJ2   10    4    6
```

```r
m[1, 2] <- 99; m
```

```
      DAY1 DAY2 DAY3
SUBJ1    5   99    5
SUBJ2   10    4    6
```


Arithmetics
========================================================
class: medium-code


```r
m <- matrix(1:4, 2); m
```

```
     [,1] [,2]
[1,]    1    3
[2,]    2    4
```

```r
m - 1
```

```
     [,1] [,2]
[1,]    0    2
[2,]    1    3
```

```r
m + c(1, 100)
```

```
     [,1] [,2]
[1,]    2    4
[2,]  102  104
```


***

```r
log(m)
```

```
          [,1]     [,2]
[1,] 0.0000000 1.098612
[2,] 0.6931472 1.386294
```


```r
m * m # (!) element-wise
```

```
     [,1] [,2]
[1,]    1    9
[2,]    4   16
```

Inverse Matrix and Matrix Multiplication
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:180%;margin-top:+130px">
solve <br/><br/><br/>
%*% 
</div>

***


```r
m_inv <- solve(m); m_inv
```

```
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
```

```r
m %*% m_inv
```

```
     [,1] [,2]
[1,]    1    0
[2,]    0    1
```

```r
s <- solve(m, c(1, 100)); s
```

```
[1] 148 -49
```

```r
m %*% s
```

```
     [,1]
[1,]    1
[2,]  100
```

Transpose
========================================================
class: medium-code
left: 35%

<div style="color:#4488CC;font-size:300%;margin-top:+130px">
t
</div>

***

```r
m <- matrix(1:6, nrow = 2); m
```

```
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

```r
t(m)
```

```
     [,1] [,2]
[1,]    1    2
[2,]    3    4
[3,]    5    6
```

```r
t(1:3)
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
```

