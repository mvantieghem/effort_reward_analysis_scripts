#!/bin/sh

#SBATCH --account=psych
#SBATCH --job-name=effort_run2_level1
#SBATCH -c 4
#SBATCH --time=11:55:00
#SBATCH --mem-per-cpu=4gb

n=$1

derivatives="/rigel/psych/users/mrv2115/PACCT/Subject_Data/derivatives/"
run1="/effort/model/lev1_run1.feat"
run2="/effort/model/lev1_run1.feat"
run1_fsf="_effort_run1_lev1.fsf"
run2_fsf="_effort_run2_lev1.fsf"

cd /rigel/psych/users/mrv2115/PACCT/scripts/effort_reward/FSL_pipeline/2.preprocessing/lev1_fsfs/

echo "starting effort_reward lev1 run2 for ${n}"
echo $derivatives$n$run2
echo $n$run2_fsf

#if [ ! -d $derivatives$n$run1 ]; then 
	#echo "now I am going to start lev1 run1 processing for ${n}"
	#feat $n$run1_fsf
#fi

#if [ ! -d $derivatives$n$run2 ]; then 
	echo "now I am going to start lev1 run2 processing for $n"
	feat $n$run2_fsf
#fi

echo "finished level1  processing for ${n}"

