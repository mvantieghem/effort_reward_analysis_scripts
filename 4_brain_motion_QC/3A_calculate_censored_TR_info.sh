#!/bin/tcsh
# Michelle's script for getting summaries of your motion data 

# set up for the first time you run this... 
#cd /danl/PACCT/scripts/effort_reward/FSL_pipeline/Sublists/
#mkdir censored_TRs#
#mkdir QA_motion_general
#sublist='../../Sublists/preproc_sublists/sublist_scans_2019-04-10.txt'


## run a loop through each subject to grab the motion info and save it into better format.

foreach n(PA257)
#foreach n (PA081 PA119 PA148 PA149 PA150 PA156 PA157 PA184 PA228 PA229 PA243 PA244 PA255 PA256 PA265 PA268 PA279)
echo "${n}"
# for each run of the task
foreach r (run1 run2)

# if they don't have the folder for motion - mark them to go back and make them! 
if (! -d /danl/PACCT/subject_data/derivatives/effort_reward/${n}/effort/BOLD/${r}/motion_assess) then
	echo "no BOLD or motion_assess folder for ${n} ${r}"
else 

# go to their motion folder 
cd /danl/PACCT/subject_data/derivatives/effort_reward/${n}/effort/BOLD/${r}/motion_assess

# copy the outlier output and rename with SB and run number 
# put into your main QA directory for later reference
cp /danl/PACCT/subject_data/derivatives/effort_reward/${n}/effort/BOLD/${r}/motion_assess/outlier_output.txt /danl/PACCT/scripts/effort_reward/FSL_pipeline/1.motion_assess/QA_motion_general/${n}_${r}_outlier_output.txt

# pull out the number of TRs censored for each run based on FD threshold
# you do this by using grep to pull out the number from "Found XX outliers"
# pull those numbers into one single text file for that subject 

echo "get motion info for ${n} ${r}" 

cat -n outlier_output.txt | grep -o -P '(?<=Found).*(?=outliers)' >> /danl/PACCT/subject_data/derivatives/effort_reward/${n}/effort/BOLD/${r}/motion_assess/censored_TR.txt

endif
end 
end

