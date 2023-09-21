# source("05-use-FCMP-prj_render.R")

rm(list= ls())
bnm   <- "05-use-FCMP-prj_render"
nmRmd <- paste0(bnm, ".Rmd")
nmR   <- paste0(bnm,".Rprog")
rmarkdown::render(nmRmd, "all")
