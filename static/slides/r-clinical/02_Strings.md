Strings in R
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

.red { background-color: red; }
div.blue pre { background-color:lightblue; }
div.blue pre.r { background-color:blue; }

.exampleone pre code {
  background-color: teal;
  color: white;
}
</style>




Rewind
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



More functions
========================================================
left: 35%
class: medium-code


<div style="color:#4488CC;font-size:200%;margin-top:+60px">
nchar
</div>

<div style="color:#4488CC;font-size:200%;margin-top:+120px">
strsplit
</div>

***


```r
dates <- c("2017-05-09", "2017-05", "2017")
```


```r
nchar(dates)
```

```
[1] 10  7  4
```

```r
strsplit(dates, "-")
```

```
[[1]]
[1] "2017" "05"   "09"  

[[2]]
[1] "2017" "05"  

[[3]]
[1] "2017"
```

Exercises
========================================================

<h3> Exercise 1 </h3>

```r
dates <- c("2017-05-09", "2017-05", "2017", "2011-11-11", "2013-03", "2014-11-12", "2005")
```
Extract all the incomplete dates.

<h3> Exercise 2 </h3>
Given two RNA strings:

```r
s <- c("GATGGAACTTGACTACGTAAATT", "GAUGGAACUUGACUACGUAAAUU")
```
Calculate the number of positions where these two strings differ.

Hints: 
* Use `strsplit` with empty string as a delimeter. 
* You can access elements of a list as `x[[1]], x[[2]], ...`

stringr package
========================================================
Manipulations with strings

```r
install.packages("stringr")
library(stringr)
```



Link: [Introduction](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)


Getting and setting individual characters
========================================================
left: 35%

<div style="color:#4488CC;font-size:200%;margin-top:+200px">
str_sub
</div>
<br/><br/>

***


```r
mdr <- c("MedDRA 20.1", "MedDRA 36.6")
str_sub(mdr, 8, -1)
```

```
[1] "20.1" "36.6"
```

```r
str_sub(mdr, 8, -1) <- "18.1"
mdr
```

```
[1] "MedDRA 18.1" "MedDRA 18.1"
```


Whitespace
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+150px">
str_pad
<br/><br/>
str_trim
</div>
<br/><br/>

***

```r
str_pad(1:10, 2, pad = "0")
```

```
 [1] "01" "02" "03" "04" "05" "06" "07" "08" "09" "10"
```

```r
paste0(str_pad(c("first", "second"), 8, side = "right"), ":")
```

```
[1] "first   :" "second  :"
```

```r
str_trim("  String with trailing and leading white space\t")
```

```
[1] "String with trailing and leading white space"
```

Letter Cases
========================================================
left: 30%
class: medium-code

<div style="color:#4488CC;font-size:200%;margin-top:+150px">
str_to_lower
<br/><br/>
str_to_upper
<br/><br/>
str_to_title
</div>
<br/><br/>

***


```r
aes <- c("lung inflammation", "DYSPNEA")
str_to_lower(aes)
```

```
[1] "lung inflammation" "dyspnea"          
```

```r
str_to_upper(aes)
```

```
[1] "LUNG INFLAMMATION" "DYSPNEA"          
```

```r
str_to_title(aes)
```

```
[1] "Lung Inflammation" "Dyspnea"          
```


Regular Expressions
========================================================


**regular expression** - a special text string for describing a search pattern 

Use `str_view_all` function to test patterns


```r
str_view_all(c("banana", "apple", "mandarine"), "an")
```
<pre><code> b<font color='red'>an</font><font color='red'>an</font>a apple m<font color='red'>an</font>darine </pre></code>

Basic Matches
========================================================

<font style="color:#4488CC;font-size:200%;margin-top:+150px">.</font> - any character


```r
str_view_all(c("banana", "apple", "mandarine"), ".a.")
```
<pre><code> <font color='red'>ban</font>ana apple <font color='red'>man</font><font color='red'>dar</font>ine </pre></code>

<font style="color:#4488CC;font-size:150%;margin-top:+150px">\\\\\\\\.</font> - to match the dot itself

