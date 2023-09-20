# source("10-run.R")

rm(list= ls())
bnm   <- "10-fcmp_source"
nmRmd <- paste0(bnm, ".Rmd")
nmR   <- paste0(bnm,".Rprog")
rmarkdown::render(nmRmd, "all")
