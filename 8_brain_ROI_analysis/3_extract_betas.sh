#!/bin/bash 
# Michelle's script 

# get list of files we already created with everyone's copes in standard sapce (combined from subjs with 1 or 2 runs)
# updated August 14, 2019 to include N126 for all subjects, adding PA257 who was missing.

# first, ew are doing collapsed EV model 
cope_list="cope1choice cope2easy cope3FB cope4effort cope5easy_hard cope6hard_easy"
ROI_list="choice_ACC choice_mPFC FB_mPFC FB_vmPFC Left_Amygdala_50thr_bin Right_Amygdala_50thr_bin Left_Accumbens_50thr_bin Right_Accumbens_50thr_bin Ventral_Striatum_50thr_bin"
ROI_path="/danl/PACCT/scripts/effort_reward/FSL_pipeline/ROIs/"


for cope_contrast in $cope_list; do
  
	 # echo "merging $cope_contrast"
	  
	  # note: extracting betas for ALL SUBJECTS in one script, separate later! 
	  subfiles=$(<choice_contrast_EVs/ROI_results/cope_input_files/${cope_contrast}_group_level_input_files_choice_contrast_EVs.txt)
	  
	  #fslmerge combines images into a single file 
	  # -t means we are making a 4D imag
	 # echo "$subfiles"
	  echo "$cope_contrast"
	  # -o is output, -i is input
	  fslmerge -t choice_contrast_EVs/ROI_results/allsubs_merged_copes/${cope_contrast} ${subfiles}
  
  	#fslmeants takes the data from files with a mask. 
		#-m is the path for the mask 
		#-o output file! 
		# -i is your input files
	for ROI_mask in $ROI_list; do
		
		echo "getting betas for ${ROI_mask}"

#		fslmeants -i choice_contrast_EVs/ROI_results/allsubs_merged_copes/${cope_contrast} -m ${ROI_path}${ROI_mask} -o choice_contrast_EVs/ROI_results/pulled_betas/N126_all_usable_subj/${cope_contrast}_${ROI_mask}_betas 

	done
done
