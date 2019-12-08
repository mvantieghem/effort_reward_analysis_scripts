#!/usr/bin/python

# This creates the level1 fsf's and the script to run the feats on condor

import os
import glob

studydir = '/danl/PACCT'

fsfdir="%s/scripts/effort_reward/FSL_pipeline/4.level2_combine_runs/"%(studydir)
print (fsfdir)

subdirs=glob.glob("%s/subject_data/derivatives/effort_reward/PA[0-9][0-9][0-9]/effort/"%(studydir))
print (subdirs)

for dir in list(subdirs):
  splitdir = dir.split('/')
  subnum = splitdir[6]  # You will need to edit this
 # subnum=splitdir_sub[-3:]    # You also may need to edit this 
  print(dir)
  print(subnum)
 
  # now get the feat directories for lev1 and count them
  subfeats=glob.glob("%s/model/preproc_run[0-2].feat"%(dir))
  print (len(subfeats))
  # make lev2 fsf based on how many feat dir inclufed 
  # change this manually for whether they should be run1 and 3 or run2 and 3
 
  # these are the wildcards that must be in your template fsf script.  
  # this will replace these wilcards with subject ID, run number, and TR number. 
  # note: for habanero version, we are also changing the paths to the data and FSL!
  replacements = {'SUBNUM':subnum} 

# if running on HABANERO: 
 #habanero_path= '/rigel/psych/users/mrv2115/'
  #fsl_path='/rigel/psych/app/fsl/'
   #replacements = {'SUBNUM':subnum,'/danl/':habanero_path, '/usr/share/fsl/5.0': fsl_path}
  
 
#  with open("%s/template_lev2_fsf/choice_contrast_EVs_2runs.fsf"%(fsfdir)) as infile: 
 #   with open("%s/lev2_fsfs/choice_contrast_EVs/%s_effort_lev2_collapsed_EVs_2runs.fsf"%(fsfdir, subnum), 'w') as outfile:
	 
  #        for line in infile:
            
   #         for src, target in replacements.iteritems():
    #          print("makingfsf")
     #         line = line.replace(src, target)
      #      outfile.write(line)
            
            
  with open("%s/template_lev2_fsf/hard_FB_contrast_EVs_2runs.fsf"%(fsfdir)) as infile: 
    with open("%s/lev2_fsfs/hard_FB_contrast_EVs/%s_effort_lev2_all_EVs_2runs.fsf"%(fsfdir, subnum), 'w') as outfile:
	 
          for line in infile:
            
            for src, target in replacements.iteritems():
              print("makingfsf")
              line = line.replace(src, target)
            outfile.write(line)

