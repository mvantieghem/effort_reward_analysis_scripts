#!/bin/bash 

# convert files for subjects with only 1 run 
#  AKA put copes in standard space!


while read SUBJECTID RunNumber
do

 echo "sub is $SUBJECTID"
 echo "run is $RunNumber"

#SUBJECTID="PA174"
#RunNumber="run1"

cope_list_all="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24"
#cope_list_collapsed_EVs="1 2 3 4 5 6 7 8 9 10"
#cope_list_choice_contrast_EVs="1 2 3 4 5 6"
#cope_list_hard_FB_contrast_EVs="1 2 3 4 5"

  for n in $cope_list_all; do
	
	  path="/rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/preproc_lev1_${RunNumber}.feat"
	  echo "running registration ${SUBJECTID} ${RunNumber} cope${n}"
          sbatch -o ${SUBJECTID}-%j.out -e  ${SUBJECTID}-%j.err 5B_convert_files_for_subs_with_1_run.sh $SUBJECTID $RunNumber $n $path	
  done

done < "/rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/Sublists/level2_sublists/sublist_include_1_run_doesnotneed_level2_model_2019-08-06.txt"




