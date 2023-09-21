# source("01-create-FCMP-prj_render.R")

rm(list= ls())
bnm   <- "01-create-FCMP-prj"
nmRmd <- paste0(bnm, ".Rmd")
nmR   <- paste0(bnm,".Rprog")
rmarkdown::render(nmRmd, "all")
