#!/bin/bash
# Michelle's scripts for converting topup scans into magnitude and fieldmap images 
# output files can then be used as input files in B0 unwarping step in FEAT preprocessing 
# used to improve registration and maybe drop out 
# Jan 8, 2019

# NOTES 
# this script only performs first 2 steps! 
# merges PA + AP scans, and then runs top-up with sbatch (because top-up takes forever)
# final steps are in next script: 4D_prep_topup_output_for_FEAT.sh

# get the subject list
sublist=$(</rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/FSL_pipeline/Sublists/sublists_July2018/sublist_scans_2019-01-08.txt)
# subjects PA254 and PA034 DID NOT COLLECT FIELDMAPSy

# set the paths you'll need 

for n in $sublist; do 

# navigate to that subjects fmap directory.
fmap_dir="/rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${n}/fmap/"
#cd $fmap_dir

# copy datain file needed for topup (see more info below)
topup_data_input_file="/rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/FSL_pipeline/0.set_up_scripts/topup_datain.txt"
#cp $topup_data_input_file $fmap_dir

# 1) merge AP and PA
		 fslmerge -t ${fmap_dir}se_epi_merged ${fmap_dir}${n}_topup_AP ${fmap_dir}${n}_topup_PA 

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
		
    # topup --imain=${fmap_dir}se_epi_merged.nii.gz --datain=topup_datain.txt --config=b02b0.cnf --fout=${fmap_dir}${n}_fieldmap --iout=${fmap_dir}${n}_se_epi_unwarped

    #**** RUN WITH SBATCH ON HABANERO TO EXPEDIATE ***
   	sbatch -o ${n}-topup-%j.out -e ${n}-topup-%j.err 4C_HABA_submit_topup.sh $n 

done
