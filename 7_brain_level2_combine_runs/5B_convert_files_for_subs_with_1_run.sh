#!/bin/sh

#SBATCH --account=psych
#SBATCH --job-name=effort_run1_level1
#SBATCH -c 4
#SBATCH --time=11:55:00
#SBATCH --mem-per-cpu=4gb

SUBJECTID=$1
RunNumber=$2
n=$3
path=$4

# convert files for subjects with only 1 run 
#  AKA put copes in standard space!

# copy registration into level 1 folders first!
#cp -r /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/preproc_${RunNumber}.feat/reg* ${path}

 # info for applywarp command in FSL which will apply the registration to standard space
	#i = input
	  #r = reference image
	  # o = output
	  #w = warp from level1 registration
 	# converting the zstats and the copes!
  
applywarp -i ${path}/stats/zstat${n}.nii.gz -o ${path}/stats/zstat${n}_standard.nii.gz -r ${path}/reg/example_func2standard.nii.gz -w ${path}/reg/example_func2standard_warp.nii.gz
applywarp -i ${path}/stats/cope${n}.nii.gz -o ${path}/stats/cope${n}_standard.nii.gz -r ${path}/reg/example_func2standard.nii.gz -w ${path}/reg/example_func2standard_warp.nii.gz

	



