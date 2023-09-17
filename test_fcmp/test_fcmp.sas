options mprint;


/*---  Define paths to selected folders ---*/

%let fcmp_path = .. ;    /*  Path to HRS-FCMP-DLFunction directory (one level up) */
%let  test_fcmp_path = &fcmp_path/test_fcmp;  /* Current directory */
%let _cmplib_path = &fcmp_path/_cmplib;       /* Compiled FCMP */

/* Create global macro vars */
/* Code below requires _cmplib path and cdir_path macro vars */ 

/* FCMP library into `_ucmplib` */ 
libname _ucmplib "&_cmplib_path";

filename _tstmac "&test_fcmp_path\hrs-macros";
%include _tstmac;




libname lib ".";			/* <=== OUTPUT libref USER MUST modify */
%put test_fcmp_path := &test_fcmp_path;
%put _cmplib_path := &_cmplib_path;

%*** include "&test_fcmp_path/_global_test_mvars.inc"; /* global macro vars loaded */

%include _tstmac(summ_project);
%include _tstmac(_aux_mac);
%include _tstmac(harmn_hrs);
%include _tstmac(summ_fcmplib binder_info); /* Macros loaded */

%let fcmp_member = DLFunction;
ods html file = "&test_fcmp_path/test_fcmp.html";
%hrs_binder (cmplib= _ucmplib, member = &fcmp_member, 
             hrs_years = 1992-2020, hrs_libin = hrs_data, dataout=lib.hrs_out_DLFunction);
ods html close;
