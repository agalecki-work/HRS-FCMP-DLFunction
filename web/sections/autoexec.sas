options nocenter;
%put The current program is %sysfunc(getoption(sysin)); 
%let cmplib_path = ../../_cmplib;

%let fcmp_cmplib_path =&cmplib_path;

libname _cmp1 "&fcmp_cmplib_path";

options cmplib = _cmp1.dlfunction; 

/* Define hrs_data library */

%let hrs_data_path = C:\Users\agalecki\Dropbox (University of Michigan)\DDBC HRS Project\scrambled data;
libname hrs_data "&hrs_data_path";
