#!/bin/bash

#SBATCH --job-name=compare_performance
#SBATCH --array=0-2                 
#SBATCH --output=compare_performance_%a.log  
#SBATCH --error=compare_performance_%a.err   

#SBATCH -p gpu_p
#SBATCH --qos gpu_normal
                                
#SBATCH --cpus-per-task=16                                   
#SBATCH --mem=24G                                            
#SBATCH --time=16:00:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=100                         


datasets=("Lipophilicity")
representations=("UniMol")
baselines=("MLP" "RF" "GP")

tasks=()
for dataset in "${datasets[@]}"; do
  for representation in "${representations[@]}"; do
    for baseline in "${baselines[@]}"; do
      tasks+=("$dataset,$representation,$baseline")
    done
  done
done

task=${tasks[$SLURM_ARRAY_TASK_ID]}

dataset=$(echo $task | cut -d',' -f1)
representation=$(echo $task | cut -d',' -f2)
baseline=$(echo $task | cut -d',' -f3)

echo "Comparing performance of $baseline for $representation representations on $dataset dataset..."

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/miniconda3/envs/mood-experiments

mood scripts compare performance $baseline $representation $dataset
