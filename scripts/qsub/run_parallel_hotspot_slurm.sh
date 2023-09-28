#!/bin/bash
#SBATCH --job-name=PDB2HOTSPOT
#SBATCH --output=slog_%A_%a.out
#SBATCH --error=slog_%A_%a.err
#SBATCH --array=1-1000%500
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --partition=batch

hostname
date
split_dir=$1
num_sim=$2
radius=$3
out_dir=$4
echo "python hotspot.py --log-level=INFO \
    -m $split_dir/mut_info_split_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -a $split_dir/pdb_info_split_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -t EVERY \
    -n $num_sim \
    -r $radius \
    -o $out_dir/data/hotspot/full_output/output_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -e $out_dir/error/error_pdb_$((SLURM_ARRAY_TASK_ID-1)).txt \
    --log=stdout "
source /work/renshuaibing/software/miniconda3/etc/profile.d/conda.sh && conda activate driverMutation && python hotspot.py --log-level=INFO \
    -m $split_dir/mut_info_split_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -a $split_dir/pdb_info_split_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -t EVERY \
    -n $num_sim \
    -r $radius \
    -o $out_dir/data/hotspot/full_output/output_$((SLURM_ARRAY_TASK_ID-1)).txt \
    -e $out_dir/error/error_pdb_$((SLURM_ARRAY_TASK_ID-1)).txt \
    --log=stdout
date
