/*---  autoexec.sas  ---*/

options mprint nocenter;
%put prj_path = &prj_path;

%include   macros(create_fcmp_lib filenamesInFolder);  

/* Create FCMP cmplib (source in src folder)*/

%let member = DLFunction; 
libname lib "&_cmplib_path";
%create_fcmp(lib, &member);


ods listing close;

/* Process _FCMP_info dataset  */

libname _tmp "&_cmplib_info_path";
data _tmp.&member;
 set _FCMP_info;
run;



%let html_path = &_cmplib_info_path/&member..html;


ods html file = "&html_path";

Title "List of FCMP GROUPS in &member library member";

proc sort data= _FCMP_info out = _grps nodupkey;
by fcmp_grp;
run;

proc print data = _grps;
var fcmp_grp;
run;


Title "List of funs/subs in &member library member (by fcmp_grp)";
proc print data =_FCMP_info;
by fcmp_grp;
run;
ods html close;


