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

filename _tstmac "&prj_path\macros-05"; /* folder with macros */

%include _tstmac(summ_project);
%include _tstmac(_aux_mac);
%include _tstmac(harmn_hrs);
%include _tstmac(summ_fcmplib binder_info); /* Macros loaded */

%let fcmp_member = DLFunction;

/* STEP 1: cmplib:  FCMP library information */
/* `_ucmplib` SAS libref to FCMP library */
ods html file = "&out_path/S1-cmplib-info.html";
%hrs_binder(cmplib= _ucmplib);
ods html close;


/* STEP 2: member: FCMP member information */
ods html file = "&out_path/S2-FCMP-member-info.html";
%hrs_binder(cmplib= _ucmplib, member = &fcmp_member);
ods html close;


/* STEP 3: hrs_years: HRS years information */

ods html file = "&out_path/S3-HRS_years-info.html";
%hrs_binder(cmplib= _ucmplib, member = &fcmp_member,
            hrs_years = 1992-2020);
ods html close;

/* STEP 4: vgrps: Selected harmonized var groups info  */

ods html file = "&out_path/S4-vgrps-info.html";
%hrs_binder(cmplib= _ucmplib, member = &fcmp_member,
            hrs_years = 1992-2020, vgrps = nagi);
ods html close;

/* STEP 5 dataout: Dataout in `hrs_core` SAS library */
/* Note: `vgrps=?` selects all harmonized var groups */

ods html file = "&out_path/S5-dataout-info.html";
%hrs_binder (cmplib= _ucmplib, member = &fcmp_member, 
             hrs_years = 1992-2020, vgrps = ?, dataout=dtout.hrs_out);
ods html close;
