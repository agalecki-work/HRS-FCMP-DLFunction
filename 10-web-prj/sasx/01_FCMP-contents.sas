Title  " > PROC CONTENTS";
Title2 " > 01_FCMP-contents.sas"; 
libname clib "&prj01_path/info-prj01";
ods exclude all;
proc contents data = clib.dlfunction;
  ods output variables=fcmp_info;
run;
ods exclude none;

proc sort data = fcmp_info;
by num;
run;

proc print data = fcmp_info;
var variable type label;
run;
