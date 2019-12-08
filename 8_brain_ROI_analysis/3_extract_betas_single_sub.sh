#!/bin/bash 
# Michelle's script 

# get list of files we already created with everyone's copes in standard sapce (combined from subjs with 1 or 2 runs)
# updated July 22, 2019 to only include N = 121 (not N = 125) - this was excluding extreme reinforce subjs
# updated August 14, 2019 to include N126 for all subjects, adding PA257 who was missing.
# august 19 - running for choice contrast
# December 5 - re-run for complete EVS with N127 because PA255 added! 

version= "basic_copes" # hard_FB_contrast_copes, choice_contrast_copes
basic_cope_list="cope15RewardFB cope16SetbackFB cope17Reward-SetbackFB cope10allChoices"
choice_contrast_cope_list="cope1HardChoice cope2EasyChoice cope11Hard-EasyChoice "
hard_FB_contrast="cope5HardReward cope6HardSetback cope21HardReward-HardSetback "

ROI_list="choice_ACC choice_mPFC FB_mPFC FB_vmPFC Left_Amygdala_50thr_bin Right_Amygdala_50thr_bin Left_Accumbens_50thr_bin Right_Accumbens_50thr_bin Ventral_Striatum_50thr_bin"
ROI_path="ROIs/"

#mkdir pulled_betas/${version}/

# for the 6 contrast files 
for cope_contrast in $cope_list; do
	 
	 # read the input files for that contrast
	while read SUBJECTID file; do 

  	#fslmeants takes the data from files with a mask. 
		#-m is the path for the mask 
		#-o output file! 
		# -i is your input files

		for ROI_mask in $ROI_list; do
			# get the betas from each ROI for each subject for each cope file 
			echo "getting betas for  ${SUBJECTID} ${cope_contrast} ${ROI_mask}"
			fslmeants -i ${file} -m ${ROI_path}${ROI_mask} -o pulled_betas/${version}/${cope_contrast}/${SUBJECTID}_${ROI_mask}_${cope_contrast}_betas.txt 
		done
	done < "/danl/PACCT/scripts/effort_reward/analysis_scripts/8_brain_ROI_analysis/cope_input_files/${cope_contrast}_input_files.txt"
done
