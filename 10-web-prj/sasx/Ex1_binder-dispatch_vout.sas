Title ">> Function dispatch_vout()";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
data _null_;
  length x $50;
  file print;
  
  put / "--- bind_vgrps('?'): Returns a list of ALL var groups ---";
  x = bind_vgrps("?");
  put x = ;  
  
  put / "--- dispatch_vout(): List of outvars in <subbh$> var group ---";
  x = dispatch_vout("subhh$");
  put x = ;
  
  put / "--- dispatch_vout(): List of outvars in <why>  var group ---";
  x = dispatch_vout("why");
  put x = ;
run;

