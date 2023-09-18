options mprint;

/* See definitions in autoexec.sas */

%put test_fcmp_path := &test_fcmp_path;    /* Current directory */
%put fcmp_path      := &fcmp_path;         /* Path to HRS-FCMP directory (one level up) */
%put hrs_data_path  := &hrs_data_path;     /* Path to HRS data */



/*---  Define paths to selected folders ---*/
%let _cmplib_path = &fcmp_path/_cmplib;       /* Compiled FCMP */
%put _cmplib_path := &_cmplib_path;


/* Create global macro vars */
/* Code below requires _cmplib path and cdir_path macro vars */ 


libname hrs_data "&hrs_data_path";  /* HRS Core data */ 
libname dtout    "&data_out_path";  /* Output library */

/* FCMP library into `_ucmplib` */ 
libname _ucmplib "&_cmplib_path";

filename _tstmac "&test_fcmp_path\hrs-macros"; /* folder with macros */

%include _tstmac(summ_project);
%include _tstmac(_aux_mac);
%include _tstmac(harmn_hrs);
%include _tstmac(summ_fcmplib binder_info); /* Macros loaded */

%let fcmp_member = DLFunction;
ods html file = "&test_fcmp_path/test_fcmp.html";
%hrs_binder (cmplib= _ucmplib, member = &fcmp_member, 
             hrs_years = 1992-2020, hrs_libin = hrs_data, dataout=dtout.hrs_out);
ods html close;
