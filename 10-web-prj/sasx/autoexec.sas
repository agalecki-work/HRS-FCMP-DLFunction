/* autoexec.sas file in `10-web-prj.sas/sasx` folder */

options nocenter mprint;
%put The current program is %sysfunc(getoption(sysin)); 


/*====== KEY PATHS defined here ===========*/

/* ----- Path to HRS Core data ------------*/

%let hrs_data_path = C:\Users\agalecki\Dropbox (University of Michigan)\DDBC HRS Project\scrambled data;

/*------ Path to  current project ------- */

%let prj_path = ..; 
filename macros "&prj_path/macros-10";

/* Path to `01-create-FCMP-prj` project */

%let prj01_path = ../../01-create-FCMP-prj;

/*----- Path to `05-use_FCMP-prj` project ----*/
%let prj05_path = ../../05-use_FCMP-prj;



