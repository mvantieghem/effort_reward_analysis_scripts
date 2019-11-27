#!/bin/sh

#SBATCH --account=psych
#SBATCH --job-name=effort_run1_level1
#SBATCH -c 4
#SBATCH --time=11:55:00
#SBATCH --mem-per-cpu=4gb

SUBJECTID=$1
RunNumber=$2

derivatives="/rigel/psych/users/mrv2115/PACCT/subject_data/"


## IMPT NOTE: there are 4 level1 model variants 
## folder name will change 
cd /rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/FSL_pipeline/3.level1_by_run/lev1_fsfs/

echo "starting effort_reward for ${SUBJECTID}"
 
#	echo "now I am going to start lev1 processing for all EVs: ${SUBJECTID} ${RunNumber}"
#	feat with_missed_all_EVs/${SUBJECTID}_effort_${RunNumber}_lev1.fsf 
	echo "now I am going to start lev1 processing for collapsed EVs: ${SUBJECTID} ${RunNumber}"
	feat with_missed_collapsed_EVs/${SUBJECTID}_effort_${RunNumber}_lev1.fsf
	

#if [ ! -d $derivatives$n$run2 ]; then 
#	echo "now I am going to start lev1 run2 processing for $n"
#	feat $n$run2_fsf
#fi

echo "finished level1  processing for ${n}"

