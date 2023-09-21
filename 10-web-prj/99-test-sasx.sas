%let p = sasx/;

%include macros(filenamesInFolder);
%filenamesInFolder(&prj_path/sasx);

data fnms;
  set _filenames;
  length ext name $ 32;
  ext = scan(fname,-1,'.');
  name = scan(fname,1,'.');
  if upcase(ext) = "SAS" then output;
run;

 data fnms2;
    set fnms;
    file "99-test-sasx.txt";
    file_no = _n_;
    nm_grp = scan(name, 1, '-'); 
    put 'filename ff "' "./&p" fname '";';
    put "%" "include ff;";
    drop ext fname;
run;

ods html file="./out/99-test-sasx.html";

proc freq data = fnms2;
tables nm_grp;
run;

proc print data = fnms2;
run;


%include "./99-test-sasx.txt";
ods html close;
endsas;


filename ff "./&p/fcmp-contents.sas";
%include ff;

filename ff "./&p/fcmp-grp_list.sas";
%include ff;

filename ff "./&p/fcmp-fun_list.sas";
%include ff;
