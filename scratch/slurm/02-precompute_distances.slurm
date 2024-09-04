#!/bin/bash

#SBATCH --job-name=precompute_distances
#SBATCH --array=0-10                 
#SBATCH --output=precompute_distances_%a.log  
#SBATCH --error=precompute_distances_%a.err   

#SBATCH -p gpu_p
#SBATCH --qos gpu_normal
                                 
#SBATCH --cpus-per-task=16                                   
#SBATCH --mem=24G                                            
#SBATCH --time=12:00:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=100    

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/miniconda3/envs/mood-experiments


datasets=("DILI" "HIA" "hERG" "HalfLife" "Caco-2" "Clearance" "Pgp" "PPBR" "BBB" "Lipophilicity" "CYP2C9")
representations=("UniMol")

tasks=()
for dataset in "${datasets[@]}"; do
  for representation in "${representations[@]}"; do
    tasks+=("$dataset,$representation")
  done
done

task=${tasks[$SLURM_ARRAY_TASK_ID]}

dataset=$(echo $task | cut -d',' -f1)
representation=$(echo $task | cut -d',' -f2)

echo "Precomputing $dataset $representation distances..."
mood scripts precompute distances --dataset $dataset --representation $representation

echo "Precomputing $dataset $representation distances finished!"
