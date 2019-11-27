#!/bin/bash
# Michelle's script for anatomical skull-strip 
# January 15, 2018 

# NOTES 
#***before running this script, change the date-stamps for the subject lists!!**
# using bet - FSL's default skull strip option.


# get the subject list
sublist=$(</danl/PACCT/scripts/effort_reward/FSL_pipeline/Sublists/scans_to_process.txt)
#sublist="PA046"
# set the paths you'll need 
derivatives_dir="/danl/PACCT/subject_data/derivatives/effort_reward/"
anat_dir="/anatomical/"
t1_file="_T1w" #.nii.gz"
brain="_brain"
vnifti=".nii.gz"

 

#for each file in the list
for n in $sublist; do 
 # remove the junk you accidentally made!!!
	#rm $derivatives_dir$n$anat_dir$n$t1_file$nifti$brain$nifti

  # make a path for their anatomical file 
  anat_file=$derivatives_dir$n$anat_dir$n$t1_file$nifti
  # make path for skull strip file
  skull_stripped=$derivatives_dir$n$anat_dir$n$t1_file$brain$nifti

# only run bet if skull srip file doesn't exist yet
  if [ ! -f $skull_stripped ]; then
	  echo " skull strip not done yet for $n"
	  # run bet on the anatomical file 
	  # (bet = FSL's skull strip)
	  # append the skull-stripped file with "_brain"s
	 
	   bet $anat_file $skull_stripped
	   echo "finished skull strip for $n"
  fi
done
