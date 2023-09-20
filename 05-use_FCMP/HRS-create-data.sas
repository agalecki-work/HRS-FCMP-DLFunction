options mprint;

/* See definitions in autoexec.sas */

/* Path to FCMP library */

%put cmplib_path := &cmplib_path;


%put hrs_core_path  := &hrs_core_path;     /* Path to HRS data */

* NOTE: libname `hrs_core` defined in `autoexec.sas`;
libname dtout    "&out_path";      /* Output library */


%put Project path := &prj_path;    /* Current directory */

/* FCMP library into `_ucmplib` */ 
libname _ucmplib "&cmplib_path";

filename _tstmac "&prj_path\hrs-macros"; /* folder with macros */

%include _tstmac(summ_project);
%include _tstmac(_aux_mac);
%include _tstmac(harmn_hrs);
%include _tstmac(summ_fcmplib binder_info); /* Macros loaded */

%let fcmp_member = DLFunction;
ods html file = "&out_path/_output-data-contents.html";
%hrs_binder (cmplib= _ucmplib, member = &fcmp_member, 
             hrs_years = 1992-2020, hrs_libin = hrs_data, dataout=dtout.hrs_out);
ods html close;
