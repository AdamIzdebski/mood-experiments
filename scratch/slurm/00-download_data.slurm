#!/bin/bash

#SBATCH --job-name=download_data     
#SBATCH --output=download_data.log  
#SBATCH --error=download_data.err   

#SBATCH -p cpu_p
#SBATCH --qos cpu_normal
                             
#SBATCH --cpus-per-task=16                                   
#SBATCH --mem=8G                                            
#SBATCH --time=01:00:00                                    

#SBATCH --mail-type=begin                                   
#SBATCH --mail-type=end                                     
#SBATCH --mail-type=fail                                    
#SBATCH --mail-user=adam.izdebski@helmholtz-munich.de

#SBATCH --nice=1000    

mood_datasets=("DILI" "HIA" "hERG" "HalfLife" "Caco-2" "Clearance" "Pgp" "PPBR" "BBB" "Lipophilicity" "CYP2C9")

source $HOME/.bashrc

conda deactivate
conda activate /home/aih/adam.izdebski/miniconda3/envs/mood-experiments

for dataset in "${mood_datasets[@]}"; do
    echo "Downloading $dataset data..."
    srun python3 scripts/download_data.py --dataset $dataset
done
