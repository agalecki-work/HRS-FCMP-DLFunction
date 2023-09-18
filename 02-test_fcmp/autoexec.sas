options mprint;

/*---  Define hrs_data SAS libref --- */
%let pp = C:\Users\agalecki\Dropbox (University of Michigan)\DDBC HRS Project\scrambled data;

/* Define hrs_data libref */
libname hrs_data "&pp";

%let _dataout_path = .; /* Path to folder for output data */


