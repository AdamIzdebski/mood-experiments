#bin/bash

mood scripts precompute representation virtual_screening Jointformer --n-jobs 4 --verbose
mood scripts precompute representation optimization Jointformer --n-jobs 4 --verbose

mood scripts precompute distances --dataset Lipophilicity --representation Jointformer

mood scripts compare performance \
  MLP RF GP\
  Jointformer \
  Lipophilicity
