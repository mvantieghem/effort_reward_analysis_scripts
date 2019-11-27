#!/bin/bash
# Michelle's script for converting topup scans into magnitude and fieldmap images 
# output files can then be used as input files in B0 unwarping step in FEAT preprocessing 
# used to improve registration and maybe drop out 
# Jan 8, 2019

# NOTES 
#***before running this script, change the date-stamps for the subject lists!!**
# using bet - FSL's default skull strip option.

# get the subject list
#sublist=$(<../../../Sublists/preproc_sublists/sublists_preprocess_2_runs_2019-04-11.txt)

sublist=$(<../../../Sublists/preproc_sublists/sublists_preprocess_Run1_only_2019-04-11.txt)
#sublists_preprocess_Run2_only_2019-04-11.txt

# set the paths you'll need 
for n in $sublist; do 

# navigate to that subjects fmap directory.
fmap_dir="/rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${n}/fmap/"
cd $fmap_dir


# RUN THESE STEPS ***AFTER TOPUP***
# 3) convert to radians
	 fslmaths ${n}_fieldmap -mul 6.28 ${n}_fieldmap_rads

# 4) not sure what this step does 
	 fslmaths ${n}_se_epi_unwarped -Tmean ${n}_fieldmap_mag

# 5) skull strip the magnitude image
	 bet2 ${n}_fieldmap_mag ${n}_fieldmap_mag_brain

# Then you can use the fieldmap and fieldmap magnitude files in FSL Feat.


done
