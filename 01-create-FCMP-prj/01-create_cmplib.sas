/*---  autoexec.sas  ---*/

options mprint nocenter;
%put prj_path = &prj_path;

%include   macros(create_fcmp_lib filenamesInFolder);  

/* Create FCMP cmplib (source in src folder)*/

libname lib "&_cmplib_path";
%create_fcmp(lib,  DLFunction);


