/*---  autoexec.sas ---*/

options mprint nocenter;
%put fcmp_path = &fcmp_path;

%include _macros(create_fcmp_lib filenamesInFolder);  

/* process FCMP cmplib (source in src folder)*/

libname lib "&_cmplib_path";
%create_fcmp(lib,  DLFunction);


