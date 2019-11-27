#!/bin/sh


#SBATCH --account=psych
#SBATCH --job-name=topup
#SBATCH -c 4
#SBATCH --time=04:55:00
#SBATCH --mem-per-cpu=4gb

n=$1

curDir="/rigel/psych/users/mrv2115/PACCT/subject_data/effort_reward/${n}/fmap"

echo "Starting motion correction"
echo "subject is ${n}"
echo "current directory is ${curDir}"

#fsl_motion_outliers -i $boldFile  -o " ${curDir}/motion_assess/confound.txt" --fd --thresh=.9 -s "${curDir}/motion_assess/framewiseDisplacement.txt"  -p "${curDir}/motion_assess/fd_plot" -v > "${curDir}/motion_assess/outlier_output.txt"
topup --imain=${curDir}/se_epi_merged.nii.gz --datain=datain.txt --config=b02b0.cnf --fout=${curDir}/${n}_fieldmap --iout=${curDir}/${n}_se_epi_unwarped
