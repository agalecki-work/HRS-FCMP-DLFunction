options mprint nocenter;

%let fcmp_path = [LOCATION]\FCMP;        /* <=== USER MUST modify */
%include "&fcmp_path\_global_mvars.inc"; /* Global macro vars defined */
%include _macros(create_fcmp_lib filenamesInFolder);  

/* process FCMP cmplib (source in src folder)*/

libname lib "&_cmplib_path\DLFunction";
%create_fcmp(lib,DLFunction);

endsas;
