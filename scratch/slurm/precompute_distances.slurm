#!/bin/bash

#SBATCH --job-name=precompute_distances
#SBATCH --array=0-65                 
#SBATCH --output=precompute_distances_%a.log  
#SBATCH --error=precompute_distances_%a.err   

#SBATCH -p gpu_p
#SBATCH --qos gpu_normal

#SBATCH --nodes=1                                           
#SBATCH --ntasks-per-node=1                                  
#SBATCH --cpus-per-task=16                                   
#SBATCH --mem=8G                                            
#SBATCH --time=12:00:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=1000    

mood_datasets=("DILI" "HIA" "hERG" "HalfLife" "Caco-2" "Clearance" "Pgp" "PPBR" "BBB" "Lipophilicity" "CYP2C9")
mood_representations=("MACCS" "ECFP6" "Desc2D" "WHIM" "ChemBERTa" "Graphormer")

tasks=()
for dataset in "${mood_datasets[@]}"; do
  for representation in "${mood_representations[@]}"; do
    tasks+=("$dataset,$representation")
  done
done

task=${tasks[$SLURM_ARRAY_TASK_ID]}

dataset=$(echo $task | cut -d',' -f1)
representation=$(echo $task | cut -d',' -f2)

echo "Precomputing $dataset $representation distances..."

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/miniconda3/envs/mood-experiments

mood scripts precompute distances --dataset $dataset --representation $representation
