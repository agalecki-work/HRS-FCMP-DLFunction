/*RMD*   Label: 1
---
title: "FCMP functions/subroutines in 'aux' group"
output:
  rmdformats::readthedown:
     lightbox: true
     use_bookdown: true
---

```{r setup, echo =FALSE}
 sasprog_nm <- "_auxiliary"   # Matches this SAS prog name
 vgr_nm <- "aux"
 library(rmdformats)
 # https://www.r-bloggers.com/2019/09/create-rmarkdown-document-with-sas-code-and-output-sas-engine/
 saspath <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
```

#  "{r vgrp_nm}" FCMP group {#aux-anchor};

This section includes information on FCMP functions/subroutines from "aux" group
*RMD*/  * RMD Label 1 ENDS;


/*RMD*  Label 10

```{r , echo=FALSE}
fun_nm <- "FQ_fun"
```

##  Function `FQ_fun` {#aux-FQ_fun-anchor};

<!---  FQ_fun function description --->
`FQ_fun` is an auxiliary function in "aux" FCMP group.

 _Purpose:_ Recoding variable  

 _Arguments:_  

* `studyr`: Redundant argument 
* `var_old`: Variable to be recoded

_Syntax:_ 

```{r, eval=FALSE}
  new_var = FQ_fun(1992, var_old);
```

*RMD*/  * RMD label 10 ENDS;

/* FQ_fun source starts here */

*START* {r FQ_fun-src, eval = FALSE}; 
function FQ_fun(studyyr, var_old) group ="aux"; 

/* Auxiliary function */
  var_new = var_old;

  select (var_old);
    when (1) var_new = 1;       
    when (5) var_new = 0;
    when (97) var_new =.O; 
    when (.,-8) var_new =.M;      
    when (8,98) var_new =.D;    
    when (9,99) var_new =.R;    
    otherwise;
  end;
  return(var_new);
 endsub; /* end function FQ_fun */
*END*;


** _Example_;

/*RMD* {r FQ_fun-example, eval=FALSE};
* Remember do not close comment '/*' inside this block;
data dt;
 x=33;
run;
proc print data=dt;
run;
*RMD*/;


/*RMD* Label 25
Output: `FQ_fun` function (aux group);

```{sas, ref.label = "FQ_fun-example", echo= FALSE, eval = TRUE, engine.path = saspath};
```;
*RMD*/  * Label 25 ENDS;


/*RMD*  Label 30 `studyyr_ok` function description starts here

```{r , echo=FALSE}
fun_nm <- "studyyr_ok"
```


*RMD*/ * NOTE: ---> `studyyr_ok` function description ends here;

 
 function studyyr_ok(yr) group ="aux";
  ok  = 1;
  select;
    when(yr = .)    ok =0;
    when(yr < 1992) ok =0;
    when(yr > 1996 and mod(yr,2)=1) ok =0;
    when(yr > 2030) ok = 0;
    otherwise;
  end;
  return(ok); /* function studyyr_ok */
 endsub; 

function data_exist(ref $) group = "aux";
 rc = exist(ref);
 if (ref = "") then rc=0;
 return(rc);
endsub;

