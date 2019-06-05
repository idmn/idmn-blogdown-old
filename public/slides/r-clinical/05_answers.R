library(haven)
library(dplyr)
library(ggplot2)
setwd("Projects/Presentations/Intego/")
adsl <- read_sas("data/adsl.sas7bdat")
adae <- read_sas("data/adae.sas7bdat")
adae1 <- read_sas("data/adae.sas7bdat") %>% 
    group_by(AEBODSYS) %>% 
    filter(n() >= 20) %>% 
    ungroup


# 1
ggplot(adsl, aes(TRTSDT, ARM, color = ARM, shape = SEX)) +
    geom_point(size = 5)
set.seed(123)
ggplot(adsl, aes(TRTSDT, ARM, color = ARM, shape = SEX)) +
    geom_jitter(size = 5, width = 0.4)

# 2
adae1 <- read_sas("data/adae.sas7bdat") %>% 
    group_by(AEBODSYS) %>% 
    filter(n() >= 20)


ggplot(adae1, aes(AEBODSYS)) +
    geom_bar()

ggplot(adae1, aes(AEBODSYS)) +
    geom_bar() +
    coord_flip()

ggplot(adae1, aes(AEBODSYS, fill = ARM)) +
    geom_bar(position = "dodge") +
    coord_flip() 
    


# 3
library(forcats)
adae1 %>% 
    ggplot(aes(fct_rev(AEBODSYS), fill = ARM)) +
    geom_bar(position = "dodge") +
    coord_flip() 

adae1 %>% 
    ggplot(aes(fct_infreq(AEBODSYS) %>% fct_rev, fill = ARM)) +
    geom_bar(position = "dodge") +
    coord_flip() 


# 4
p <- ggplot(adae1, aes(ARM, AESTDY, fill = ARM)) +
    geom_boxplot() +
    facet_wrap(~AEBODSYS)
    facet_grid(.~AEBODSYS)