```r
str_view_all(c("Aladinostat 80.8mg", "Aladinostat 90mg"), "\\.")
```
<pre><code> Aladinostat 80<font color='red'>.</font>8mg &nbsp;&nbsp; Aladinostat 90mg </pre></code>


Anchors
========================================================
class: medium-code

<font style="color:#4488CC;font-size:150%;margin-top:+150px">\^</font> - start of the string;&nbsp;&nbsp;
<font style="color:#4488CC;font-size:150%;margin-top:+150px">\$</font> - end of the string;


```r
str_view_all(c("Aladinostat 80.8mg", "90mg Aladinostat"), pattern = "mg$")
```
<pre><code> Aladinostat 80.8<font color='red'>mg</font>&nbsp;&nbsp; 90mg Aladinostat </pre></code>


```r
str_view_all(c("ABC-001", "DEF-002"), pattern = "^...")
```
<pre><code> <font color='red'>ABC</font>-001 <font color='red'>DEF</font>-002 </pre></code>


<font style="color:#4488CC;font-size:150%;margin-top:+150px">\\\\\\\\b</font> - word boundary

```r
str_view_all(c("Aladinostat 80.8mg", "Aladinostat 90mg"), ".\\b")
```
<pre><code> Aladinosta<font color='red'>t</font><font color='red'> </font>8<font color='red'>0</font><font color='red'>.</font>8m<font color='red'>g</font> &nbsp;&nbsp;Aladinosta<font color='red'>t</font><font color='red'> </font>90m<font color='red'>g</font> </pre></code>


Character classes and alternatives
========================================================
left: 30%
class: medium-code

<font style="color:#4488CC;font-size:150%;margin-top:+150px">[0-9]</font>&nbsp;&nbsp;- digits


<font style="color:#4488CC;font-size:150%;margin-top:+150px">[A-Za-z]</font>&nbsp;&nbsp;- letters

<font style="color:#4488CC;font-size:150%;margin-top:+150px">[abc]</font>&nbsp;&nbsp;- a, b or c

<font style="color:#4488CC;font-size:150%;margin-top:+150px">[!abc]</font>&nbsp;&nbsp;- not a, b or c

<font style="color:#4488CC;font-size:150%;margin-top:+150px">abc|xyz</font>&nbsp;&nbsp;- abc or xyz

***

```r
str_view_all(c("Drug 80.8mg", "90mg of a drug"), "[0-9]")
```
<pre><code> Aladinostat <font color='red'>8</font><font color='red'>0</font>.<font color='red'>8</font>mg <font color='red'>9</font><font color='red'>0</font>mg Aladinostat </pre></code>


```r
str_view_all(c("ABCDEF", "abcdef"), "[c-e]")
```
<pre><code> ABCDEF ab<font color='red'>c</font><font color='red'>d</font><font color='red'>e</font>f </pre></code>



```r
str_view_all(c("gray", "grey", "green"), "gr(a|e)y")
```
<pre><code> <font color='red'>gray</font> <font color='red'>grey</font> green </pre></code>


Repetition
========================================================
left: 30%
class: medium-code

<font style="color:#4488CC;font-size:150%;margin-top:+150px">?</font>&nbsp;&nbsp;- 0 or 1

<font style="color:#4488CC;font-size:150%;margin-top:+150px">+</font>&nbsp;&nbsp;- 1 or more

<font style="color:#4488CC;font-size:150%;margin-top:+150px">*</font>&nbsp;&nbsp;- 0 or more

<font style="color:#4488CC;font-size:150%;margin-top:+150px">{n}</font>&nbsp;&nbsp;- n times

<font style="color:#4488CC;font-size:150%;margin-top:+150px">{n, }</font>&nbsp;&nbsp;- n or more

<font style="color:#4488CC;font-size:150%;margin-top:+150px">{n, m}</font>&nbsp;&nbsp;- from n to m


***


```r
str_view_all(c("Drug 80.1mg", "Drug 80mg", "Drug 80"), "[0-9]+mg")
```
<pre><code> Drug 80.<font color='red'>1mg</font> &nbsp;&nbsp;Drug <font color='red'>80mg</font> &nbsp;&nbsp;Drug 80</pre></code>


