
libname clib "&_cmplib_info_path";

Title "List of function/subroutine groups";

proc sort data = clib.dlfunction
           out = vgrps nodupkey;
by fcmp_grp;
;

proc print data = vgrps;
var fcmp_grp;
run;

