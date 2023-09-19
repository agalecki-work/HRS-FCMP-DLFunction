
libname clib "&_cmplib_info_path";

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
