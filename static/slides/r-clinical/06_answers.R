## 1 ==============================================================
### 1.1
library(ggplot2)
library(dplyr)
library(haven)

adsl <- haven::read_sas("data/adsl.sas7bdat")

f <- function(adsl, title) {
    ggplot(adsl, aes(BHEIGHT, BWEIGHT, color = ARM)) +
        geom_point() +
        geom_smooth() +
        ggtitle(title)
}
f(adsl, "Baseline Weight to Height Correlation")


### 1.2
f <- function(adsl, title, split = FALSE) {
    p <- ggplot(adsl, aes(BHEIGHT, BWEIGHT, color = ARM)) +
        geom_point() +
        geom_smooth() +
        ggtitle(title)
    if(split) p <- p + facet_wrap(~SEX)
    p
}
f(adsl, "Baseline Weight to Height Correlation")
f(adsl, "Baseline Weight to Height Correlation", split = TRUE)

## 2 ==============================================================
library(glue)
avs <- read_sas("data/avs.sas7bdat")


g_avs_subj <- function(avs, subj) {
    avs %>% 
        filter(USUBJID == subj, PARAMCD != "HEIGHT") %>%
        ggplot(aes(x = ADY, y = AVAL)) +
        geom_point() + geom_line() +
        facet_wrap(~PARAM, scales = "free_y") +
        ggtitle(glue::glue("{subj} Vital Signs"))
}

for (uid in unique(avs$USUBJID)) {
    ggsave(
        filename = glue("outputs/g_avs_subj_{uid}.pdf"),
        plot     = g_avs_subj(avs, uid)
    )
}


## 3
select(ana$adae, matches("DTM$")) %>%
    map_dbl(max, na.rm = TRUE) %>%
    max(na.rm = TRUE) %>% 
    lubridate::as_datetime()


adae4 <- filter(ana$adae, AETOXGR == 4)
ana4 <- map(ana, ~semi_join(., adae4, by = "USUBJID"))


# apply functions family: mapply
# ========================================================
#     class: medium-code
# 
# multivariate version of `sapply`
# 
# ```{r}
# mapply(rep, 1:3, 3:1)
# ```
# 
# type-unstable
# ```{r}
# mapply(rep, 1:3, 2)
```

