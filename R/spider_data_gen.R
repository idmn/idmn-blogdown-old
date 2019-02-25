library(dplyr)
library(purrr)
library(ggplot2)
library(readr)

sumtgles_rw <- function() {
    # number of visits
    nvis <- sample(2:15, size = 1)
    # planned weeks of visit
    vis_wks <- seq(from = 0, to = 4*nvis, by = 4)
    # add random noise
    x <- vis_wks + c(0, rnorm(nvis, sd = 1))
    
    y <- c(0, rnorm(nvis, sd = seq(from = 15, to = 5, length = nvis))) %>% 
        cumsum() %>% 
        pmax(-100) %>% 
        smooth("3")
    
    y[[1]] <- 0

    res <- tibble(x, y)
    
    # cut after first 30 if there was such
    which_high <- which(y >= 30)
    if (length(which_high) > 0) {
        res <- res[1:which_high[[1]], ]
        res$BOR <- "PD"
    } else {
        if (mean(res$y) <= -20 & last(res$y) <= -20) res$BOR <- "PR"
        else res$BOR <- "SD"
    }
    
    res
}


N <- 200

df_BIG <- replicate(N, sumtgles_rw(), simplify = FALSE) %>% 
    set_names(., seq_along(.)) %>% 
    imap(~ .x %>% mutate(SUBJ = .y)) %>% 
    reduce(bind_rows) %>% 
    mutate(SUBJ = paste0("S-", SUBJ))

sl <- df_BIG %>% 
    select(SUBJ, BOR) %>% 
    unique()

count(sl, BOR)

sel_subj <- bind_rows(
    sl %>% filter(BOR == "PD") %>% sample_n(3),
    sl %>% filter(BOR == "SD") %>% sample_n(4),
    sl %>% filter(BOR == "PR") %>% sample_n(3)
) 

df <- df_BIG %>% 
    semi_join(sel_subj, by = "SUBJ")

ggplot(df, aes(x, y, group = SUBJ, color = BOR)) +
    geom_point(size = 1.1) +
    geom_line(alpha = .7, size = 1) +
    scale_color_manual(
        "Confirmed BOR\n(Per Protocol)",
        values = c("CR" = "#00aedb", "PR" = "#00b159",
                   "SD" = "#ffc425", "PD" = "#d11141",
                   "NE" = "#545454"),
        guide  = guide_legend(order = 1)
    ) +
    theme_light() +
    geom_hline(yintercept = 0, color = "gray75") +
    labs(y = "Change in target lesions from baseline [%]",
         x = "Week completed after treatment start") +
    theme(panel.grid = element_blank()) +
    NULL

write_csv(df, "data/sumldiam.csv")
write_csv(df, "content/blog/2019/data/sumldiam.csv")
