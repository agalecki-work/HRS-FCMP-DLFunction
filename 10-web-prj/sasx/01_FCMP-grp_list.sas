Title   "> List of FCMP groups";
Title2  "> 01_FCMP-grp_list.sas";

libname cinfo "&prj01_path/info-prj01";

proc sort data = cinfo.dlfunction
           out = vgrps nodupkey;
by fcmp_grp;
;

proc print data = vgrps;
var fcmp_grp;
run;


