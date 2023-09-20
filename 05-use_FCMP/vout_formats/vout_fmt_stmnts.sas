/* Format statements for vout variables (One macro per one group of vout variables --*/
/* Note the pattern in macros naming convention */

%macro nagi_grp_fmt;
format 
  nagi_walks nagi_jog   nagi_walk1 nagi_sit
  nagi_chair nagi_clims nagi_clim1 nagi_stoop
  nagi_arms  nagi_push  nagi_lift  nagi_dime
     QF.; 
%mend nagi_grp_fmt;

%macro skip_grp_fmt;

%mend  skip_grp_fmt; 

%macro alldif_grp_fmt;

%mend alldiff_grp_fmt;

%macro equip_grp_fmt;

%mend  equip_grp_fmt;

%macro iadldif_grp_fmt;

%mend  iadldif_grp_fmt;

%macro why_grp_fmt;

%mend  why_grp_fmt; 

