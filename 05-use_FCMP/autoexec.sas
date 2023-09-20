/*------- autoexec.sas in `05-use_fcmp` project folder -----*/

/*--- This file was obtained by modifying  `autoexec_templt.sas` ---*/

options mprint nocenter;


/* Path to FCMP library */
%let cmplib_path = ../01-create-FCMP/_cmplib;    /* Path to CMPLIB folder */

/*---  Define libref `hrs_core` for  HRS Core data  --- */
%let hrs_core_path = C:\Users\agalecki\Dropbox (University of Michigan)\DDBC HRS Project\scrambled data;
libname hrs_core  "&hrs_core_path";

/* Path to Output folder */
%let out_path = ./out; 

/* Path to project folder */
%let prj_path =.;  



