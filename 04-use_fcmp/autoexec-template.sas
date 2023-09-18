options mprint;



/*---  Define hrs_data SAS libref --- */
libname hrs2020c "[LOCATION of 2020 H20g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2018c "[LOCATION of 2018 H18g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2016c "[LOCATION of 2016 H16g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2014c "[LOCATION of 2014 H14g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2012c "[LOCATION of 2012 H12g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2010c "[LOCATION of 2010 H10g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2008c "[LOCATION of 2008 H08g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2006c "[LOCATION of 2006 H06g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2004c "[LOCATION of 2004 H04g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2002c "[LOCATION of 2002 H02g_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs2000c "[LOCATION of 2000 H00e_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs1998c "[LOCATION of 1998 H98e_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs1996c "[LOCATION of 1996 H96e_r.sas7bdat]";		/* <=== USER MUST modify */
libname hrs1995c "[LOCATION of 1995 H95e_r.sas7bdat]";		/* <=== USER MUST modify */

/* Cancatenate HRS libraries */
libname hrs_data (hrs2020c
                  hrs2018c hrs2016c hrs2014c hrs2012c hrs2010c hrs2008c hrs2006c hrs2004c  
                  hrs2002c hrs2000c hrs1998c hrs1996c hrs1995c);



%let _dataout_path = [PATH to OUTPUTFOLDER]; /* Path to folder for output data */


