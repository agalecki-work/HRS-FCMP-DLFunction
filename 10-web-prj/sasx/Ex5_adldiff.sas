options mprint;
Title '>> Example: year = 1995, vgrps = "subhh$ adldiff"';
* libref hrs_core defined in autoexec.sas ;
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
filename mac5 "&prj05_path/macros-05"; /* Folder with macros */
%include mac5(_aux_mac);

/* Aim: Create dataset for one year using variables from selected vgrps */

%macro create_data_template(hrs_years, libin = hrs_core, vgrps =?);
/* Macro requires options cmplib = <libref>
   Macro generates 3 datasets with the following default names:
   
  work.info_datain: Dataset with one row 
  _vgrps_info: One row per (selected) variable group. By default all variable groups
     are selected
  _vout
  
*/
%expand_years(&hrs_years); /* --- Dataset _hrsyears created ---*/ 

data _hrsinfo_libin_all;
 set  _hrsyears(keep = year);
 length datain $ 20;
 label datain_exist = "";

 hrs_libin ="&libin";
 datain = dispatch_datain(year);
 dtref = strip(hrs_libin)||"."|| strip(datain);
 if strip(datain) = "" then dtref  = ""; 
 datain_exist = data_exist(dtref);
 skipit = " ";
 if datain_exist = 0 then skipit = "Y";
   drop dtref;

run;


data _hrsinfo_libin;
  set _hrsinfo_libin_all;
  if skipit ="Y" then delete;
  drop skipit;
run;



data _vgrps_all; /* One row per var group */
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

data _hrsinfo_vgrps (keep = vgrp ctype cnt_vout vout_nms);
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

data _hrsinfo_vout(keep = vgrp vout_nm ctype len ctypelen vout_lbl);
  set _hrsinfo_vgrps;
  length ctypelen $6;
  do i = 1 to cnt_vout;
   vout_nm = scan(vout_nms, i, " ");
   len = vout_length(vout_nm); /* Variable length */
   ctypelen = strip(ctype) ||strip(len);
   if strip(ctypelen) ="." then ctypelen = " ";
   vout_lbl = vout_label(vout_nm);
   output;
  end;
run;

/* Create macro variables */
proc sql noprint;
 select year     into :hrsyears_list separated by  " "  from  _hrsinfo_libin;
 select count(*) into :cnt_hrsyears                     from _hrsinfo_libin;
 select vgrp     into :vgrp_list     separated by "~"   from _hrsinfo_vgrps;
 select count(*) into :cnt_vgrps                        from _hrsinfo_vgrps;
 select vout_nm  into :vout_list     separated by " "   from _hrsinfo_vout;
 select count(*) into :cnt_vout                         from _hrsinfo_vout;
 select vout_lbl into :lbl_list      separated by "~"   from _hrsinfo_vout;
 select ctype    into :ctype_list    separated by "~"   from _hrsinfo_vout;
quit;

%put List of hrs years       := &hrsyears_list;
%put # of hrs years          := &cnt_hrsyears;
 
%put List of var groups      := &vgrp_list;
%put # of var groups         := &cnt_vgrps;

%put List of harmonized vars := &vout_list;
%put # of harmonized vars    := &cnt_vout;
%put -- List of var labels separated with tilda (~) is stored in `lbl_list` macro var;
%put List of ctype variable  := &ctype_list;
data _tmp;
  set  _hrsinfo_vout;
  if strip(ctypelen) ne '';
run;

*proc print data=_tmp;
run;

%let ctypelen_list =;
proc sql noprint;
 select count(*)  into :cnt_ctypelen                    from _tmp;
 select ctypelen  into :ctypelen_list separated by "~"  from _tmp;
 select vout_nm   into :ctypelen_nms  separated by " "  from _tmp;
quit;

%put # of vars with non blank length := &cnt_ctypelen; 
%put List of ctypelen values := &ctypelen_list;


/*--  STEP0: initialize `_harmonized_out` data */
data _harmonized_base; *  (label ="&fcmp_label.. FCMP member `&fcmp_member` compiled on &fcmp_datestamp.");
 label hhid         = "HOUSEHOLD IDENTIFIER"
      pn            = "PERSON NUMBER"
      studyyr       = "STUDY YEAR";

 /*-- Label statements ---*/
 %do i=1 %to &cnt_vout; 
   %let vnm = %scan(&vout_list, &i);   
   %let vlbl= %scan(&lbl_list, &i, ~);
   %*put vnm := &vnm;
   label &vnm = "&vlbl";
 %end;    
 
 /*-- Length statements ---*/      
 length hhid $6 pn $3;
  %if %eval(&cnt_ctypelen) > 0 %then 
    %do i= 1 %to &cnt_ctypelen;
     %let vnm = %scan(&ctypelen_nms, &i);  
     %let ctp = %scan(&ctypelen_list, &i, ~);
     length &vnm &ctp;
    %end;
 
  call missing(of _all_);
  stop;
;
run;

%mend create_data_template;

%*create_data_template(1992-2030);   /* All var groups included by default */
%create_data_template(2002 2004, vgrps= subhh$ skip);

ods html;

proc print data = _hrsinfo_libin_all;
run;


proc print data = _hrsinfo_libin;
run;

Title ">>  Selected Var groups info";

proc print data = _hrsinfo_vgrps;
run;

proc print data = _hrsinfo_vout;
run;

proc contents data = _harmonized_base;
run;
ods html close;


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


 

 