#!/bin/bash
# use this script to run feat level 1 on your list of subjects
# this script calls the submit script for habanero to run jobs simultanously


### USING WHILE LOOP TO READ IN SUBJECT & RUN LIST
### NOTE SUB LIST WILL CHANGE DEPENDING ON VERSION! 

while read SUBJECTID RunNumber
do
  echo "sub is $SUBJECTID"
  echo "run is $RunNumber"
  sbatch -o ${SUBJECTID}-${RunNumber}-%j.out -e  ${SUBJECTID}-${RunNumber}-%j.err 3B_HABA_submit_feat_lev1_run1.sh $SUBJECTID $RunNumber

done < "../../Sublists/level1_sublists/WITH_error_confounds_for_level1_2019-04-30.txt"


