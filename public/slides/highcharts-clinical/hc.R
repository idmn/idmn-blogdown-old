# SPIDER ==================================================

hc_spi <- function(data, colorby = "BOR", show_subjids = FALSE) {
    bor_cols <- tribble(
        ~COLOR_GROUP, ~color,
        "CR", "#00aedb",    "PR", "#00b159",
        "SD", "#ffc425",    "PD", "#d11141",
        "NE", "#545454"
    )
    
    ada_cols <- tribble(
        ~COLOR_GROUP,   ~color,
        "ADA-negative", "#00a0b0",
        "ADA-positive", "#de425b"
    )
    
    cea_cols <- tribble(
        ~COLOR_GROUP, ~color,
        "Low",       "#00a0b0",
        "High",      "#de425b",
        "NA",        "#767676"
    )
    
    if (colorby == "BOR") {
        df <- data %>%
            mutate(COLOR_GROUP = BOR, name = as.character(BOR)) %>%
            left_join(bor_cols, by = "COLOR_GROUP")
        legend_title <- "BOR"
    }
    if (colorby == "ADASTAT") {
        df <- data %>%
            mutate(COLOR_GROUP = ADASTAT, name = ADASTAT) %>%
            left_join(ada_cols, by = "COLOR_GROUP")
        legend_title <- "ADA Status"
    }
    if (colorby == "CEACAM5L") {
        df <- data %>%
            mutate(COLOR_GROUP = CEACAM5L, name = CEACAM5L) %>%
            left_join(cea_cols, by = "COLOR_GROUP")
        legend_title <- "CEACAM5 <br/>(ref = 1000 RPKM)"
    }
    
    # colorby = "ADASTAT"
    series_df <- df %>%
        filter(CLASS == "SUMTGLES") %>%
        select(USUBJID, COLOR_GROUP, x = WEEK, y = PCHG, SUBJN, name, color) %>%
        # last point for each subject
        group_by(USUBJID) %>%
        mutate(dataLabels = map(row_number(), ~list(
            enabled = (. == n()) & show_subjids,
            format = "{point.SUBJN}",
            verticalAlign = "middle",
            align = "left",
            style = list(fontSize = "9px")))) %>%
        ungroup() %>%
        tidyr::nest(x, y, SUBJN, dataLabels) %>%
        # link between BOR
        arrange(COLOR_GROUP, USUBJID) %>%
        # (!) NOT BOR
        group_by(COLOR_GROUP) %>%
        mutate(linkedTo = ifelse(row_number() == 1, "", ":previous")) %>%
        mutate(showInLegend = ifelse(row_number() == 1, TRUE, FALSE))
    
    series_list <- series_df %>%
        mutate(data = map(data, transpose)) %>%
        transpose()
    
    highchart() %>%
        hc_exporting(enabled = TRUE) %>%
        hc_chart(zoomType = "xy") %>%
        hc_plotOptions(
            line = list(
                marker = list(symbol = "circle", radius = 3),
                dataLabels = list(allowOverlap = TRUE)
            )
        ) %>%
        hc_yAxis(
            title = list(text = "Change in target lesions from baseline [%]"),
            plotBands = list(color = '#e5e5e5', from = -30, to = 20),
            # (!) this meesses up zoom on y
            #tickPositions = c(-100, -50, -30, 0, 20, 50, 100, 150),
            #tickPosition = "outside",
            lineWidth = 1,
            tickWidth = 1,
            gridLineColor = "white") %>%
        hc_xAxis(
            title = list(text = "Week completed after treatment start")
        ) %>%
        hc_tooltip(formatter = JS("function(){
                                  return ('<b>' + this.point.SUBJN + '<b/>' + '<br> Change: ' + (+this.y.toFixed(1)) + ' % <br>' +
                                  ' Day: ' + Math.round(7*this.x))}")
        ) %>%
        hc_legend(title = list(text = legend_title), layout = "vertical", align = "right", verticalAlign = "top", y = 50) %>%
        hc_add_series_list(series_list)
}





# WATERFALL ===============================================

hc_wat <- function(data) {
    bor_cols <- tribble(
        ~BOR, ~color,
        "CR", "#00aedb",    "PR", "#00b159",
        "SD", "#ffc425",    "PD", "#d11141",
        "NE", "#545454"
    )
    
    legend_text <- bor_cols %>% 
        semi_join(data %>% select(BOR) %>% unique, by = "BOR") %>% 
        glue_data("<span style='color: {color}'> &#x25BA; </span>{BOR}") %>% 
        glue_collapse("        ") %>% 
        str_c("BOR: ", .)
    
    
    wf_df <- data %>%
        filter(CLASS == "SUMTGLES", WEEK >= 0, !is.na(PCHG)) %>%
        select(SUBJN, BOR, x = WEEK, y = PCHG) %>% 
        nest(-SUBJN, -BOR)%>% 
        mutate(PCHG = map_dbl(data, . %>%
                                  filter(x > 0) %>%
                                  pull(y) %>% 
                                  min)) %>% 
        arrange(-PCHG) %>%
        mutate(SUBJN = fct_inorder(SUBJN)) %>% 
        mutate(ttdata = map(data, list_parse)) %>% 
        left_join(bor_cols, by = "BOR")
    
    hchart(wf_df, "column", hcaes(SUBJN, PCHG, color = color)) %>%
        hc_yAxis(
            title = list(text = "Change in target lesions from baseline [%]"),
            plotBands = list(color = '#e5e5e5', from = -30, to = 20)
        ) %>% 
        hc_xAxis(title = list(text = "Subject")) %>% 
        hc_subtitle(text = legend_text,
                    floating = TRUE, align = "right", y = 30,
                    style = list(`font-size` = "130%", fontWeight = "bold")) %>% 
        hc_tooltip(
            useHTML = TRUE,
            pointFormatter = tooltip_chart(
                accesor = "ttdata",
                hc_opts = list(
                    chart = list(type = "line"),
                    title = list(text = "point.name"),
                    subtitle = list(text = "Change from BL (%)"),
                    plotOptions = list(series = list(animation = 2000, name = "point.name"))
                )
            )
        )
}
