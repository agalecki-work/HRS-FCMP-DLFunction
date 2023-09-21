Title ">> Function dispatch_vin()";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;
data _null_;
  length x $50;
  file print;
  
  year = 1992;
  
  put / "--- dispatch_vin: Returns a list of vars in <SUBHH$> group ---";
  put / 'dispatch_vin(year, "subhh$");';
  x = dispatch_vin(year, "subhh$");
  put year= ", " x = ;  
  
  put / "--- dispatch_vin: Returns list of outvars in <why> var group ---";
  x = dispatch_vin(year, "why");
  put year= ", " x = ;
  
  year = 2004;
    
    put / "--- dispatch_vin: Returns a list of vars in <SUBHH$> group ---";
    put / 'dispatch_vin(year, "subhh$");';
    x = dispatch_vin(year, "subhh$");
    put year= ", " x = ;  
    
    put / "--- dispatch_vin: Returns list of outvars in <why> var group ---";
    x = dispatch_vin(year, "why");
    put year= ", " x = ;

  
 run;

