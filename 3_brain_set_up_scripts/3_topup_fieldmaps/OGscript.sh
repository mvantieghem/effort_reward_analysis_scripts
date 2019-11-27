#!/bin/bash
# Michelle's script for converting topup scans into magnitude and fieldmap images 
# output files can then be used as input files in B0 unwarping step in FEAT preprocessing 
# used to improve registration and maybe drop out 
# Jan 8, 2019

# NOTES 
#***before running this script, change the date-stamps for the subject lists!!**
# using bet - FSL's default skull strip option.

# get the subject list
#sublist=$(</danl/PACCT/scripts/effort_reward/FSL_pipeline/Sublists/sublists_July2018/sublist_scans_2019-01-08.txt)
sublist="PA193" # also test PA175
# set the paths you'll need 

for n in $sublist; do 

# navigate to that subjects fmap directory.
fmap_dir="/danl/PACCT/subject_data/effort_reward/${n}/fmap/"
cd $fmap_dir

# copy datain file needed for topup (see more info below)
#topup_data_input_file="/danl/PACCT/scripts/effort_reward/FSL_pipeline/0.set_up_scripts/topup_datain.txt"
#cp $topup_data_input_file $fmap_dir

# 1) merge AP and PA
	#	 fslmerge -t se_epi_merged ${n}_topup_AP ${n}_topup_PA 

# 2) run top up itself to get a fieldmap image and magnitude image
		# Imain = filename 
		# Datain= text file with information about acquisition of images
			# First 3 columns specify direction of phase-encoding
			# Fourth value is the total readout time in seconds. if it is identical for all acquisitions, you DON’T have to specify a value in this column - set to 1 instead.
			# For AP and PA files: 
				# 0 1 0 1 (AP) x 3 (because it was acquired 3 times)
				# 0 -1 0 1 (PA) x 3 (because it was acquired 3 times)
		# Config = don't need to find or copy from anywhere! 
	    	# use predefined config file from FSL: b02b0.cnf 
		# Fout = off-resonance field (fieldmap itself)
		# Iout = converted unwarped images(magnitude image)
# topup --imain=se_epi_merged.nii.gz --datain=topup_datain.txt --config=b02b0.cnf --fout=${n}_fieldmap --iout=${n}_se_epi_unwarped

# 3) convert to radians
	 fslmaths ${n}_fieldmap -mul 6.28 ${n}_fieldmap_rads

# 4) not sure what this step does 
	 fslmaths ${n}_se_epi_unwarped -Tmean ${n}_fieldmap_mag

# 5) skull strip the magnitude image
	 bet2 ${n}_fieldmap_mag ${n}_fieldmap_mag_brain

# Then you can use the fieldmap and fieldmap magnitude files in FSL Feat.


done