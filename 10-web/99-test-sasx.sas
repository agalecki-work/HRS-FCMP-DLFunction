%let p = ./sasex;
filename ff "./&p/fcmp-contents.sas";
%include ff;

filename ff "./&p/fcmp-grp_list.sas";
%include ff;

filename ff "./&p/fcmp-fun_list.sas";
%include ff;
