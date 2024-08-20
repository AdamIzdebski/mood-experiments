#bin/bash

mood scripts precompute distances --dataset Lipophilicity --representation Jointformer

mood scripts compare performance \
  MLP RF GP\
  Jointformer \
  Lipophilicity
