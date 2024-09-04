#!/bin/bash

#SBATCH --job-name=precompute_representations
#SBATCH --array=0-1                 
#SBATCH --output=precompute_representations_%a.log  
#SBATCH --error=precompute_representations_%a.err   

#SBATCH -p gpu_p
#SBATCH --qos gpu_normal
                                
#SBATCH --cpus-per-task=12                                   
#SBATCH --mem=24G                                            
#SBATCH --time=02:30:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=1000                            

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/miniconda3/envs/mood-jointformer


downstream_tasks=("virtual_screening" "optimization")
representations=("Jointformer")

tasks=()
for downstream_task in "${downstream_tasks[@]}"; do
  for representation in "${representations[@]}"; do
      tasks+=("$downstream_task,$representation")
  done
done

task=${tasks[$SLURM_ARRAY_TASK_ID]}
downstream_task=$(echo $task | cut -d',' -f1)
representation=$(echo $task | cut -d',' -f2)

echo "Precomputing $representation representations for $downstream_task..."
mood scripts precompute representation $downstream_task $representation --n-jobs $SLURM_CPUS_PER_TASK --verbose --override
