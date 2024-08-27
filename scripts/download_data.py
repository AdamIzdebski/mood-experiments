import argparse

from scripts.compare_performance import load_data_from_tdc


def parse_args():
    parser = argparse.ArgumentParser(description='Download data from the web')
    parser.add_argument('--dataset', type=str, help='TDC dataset to download', required=True)
    return parser.parse_args()


def main(args):
    print(f'Downloading dataset {args.dataset}...')
    _ = load_data_from_tdc(args.dataset)

    
if __name__ == '__main__':
    args = parse_args()
    main(args)
