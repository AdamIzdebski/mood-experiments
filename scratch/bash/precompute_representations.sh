#bin/bash

mood_datasets=("DILI", "HIA", "hERG", "HalfLife", "Caco-2", "Clearance", "Pgp", "PPBR", "BBB", "Lipophilicity", "CYP2C9")

dataset=${mood_datasets[$SLURM_ARRAY_TASK_ID]}
echo "Precomputing $dataset representations..."


# mood scripts precompute representation virtual_screening Jointformer --n-jobs $SLURM_CPUS_PER_TASK --verbose
# mood scripts precompute representation optimization Jointformer --n-jobs $SLURM_CPUS_PER_TASK --verbose


# # Create a list of combinations
# combinations=()
# for split in "${splits[@]}"; do
#   for target in "${targets[@]}"; do
#     combinations+=("$split,$target")
#   done
# done

# # Get the specific combination for this job
# combination=${combinations[$SLURM_ARRAY_TASK_ID]}
# split=$(echo $combination | cut -d',' -f1)
# target=$(echo $combination | cut -d',' -f2)

# # Modify the split name if needed
# if [ "$split" == "train" ] && [ "$target" == "guacamol_mpo" ]; then
#   split="train/10000/seed_0"
# fi
