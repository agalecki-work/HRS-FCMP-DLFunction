
Title "List of functions/subroutines (grouped by fcmp group)";
Title2 "01_FCMP-fun_list.sas";
libname clib "&prj01_path/_cmplib_info";
proc print data = clib.dlfunction;
var fcmp_name value;
by fcmp_grp;
run;