```r
str_view_all(c("Drug 80.1mg", "Drug 80mg", "Drug 80"), "[0-9]+(\\.[0-9]+)?(mg)?")
```
<pre><code> Drug <font color='red'>80.1mg</font> &nbsp;&nbsp;Other Drug <font color='red'>14ml</font> </pre></code>


```r
str_view_all(c("Drug 80.1mg", "Other Drug 14ml"), "[0-9]+(\\.[0-9]+)?[a-z]*")
```
<pre><code> Drug <font color='red'>80.1mg</font>&nbsp;&nbsp; Other Drug <font color='red'>14ml</font> </pre></code>


```r
str_view_all(c("Drug 80.1mg", "Drug 100mg"), "[0-9]{3,}")
```
<pre><code> Drug 80.1mg &nbsp;&nbsp;Drug <font color='red'>100</font>mg </pre></code>


Detect, Extract, Subset, Replace
========================================================
left: 30%
class: medium-code

<font style="color:#4488CC;font-size:150%;margin-top:+300px">str_detect</font>

<font style="color:#4488CC;font-size:150%;margin-top:+300px">str_extract</font>

<font style="color:#4488CC;font-size:150%;margin-top:+300px">str_subset</font>

<font style="color:#4488CC;font-size:150%;margin-top:+300px">str_replace</font>

***


```r
s <- c("Drug 80.1mg", "Drug 80mg", "Drug   80")
pattern <- "[0-9]+(\\.[0-9]+)?mg"
```

```r
str_detect(s, pattern)
```

```
[1]  TRUE  TRUE FALSE
```

```r
str_extract(s, pattern)
```

```
[1] "80.1mg" "80mg"   NA      
```

```r
str_subset(s, pattern)
```

```
[1] "Drug 80.1mg" "Drug 80mg"  
```

```r
str_replace(s, "[ ]+", " ")
```

```
[1] "Drug 80.1mg" "Drug 80mg"   "Drug 80"    
```


You can use pipes!
========================================================
left: 25%
class: medium-code

<div style="color:#4488CC;font-size:300%;margin-top:+200px">
%>% 
</div>


<div style="color:#7e7e7e;font-size:80%;margin-top:+100px">
Shortcut: Ctrl+Shift+M
</div>

***



```r
x <- c("Drug   34.5 MG  ", "  aspirin  48.8mg")
x %>% 
    str_trim() %>% 
    str_replace("[ ]+", " ") %>% 
    str_replace(regex("[ ]+mg", ignore_case = TRUE), "mg") %>% 
    str_to_title()
```

```
[1] "Drug 34.5Mg"    "Aspirin 48.8Mg"
```


<div style="margin-top:+100px">
Exercise
</div>

<div style="font-size:76%">
Explain what happens at each step. Change the code so that the dose would be displayed as "mg", not "Mg".
<div/>

Exercise
========================================================

```r
dates <- c("28th of June, 2008", "1st January - 1993", "2011, April, 19")
```
Extract: 
* days
* month names
* years

Hint: Try `\\b`. You may also want to combine multiple `str_extract`s.

glue package
========================================================
class: medium-code

Preserves line breaks

```r
glue("Some text
     Some more text on the new line")
```

```
Some text
Some more text on the new line
```

But you can turn it off

```r
glue("Long description of an adverse event \\
      that you don`t want to keep in one line \\
      of code")
```

```
Long description of an adverse event that you don`t want to keep in one line of code
```




glue package
========================================================
class: medium-code


```r
install.packages("glue")
library(glue)
```


```r
snapshot <- "a12345b"
program <- "g_scat"
filter <- "SE"
glue("Snapshot: {snapshot}, file: {program}_{filter}.pdf, {Sys.time()}")
```

```
Snapshot: a12345b, file: g_scat_SE.pdf, 2018-03-01 18:16:03
```

### Exercise 1
There are 20 patients with SUBJIDs `102, 104, ..., 140`.
First 10 are treated in the site (SITEID) `"A"`, next 7 in cite `"B"`, and last 3 - in `"C"`. The STUDYID is "BO12345".

Create a vector of USUBJIDs in the format STUDYID-SITEID-SUBJID.



