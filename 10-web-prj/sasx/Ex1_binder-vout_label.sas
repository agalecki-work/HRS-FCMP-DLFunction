Title ">> Function vout_label()";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
data _null_;
  length x $50;
  file print;
  
  put / '--- vout_label("subhh"): Returns variable label ---';
  x = vout_label("subhh");
  put x = ;  
  
  put / '--- vout_label("nagi_walks"): Returns variable label ---';
  x = vout_label("nagi_walks");
  put x = ;  

  put / '--- vout_label("_test_new_name"): Returns variable label ---';
    x = vout_label("_test_new_name");
    put x = ;  

  
  run;

