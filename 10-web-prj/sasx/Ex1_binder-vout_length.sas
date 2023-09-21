Title ">> Function vout_length()";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
data _null_;
  length x $50;
  file print;
  
  put / '--- vout_length: Returns length of a character var "subhh" ---';
  x = vout_length("subhh");
  put x = ;  
  
  put / '--- vout_length: Returns missing value for "nagi_walks" ---';
  x = vout_length("nagi_walks");
  put x = ;  

  
  run;

