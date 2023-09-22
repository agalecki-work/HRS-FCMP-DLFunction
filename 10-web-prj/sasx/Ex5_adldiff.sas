Title '>> Example: year = 1995, vgrps = "subhh$ adldiff"';
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;

/* Aim: Create dataset for one year using variables from selected vgrps */

%macro create_info(year, libin = hrs_core, vgrps =?, out_prefix = work.info);
/* Macro requires options cmplib = <libref>
   Macro generates 3 datasets with the following default names:
   
  work.info_datain: Dataset with one row 
  _vgrps_info: One row per (selected) variable group. By default all variable groups
     are selected
  _vout
*/
%let  out_prefix=a.b;
%let dot =%sysfunc(findc(&out_prefix, "."));
%put dot =&dot;
%let out = %scan(&out_prefix, 1, .); 
%put out = &out;
data _datain_info;
 year = &year;
 hrs_libin ="&libin";
 datain = dispatch_datain(&year);
run;

data _vgrps_all; /* One row per vra group */
 file print;
 length vgrp $32;
 length ctype $ 1;
 list_allvgrps = bind_vgrps("?"); 
 put / list_allvgrps =;
 cnt_vgrps  = countw(list_allvgrps);
 
 do i =1 to cnt_vgrps;
   vgrp = scan(list_allvgrps, i, " ");
   if findc(vgrp,'$') then ctype ="$"; else ctype ="";
   vout_nms =  dispatch_vout(vgrp);
   cnt_vout = countw(vout_nms);
   output;
 end; 
 drop i list_allvgrps cnt_vgrps;
run;    

data _vgrps_info (keep = vgrp ctype cnt_vout vout_nms);
  set _vgrps_all;
  sel_vgrps =  bind_vgrps("&vgrps"); 
  cnt_vgrps  = countw(sel_vgrps);
  keep_grp = 0;
  do i =1 to cnt_vgrps;  /* loop over selected vgrps */
    grpi = scan(sel_vgrps, i, " ");
    if upcase(vgrp) = upcase(grpi) then keep_grp +1 ;
  end;
  if keep_grp;
run;

data _vout_info(keep = vgrp vout_nm ctype len ctypelen vout_lbl);
  set _vgrps_info;
  length ctypelen $6;
  do i = 1 to cnt_vout;
   vout_nm = scan(vout_nms, i, " ");
   len = vout_length(vout_nm); /* Variable length */
   ctypelen = strip(ctype) ||strip(len);
   vout_lbl = vout_label(vout_nm);
   output;
  end;
run;

proc sql noprint;
 select vgrp     into :vgrp_list  separated by "~"  from _vgrps_info;
 select count(*) into :cnt_vgrps  from _vgrps_info;
 select count(*) into :cnt_vout from _vout_info;
 select vout_nm  into :vout_list  separated by " "  from _vout_info;
** select year     into :hrsyears_list separated by  " "  from  _datain_skip_info;
**  select count(*) into :cnt_hrsyears from _datain_skip_info;
 select vout_lbl into :lbl_list   separated by "~"  from _vout_info;
 select ctype    into :ctype_list  separated by "~"  from _vout_info;
quit;
%put # of var groups         := &cnt_vgrps;
%put List of var groups      := &vgrp_list;
%put # of harmonized vars    := &cnt_vout;
%put List of harmonized vars := &vout_list;
%put List of ctype variable  := &ctype_list;


%mend process_year;

%*process_year(1995); /* All var groups included by default */
%process_year(2002, vgrps= subhh$ skip);

Title ">>  Selected Var groups info";

proc print data =_datain_info;
run;


proc print data =_vgrps_info;
run;

proc print data = _vout_info;
run;


endsas;

data _v

%let vgrps = subhh$ adldiff; /* Selected var groups */



/*--  Create auxiliary  macro variables pertaining to year 1995 */
%let datain=;             /* Input SAS dataset name */
%let cnt_vgrps=;          /* No of selected var groups */
%let vin_nms_all =;       /* List of variables in the input dataset */
%let ctype_list =;        /* List with variable type  */
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
  missing  O D R I N Z; /* Check why there is no _ in harmn_hrs.sas */
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


 

 