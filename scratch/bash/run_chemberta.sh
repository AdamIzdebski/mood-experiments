#bin/bash

# mood scripts precompute representation virtual_screening Jointformer --n-jobs 4 --verbose
# mood scripts precompute representation optimization Jointformer --n-jobs 4 --verbose

# mood scripts precompute distances --dataset Lipophilicity --representation Jointformer

mood scripts compare performance MLP ChemBERTa Lipophilicity

mood scripts compare performance RF ChemBERTa Lipophilicity

mood scripts compare performance GP ChemBERTa Lipophilicity
