# 1
#==============================================

dates <- c("2001-09-02", "2012-03", "2017", "2005-05-05", "2013", 
           "2012-12-29", "2011-11", "2007", "2010-04-16")

# 4
l4 <- nchar(dates) == 4
dates[l4] <- paste0(dates[l4], "-01-01")

# 7
l7 <- nchar(dates) == 7
dates[l7] <- paste0(dates[l7], "-01")

# read
dts <- parse_date(dates, "%Y-%m-%d")

# min/max
min(dts)
max(dts)
sort(dts)
Sys.Date() - dts + 1


# 2
#==============================================
dt_chr <- c("2015-02-13T00:51:00", "2015-02-14T23:58:00", "2015-02-16T22:59:00")
dt <- ymd_hms(dt_chr)
dt <- parse_datetime(dt_chr, "%Y-%m-%dT%H:%M:%S")
dt_end <- dt + dhours(1)
dt_end
