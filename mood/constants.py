import datamol as dm


"""
Where results and data are saved to
"""
CACHE_DIR = dm.fs.get_cache_dir("MOOD")

"""
For the downstream applications (optimization and virtual screening)
we save all related data to this directory
"""
DOWNSTREAM_APPS_DATA_DIR = "gs://experiments-output/mood-v2/downstream_applications/"

"""
Where the results of MOOD are saved
"""
DOWNSTREAM_RESULTS_DIR = "gs://experiments-output/mood-v2/results/"

"""
The two downstream applications we consider for MOOD as application areas of molecular scoring
"""
SUPPORTED_DOWNSTREAM_APPS = ["virtual_screening", "optimization"]

