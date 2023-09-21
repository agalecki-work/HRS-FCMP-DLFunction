/*--- autoexec.sas in 01-FCMP-prj folder ---*/
/* Template:  autoexec-01-tmplt.sas */

options nocenter;

%let prj_path = . ;         /*  Path to current folder */

/* Create global macro vars */


%let _cmplib_path= &prj_path\_cmplib;

%let _cmplib_info_path = &prj_path\info-prj01;

%let _fcmp_source_path = &prj_path\fcmp_source;

/*--- No changes in the section below -------*/
filename macros "&prj_path/macros-01";

