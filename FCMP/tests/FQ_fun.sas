/* ADL-aux-FQ_fun */
data dtin;
  input varin @@;
cards;
1 5 97 -8 8 98 9 99
;
run;

data out; 
    set dtin(keep = varin); 
    vnew =  FQ_fun(1992, varin);
run;

proc print data=out;
run;
