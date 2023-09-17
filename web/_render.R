# source("_render.R")

# https://github.com/rstudio/rmarkdown-website-examples
unlink("_site",recursive=TRUE)

rm(list= ls())
T1 <- ""
rmarkdown::render_site()

# track <- list(TrADL =

