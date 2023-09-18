%put   _fcmp_source_path = &_fcmp_source_path;
options mprint;

%macro src2rmd(sasref, fout );


data _dtlines;
 infile &sasref truncover lrecl = 32767;
 length strip_line $ 500;
 length cx3 $3;
 length cx7 t7 $7;
 length cx6 t6 z6 $6;
 length t5 $5;
 input orig_line $1-500;;
 put orig_line =;
 line_no = _n_;
 strip_line = strip(orig_line);
 cx7 = upcase(substr(strip_line, 1, 7));
 cx3 = upcase(substr(strip_line, 1, 3));

 cx6 = upcase(substr(strip_line, 1, 6));
 orig20 = substr(orig_line, 1, 20);
 t6 = "/*RMD*";
 z6 = "*RMD*/";
 t7 = "*START*";
 z5 = "*END*";
run;

 
data _dtlines2;
  set _dtlines;
  length note errx $200;
  length stmnt $20; 
  retain in1 in2 " ";
  retain match1 match2 0;
  in3 ="-";
  len = length(orig_line);
  if cx6 = t6 then do;
     stmnt = "Rmd_start";
     in1 = "+"; /* rmd */
  end;
  
  if cx6 = z6 then do;
     stmnt ="Rmd_exit";
     in1 = "-"; 
  end; 
  
  if cx7 = t7  then do;
     stmnt = "Chunk start";
     in2 ="+";
     if lastc ne ";" then errx = "Semicolon at the end of line is missing";
  end;
  
  if cx5 = z5 then do;
     stmnt = "Chunk exit";
     in2 = "-";
  end; 
  if cx3 in ("** ", "**") then do;
     stmnt = "Rmd_line";
     in3 = "+";
  end;
  
  
  if in1 ='-' and in3 ="-" and stmnt="" then stmnt="sas";
  
  lastc = substr(orig_line, len, 1);
  if cx6 = t6  then match1 = match1  +1;
  if cx6 = z6  then match1 = match1 -1;
  if cx7 = t7  then match2 = match2  +1;
  if cx5 =z5  then match2 = match2 -1;
  if match1 <0 or match1 > 1 then errx = "match 1 invalid"; 
  if match2 <0 or match2 > 1 then errx = "match 2 invalid"; 

run;

data _dtout_;
 length line_out $ 150;
 set _dtlines2;
 len = length(orig_line);
 line_out =  trim(orig_line) || "  ";
 if cx5 =z5 then line_out = "```";  
 if in3 = "+" and in1 ="-" and in2 = "-" then do;
   line_out = substr(trim(orig_line), 4, len) || "  "; /* Shorten string */
 end;
 if stmnt ="sas" then line_out="xyz" || strip(orig_line);
run;

data _summary;
  set  _dtout_;
  *if stmnt in ("Rmd_line", "Chunk start", "Chunk exit", "Rmd_start", "Rmd_exit") then output ;
 if stmnt ne "";
run;

data _null_;
 set _dtout_;
 file &fout;
 
 *if cx3 in  ("-*/") or cx6 ="/*+RMD" then delete;
 if stmnt in ("Rmd_line", "Chunk start", "Chunk exit", "Rmd_start", "Rmd_exit") then delete ;
  put line_out;
run;


%mend src2rmd;




%let basename = _auxiliary;  /* Basename */
filename aux "&_fcmp_source_path/&basename..sas"; 
filename frmd "./_cmplib_info/&basename..Rmd";

%src2rmd(aux, frmd);

proc print data =_dtout_;
var line_no orig20 len cx3 cx5 cx6 cx7 stmnt lastc match1 match2 in1 in2 in3 errx;

run;


Title "_summary";
proc print data=_summary;
var line_no orig_line stmnt errx;
run;


