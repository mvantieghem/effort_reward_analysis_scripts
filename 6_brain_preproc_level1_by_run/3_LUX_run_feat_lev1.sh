#!/bin/bash

# this script will run feat on level1 fsf files for each run 
# updated for effort task Jan 12, 2018


# get the subject list 
sublist=$(</danl/PACCT/scripts/effort_reward/FSL_pipeline/Sublists/subject_list_2018-01-15.txt)

# get the paths you'll need 
derivatives="/danl/PACCT/subject_data/derivatives/"
run1="/effort/model/lev1_run1.feat"
run2="/effort/model/lev1_run2.feat"
run1_fsf="_effort_run1_lev1.fsf"
run2_fsf="_effort_run2_lev1.fsf"

# go to the directory where you saved the lev1 fsf files 
cd /danl/PACCT/scripts/effort_reward/FSL_pipeline/2.preprocessing/lev1_fsfs/

# for each subject in the list, 
for n in $sublist; do 

	# check if lev1 run1 processing already done 
	if [ ! -d $derivatives$n$run1 ]; then
		echo "start lev1 run1 processing for ${n}"
		# run feat for all subjects for each run ! 
		feat $n$run1_fsf	

	fi
	# check if lev1 run2 processing already done 
	if [ ! -d $derivatives$n$run2 ]; then 
		echo "start lev1 run2 processing for $n"
		# run feat for 	run2
		feat $n$run2_fsf
	fi
done


