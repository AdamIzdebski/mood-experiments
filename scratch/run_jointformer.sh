#bin/bash

mood scripts compare performance \
  --base-save-dir /home/adamizdebski/files/results/mood-experiments/ \
  --overwrite \
  --n-seeds 2 \
  --n-trials 2 \
  --n-startup-trials 2 \
  MLP \
  Jointformer \
  Lipophilicity
