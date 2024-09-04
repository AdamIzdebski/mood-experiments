import datamol as dm


ROOT_DIR = '/lustre/groups/aih/jointformer/results/mood-experiments'
DATA_DIR = "/lustre/groups/aih/jointformer/data/data"

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
JOINTFORMER = 'jointformer-separate-task-token'
PRETRAINED_JOINTFORMER_DIR = f"{ROOT_DIR}/pretrained/{JOINTFORMER}/"
PRETRAINED_JOINTFORMER_PATH = f"{PRETRAINED_JOINTFORMER_DIR}/ckpt.pt"
PRETRAINED_JOINTFORMER_MODEL_CONFIG = f"{PRETRAINED_JOINTFORMER_DIR}/model_config"
PRETRAINED_JOINTFORMER_TOKENIZER_CONFIG = f"{PRETRAINED_JOINTFORMER_DIR}/tokenizer_config"
PRETRAINED_JOINTFORMER_VOCAB_PATH = f"{PRETRAINED_JOINTFORMER_DIR}/vocabulary/vocab.txt"

PRETRAINED_UNIMOL_DIR = f"{ROOT_DIR}/pretrained/unimol/"
PRETRAINED_UNIMOL_PATH = f"{PRETRAINED_UNIMOL_DIR}/ckpt.pt"
PRETRAINED_UNIMOL_MODEL_CONFIG = f"{PRETRAINED_UNIMOL_DIR}/model_config"
