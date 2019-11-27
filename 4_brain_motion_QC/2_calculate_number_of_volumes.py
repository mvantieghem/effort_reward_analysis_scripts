#!/usr/bin/python
# script for calculating total number of BOLD volumes for each scan
# Makes an output text file in 2_motion/numVols.txt
# Author: PAB - updated by MVT
# Date: Feb 23, 2018

# script from Paul's github to calculate nvols! 

import glob
import os
import sys
import subprocess

path = '/danl/PACCT/subject_data/derivatives/effort_reward/'

numVolsList =  '/danl/PACCT/scripts/effort_reward/FSL_pipeline/1.motion_assess/NumVols.txt'
tmpVolsList =  '/danl/PACCT/scripts/effort_reward/FSL_pipeline/1.motion_assess/tmpVols.txt'

 
# get the paths for each BOLD.nii file 
bold_files = glob.glob('%s/*/effort/BOLD/run*/*.nii.gz'%(path))
print (bold_files)

# remove old version (otherwise it will append!!)
os.system("rm Effort_scans_numVols_per_run.txt") 

# loop through each directory for each bold.nii file - this is just going to show me my BOLD files
for cur_bold in list(bold_files):
    print(cur_bold)

    # Store directory name
    cur_dir = os.path.dirname(cur_bold)

    # For each iteration of loop, save subject info into temp.txt
    os.system("echo %s > temp.txt" %(cur_bold))

    # Run fslnvols and save # of TRs for subject into tmpVolsList file
    os.system("fslnvols %s > %s" %(cur_bold, tmpVolsList))


    # Paste temp.txt and tmpVols.txt together as 2 columns and append to numVols.txt file
    os.system("paste temp.txt tmpVols.txt >> data/Effort_scans_numVols_per_run.txt") 

    # Remove temp files...this should stop the script from writing the wrong subject's info if something fails
    os.system("rm /danl/PACCT/scripts/effort_reward/FSL_pipeline/1.motion_assess/tmpVols.txt")
    os.system("rm /danl/PACCT/scripts/effort_reward/FSL_pipeline/1.motion_assess/temp.txt")
