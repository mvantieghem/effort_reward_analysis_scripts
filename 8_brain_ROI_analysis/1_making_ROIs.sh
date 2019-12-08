#!/bin/bash 

# make ROIs from peak coordinates of neurosynth (choice / neg fb)

ROI_path="/danl/PACCT/scripts/effort_reward/FSL_pipeline/ROIs/"
MNI_template="/usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz"

## contrast: choice association-test z FDR 0.01 
# ACC ROI
# MNI space: 3, 30, 38
# FSL voxel space: 43, 78, 55

# make a point ROI at this coordinate set 
#fslmaths ${ROI_path}template_MNI -mul 0 -add 1 -roi 43 1 78 1 55 1 0 1 ${ROI_path}choice_ACC -odt float 
# next, make a sphere around that point that is 5 mm radius
#fslmaths ${ROI_path}choice_ACC -kernel sphere 5 -fmean ${ROI_path}choice_ACC -odt float

## contrast: choice association-test z FDR 0.01 

# mPFC ROI
# MNI SPACE: -2, 38, -16
# FSL voxel space: 46, 82, 28

# make a point ROI at this coordinate set (FSL)
#fslmaths ${ROI_path}template_MNI -mul 0 -add 1 -roi 46 1 82 1 28 1 0 1 ${ROI_path}choice_mPFC -odt float 
# next, make a sphere around that point that is 5 mm radius
#fslmaths ${ROI_path}choice_mPFC -kernel sphere 5 -fmean ${ROI_path}choice_mPFC -odt float


## second contrast: negative feedback association test z FDR 0.01 
# mPFC ROI 
# MNI space: -3, 48, 2
# FSL voxel space: 47, 87, 37

# make a point ROI at this coordinate set (FSL)
#fslmaths ${ROI_path}template_MNI -mul 0 -add 1 -roi 47 1 87 1 37 1 0 1 ${ROI_path}FB_mPFC -odt float 
# next, make a sphere around that point that is 5 mm radius
#fslmaths ${ROI_path}FB_mPFC -kernel sphere 5 -fmean ${ROI_path}FB_mPFC -odt float

# make ROI from delgado's MNI coordinates for VmPFC to setbacks: 
# MNI space:  -10, 44, -6
# FSL voxel space: 50, 85, 33

#fslmaths ${ROI_path}template_MNI -mul -0 -add 1 -roi 50 1 85 1 33 1 0 1 ${ROI_path}FB_vmPFC -odt float
#fslmaths ${ROI_path}FB_vmPFC -kernel sphere 5 -fmean ${ROI_path}FB_vmPFC -odt float

# Now update your harvard oxford ROIs

ROI_list='Left_Accumbens Right_Accumbens Right_Amygdala Left_Amygdala Ventral_Striatum'
for ROI in $ROI_list; do
  fslmaths ${ROI_path}${ROI} -thr 50 -bin ${ROI_path}${ROI}_50thr_bin
  
done
  
