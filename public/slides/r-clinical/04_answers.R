library(haven)

# 1
adsl <- read_sas("data/adsl.sas7bdat")
adsl[adsl$AGE > 75, c("SUBJID", "SEX", "AGE", "BWEIGHT", "BHEIGHT")]


#
adae <- read_sas("data/adae.sas7bdat")
adae %>% 
    filter(AEDECOD == "Thrombocytopenia") %>% 
    group_by(USUBJID, AEDECOD) %>% 
    summarise(max_AETOXGR = max(AETOXGR))

adae %>% 
    #filter(AEDECOD == "Thrombocytopenia") %>% 
    group_by(USUBJID, AEDECOD) %>% 
    summarise(max_AETOXGR = max(AETOXGR))

adae %>% 
    group_by(USUBJID, AEDECOD) %>%
    summarise(max_AETOXGR = max(AETOXGR),
              min_AETOXGR = min(AETOXGR)) %>% 
    mutate(range_AETOXGR = paste(max_AETOXGR, min_AETOXGR, sep = "-"))
