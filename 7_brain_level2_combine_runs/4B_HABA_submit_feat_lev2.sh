#!/bin/sh

#SBATCH --account=psych
#SBATCH --job-name=effort_run1_level1
#SBATCH -c 4
#SBATCH --time=11:55:00
#SBATCH --mem-per-cpu=4gb

SUBJECTID=$1

derivatives="/rigel/psych/users/mrv2115/PACCT/subject_data/"


## IMPT NOTE: there are 4 level1 model variants 
## folder name will change 
cd /rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/FSL_pipeline/4.level2_combine_runs/lev2_fsfs/

#	rm -r /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/lev2_collapsed_EVs*
#	echo "now I am going to start lev2 processing for collapsed EVs: ${SUBJECTID}"

# copy registration 
#cp -r /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/preproc_run1.feat/reg*/ /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/lev1_run1_collapsed_EVs.feat/
#cp -r /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/preproc_run2.feat/reg*/ /rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${SUBJECTID}/effort/model/lev1_run2_collapsed_EVs.feat/


# run feat
echo "${SUBJECTID}"
feat ${SUBJECTID}_effort_lev2_complete.fsf

