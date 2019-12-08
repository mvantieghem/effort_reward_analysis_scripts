#!/bin/bash
#use this script to run feat level 2 on your list of subjects
# this script calls the submit script for habanero to run jobs simultanously


### USING WHILE LOOP TO READ IN SUBJECT & RUN LIST
### NOTE SUB LIST WILL CHANGE DEPENDING ON VERSION! 

while read SUBJECTID
do

#SUBJECTID="PA238"

  echo "sub is $SUBJECTID"
  sbatch -o ${SUBJECTID}-%j.out -e  ${SUBJECTID}-%j.err 4B_HABA_submit_feat_lev2.sh $SUBJECTID 

done < "../../Sublists/level2_sublists/sublist_include_2_runs_for_level2_2019-08-06.txt"


