Title ">> Function bind_vgrps()";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
data _null_;
  lenght x $50;
  file print;
  put / "--- Returns list of ALLvar groups ---";
  x = bind_vgrps("?");
  put x = ;
  
  put / "--- Returns a list of selected var grps ---";
  x = bind_vgrps("subhh$ skip why");
  put x = ;

run;

