#!/bin/bash

#SBATCH --job-name=precompute_representations
#SBATCH --array=0-1                 
#SBATCH --output=precompute_representations_%a.log  
#SBATCH --error=precompute_representations_%a.err   

#SBATCH -p gpu_p
#SBATCH --qos gpu_normal

#SBATCH --nodes=1                                           
#SBATCH --ntasks-per-node=1                                  
#SBATCH --cpus-per-task=12                                   
#SBATCH --mem=8G                                            
#SBATCH --time=06:00:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=1000                            

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

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/tools/apps/mamba/envs/mood-jointformer

mood scripts precompute representation $downstream_task $representation --n-jobs $SLURM_CPUS_PER_TASK --verbose
