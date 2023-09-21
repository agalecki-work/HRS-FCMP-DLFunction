Title '>> Example: year = 1995, vgrps = "subhh$ adldiff"';
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;

/* Aim: Create dataset for one year using variables from selected vgrps */
%let year  = 1995;
%let vgrps = subhh$ adldiff; /* Selected var groups */

/*--  Create auxiliary  macro variables pertaining to year 1995 */
%let datain=;             /* Input SAS dataset name */
%let cnt_vgrps=;          /* No of selected var groups */
%let vin_nms_all =;       /* List of variables in the input dataset */
%let vout_list =;         /* List of variables in the output dataset */

data _mvars;
 length vgrps $ 200;
 length datain $50;
 length vout_list $ 5000;
 length vin_nms_all  $5000;
 file print;
 studyyr = &year; 
 vgrps = "&vgrps"; 
 datain = dispatch_datain(studyyr);  /*--- Input dataset name ---*/
 put / "Study year:" studyyr;
 put  "Input data:"  datain;
 cnt_vgrps = countw(vgrps); 
 put / "No of vgrps :=" cnt_vgrps " (No of var groups)" ;

 vin_nms_all = "";
 vin_nms_all = strip(vin_nms_all)|| " " || dispatch_vin(studyyr, "subhh$");
 vin_nms_all = strip(vin_nms_all)|| " " || dispatch_vin(studyyr, "adldiff");
 
 put / "Input variable names";
 put "vin_nms_all :=" vin_nms_all; 
 
 vout_list = "";
 vout_list = strip(vout_list) || " " ||  dispatch_vout("subhh$");
 vout_list = strip(vout_list) || " " ||  dispatch_vout("adldiff");
 put / "Output variable names";
 put "vout_list :=" vout_list; 


run;

endsas;

 
 

 
 call symput("datain", strip(datain));
run;



data _1995_outdata;
  set hrs_core.&datain(keep = pn hhid &vin_nms_all);
  missing _ O D R I N Z; /* Check why there is no _ in harmn_hrs.sas */
  _CHARZZZ_= "";         /*  Artificial variable */
  _ZZZ_ =.;
  studyyr =&year;
    
    /*-- set initial values to missing for all variables ---*/
     %do i=1 %to &cnt_vout; 
       %let vnm = %scan(&vout_list, &i);      /* i-th variable name */ 
       %let ctype= %scan(&ctype_list, &i, ~); /* i-th variable type ($ or blank)
       &vnm =
       %if &ctype =$ %then "?"; %else .Z;;
     %end;    
     
     %do i =1 %to &cnt_vgrps;
       %let _vgrp = %scan(&vgrp_list, &i,'~');  /* 
       %let vinz = %scan(&vinz_nms_grpd, &i, '~');
       %let vout = %scan(&vout_nms_grpd, &i,  '~');
       %array_stmnt2(&year, &_vgrp, &vout, &vinz);
     %end;
 drop &vin_nms_all;
  drop _CHARZZZ_ _ZZZ_;
run;


 

 