#!/usr/bin/python
# Mumford Brain stats script for generating lev1 feat script(.fsf) for each subject
# Michelle updated for effort task on Jan 12 2018 
# This script will generate  design.fsf for each subject for each run
# script #3 will run these fsf files 


#********** STOP! BEFORE YOU RUN THIS SCRIPT ************
# 1. make a template fsf with a single run from a single subject.
# Run feat & make sure it completes without error.

#2. open your template fsf (using nedit)  
# replace PA001 with SUBNUM 
# replace run1 with RUNUNUM 
# replace 375 TRs to TRNUM (in case subjects have a shortened scan time)

# this script will then use those wildcards to generate an fsf with each subject's number and run numbers.

#3. you need to make an lev1_fsfs folder inside your 2.preprocessing directory. 
#this folder will store all files generated in this script in one place

# import these specific packages that we will need later
import os
import glob

# Set this to the directory all of the sub### directories live in

studydir = '/danl/PACCT'

# Set this to the directory where you'll dump all the fsf files
# May want to make it a separate directory, because you can delete them all o
#   once Feat runs
fsfdir="%s/scripts/effort_reward/FSL_pipeline/3.level1_by_run/"%(studydir)

# Get all the paths!  Note, this won't do anything special to omit bad subjects
# note - this is different because it's not a loop 
# also useful when subjects don't have the same number of runs! 
subdirs = glob.glob("%s/Subject_Data/derivatives/PA[0-9][0-9][0-9]/effort/BOLD/run[1-2]/"%(studydir))

# loop goes through subdirectories 
# split directory according to the / 
for dir in list(subdirs):
  splitdir = dir.split('/')
  # YOU WILL NEED TO EDIT THIS TO GRAB SUBJECT NUMBER ID FROM YOUR BOLD PATH 
  subnum = splitdir[5]
  #  YOU WILL ALSO NEED TO EDIT THIS TO GRAB THE RUN NUMBER FROM YOUR BOLD PATH(1,2,3)
  runnum = splitdir[8]

  print(subnum, runnum)
  
  # getting the number of time points (volumes) that exist in your data
  # this is useful in case you have subjects with runs that don't all have the same TR (aka they stopped scan early)
  ntime = os.popen('fslnvols %s/%s_task-effort-%s_bold.nii.gz'%(dir, subnum, runnum)).read().rstrip()
  
  # these are the wildcards that must be in your template fsf script.  
  # this will replace these wilcards with subject ID, run number, and TR number. 
  replacements = {'SUBNUM':subnum, 'TRNUM':ntime, 'RUNNUM':runnum}
  # get your template as the input here -*** multiple versions REPLACE HERE****
  with open("%stemplate_lev1_fsf/HABA_effort_lev1_no_missed_all_EVs.fsf"%(fsfdir)) as infile: 
 
  # outfile = useable fsf file that is being created for every subject and every run 
  # lsit path to save these files *** multiple versions REPLACE HERE****
    with open("%slev1_fsfs/no_missed_all_EVs/%s_%s_HABA_effort_lev1_no_missed_all_EVs.fsf"%(fsfdir, subnum, runnum), 'w') as outfile:
        for line in infile:
          # This code will make new fsf files that replace all of the wild cards we made above!  
          for src, target in replacements.items():
	 
            line = line.replace(src, target)
          outfile.write(line)
	
