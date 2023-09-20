/*--- ADL-binder-dispatch_datain --- */
data yearx;
   year = 1992; output;
   year = 1995; output;
   year = 2002; output;
   year = 2010; output;
run;
 
data dt_name;
   set yearx;
   HRS_data = dispatch_datain(year);
run;
;
Title "dispatch_datain function executed";
proc print data = dt_name;
run;
