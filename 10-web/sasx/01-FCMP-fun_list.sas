
libname clib "&_cmplib_info_path";

Title "List of functions/subroutines (grouped by fcmp group)";

proc print data = clib.dlfunction;
var fcmp_name value;
by fcmp_grp;
run;

