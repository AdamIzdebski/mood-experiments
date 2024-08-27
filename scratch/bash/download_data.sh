#!/bin/bash

mood_datasets=("DILI" "HIA" "hERG" "HalfLife" "Caco-2" "Clearance" "Pgp" "PPBR" "BBB" "Lipophilicity" "CYP2C9")

for dataset in "${mood_datasets[@]}"; do
    python3 scripts/download_data.py --dataset $dataset
done


