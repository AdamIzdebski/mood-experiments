import datamol as dm


ROOT_DIR = '/home/adamizdebski/files/mood-experiments'
"""
Where results and data are saved to
"""
CACHE_DIR = dm.fs.get_cache_dir("MOOD")

"""
For the downstream applications (optimization and virtual screening)
we save all related data to this directory
"""
DOWNSTREAM_APPS_DATA_DIR = f"{ROOT_DIR}/downstream_applications/"

"""
Where the results of MOOD are saved
"""
RESULTS_DIR = f"{ROOT_DIR}/results/"

"""
The two downstream applications we consider for MOOD as application areas of molecular scoring
"""
SUPPORTED_DOWNSTREAM_APPS = ["virtual_screening", "optimization"]

"""
Where data related to specific datasets is saved
"""
DATASET_DATA_DIR = f"{ROOT_DIR}/datasets/"


"""The number of epochs to train NNs for"""
NUM_EPOCHS = 100

"""
Path to pre-trained jointformer ckpt
"""
PRETRAINED_JOINTFORMER_PATH = f"/home/adamizdebski/files/results/jointformer/ckpt.pt"
