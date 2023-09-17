%put   _fcmp_source_path = &_fcmp_source_path;
options mprint;

%macro src2rmd(sasref, fout );


data _dtlines;
 infile &sasref truncover lrecl = 32767;
 length strip_line $ 500;
 length cx3 $3;
 length cx6 $6;
 input orig_line $1-500;;
 put orig_line =;
 line_no = _n_;
 strip_line = strip(orig_line);
 cx3 = substr(strip_line, 1, 3);
 cx6 = upcase(substr(strip_line, 1, 6));
 orig20 = substr(orig_line, 1, 20);
run;

 
data _dtlines2;
  set _dtlines;
  length note errx $200;
  length stmnt $20; 
  retain in1 in2 in3 " ";
  retain match1 match2 0;
  len = length(orig_line);
  if cx6 in ("/*+RMD") then do;
     stmnt = "Rmd_start";
     in1 = "+"; /* rmd */
  end;
  
  if cx3 in ("-*/") then do;
     stmnt ="Rmd_exit";
     in1 = "-"; 
  end; 
  
  if cx3 in ("*+ ") then do;
     stmnt = "Chunk start";
     in2 ="+";
     if lastc ne ";" then errx = "Semicolon at the end of line is missing";
  end;
  
  if cx3 in ("*- ", "*-;") then do;
     stmnt = "Chunk exit";
     in2 = "-";
  end; 
  if cx3 = "** " then do;
     stmnt = "Rmd_line";
     in3 = "+";
  end;
  
  if cx3= "-*/"  or cx6 = "/*-RMD" then do;
    note = substr(orig_line, 4, len -5);
    note20 = substr(note, 1,20);
  end;
  
  lastc = substr(orig_line, len, 1);
  if cx6 = "/*+RMD"  then match1 = match1  +1;
  if cx3 = "-*/ " then match1 = match1 -1;
  if cx3 = "*+ "  then match2 = match2  +1;
  if cx3 in ("*- ","*-;") then match2 = match2 -1;
  if match1 <0 or match1 > 1 then errx = "match 1 invalid"; 
  if match2 <0 or match2 > 1 then errx = "match 2 invalid"; 

run;

data _dtout_;
 length line_out $ 150;
 set _dtlines2;
 len = length(orig_line);
 line_out =  trim(orig_line) || "  ";
 if cx3 in ("*- ", "*-;") then line_out = "```";  
 if in3 = "+" and in1 ="-" and in2 = "-" then do;
   line_out = substr(trim(orig_line), 4, len) || "  "; /* Shorten string */
 end;

run;

data _summary;
  set  _dtout_;
  if stmnt in ("Rmd_line", "Chunk start", "Chunk exit", "Rmd_start", "Rmd_exit") then output ;
run;

data _null_;
 set _dtout_;
 file &fout;
  put line_out;
 *if cx3 in  ("-*/") or cx6 ="/*+RMD" then delete;
 if stmnt in ("Rmd_line", "Chunk start", "Chunk exit", "Rmd_start", "Rmd_exit") then delete ;

run;


%mend src2rmd;




%let basename = _auxiliary;  /* Basename */
filename aux "&_fcmp_source_path/&basename..sas"; 
filename frmd "./_cmplib_info/&basename..Rmd";

%src2rmd(aux, frmd);

proc print data =_dtout_;
var line_no orig20 len cx3 stmnt lastc match1 match2 in1 in2 in3 errx;

run;


Title "_summary";
proc print data=_summary;
var line_no orig20 len cx3 stmnt lastc match1 match2 in1 in2 in3 errx;
run;


