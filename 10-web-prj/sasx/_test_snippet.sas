Title ">> Function `fcmp_member_info";
libname clib "&prj01_path/_cmplib";
options cmplib = clib.dlfunction;

data _null_;
  lenght x $50;
  file print;
  put / "--- FCMP member list of info items ---";
  x = fcmp_member_info("");
  put x = ;
  
  put / "--- FCMP member label ---";
  x = fcmp_member_info("label");
  put x = ;

  put / "--- FCMP member name ---";
  x = fcmp_member_info("fcmp_member");
  put x = ;

  put / "--- FCMP member version date ---";
  x = fcmp_member_info("version_date");
  put x = ;


  put / "--- FCMP member date stamp ---";
  x = fcmp_member_info("datestamp");
  put x = ;


run;






