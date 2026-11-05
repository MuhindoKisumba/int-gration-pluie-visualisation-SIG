############################################################
# CORRELATION EPIDEMIE vs CLIMAT
############################################################

library(DBI)
library(RPostgres)

con <- dbConnect(RPostgres::Postgres(),
                 dbname="epidemiologie",
                 host="postgres",
                 user="postgres",
                 password="password")

data <- dbGetQuery(con, "
SELECT e.cas, c.temperature, c.precipitation
FROM cas_epidemio e
JOIN climat c
ON DATE(e.date) = DATE(c.date)
")

cor(data$cas, data$temperature, use="complete.obs")
cor(data$cas, data$precipitation, use="complete.obs")
