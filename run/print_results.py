import argparse
import os
import glob
import codecs
import datetime


def get_training_time(path):
    training = False
    pre_line = ""
    target_start = (
        " - mmcv - INFO - Reducer buckets have been rebuilt in this iteration."
    )
    target_end = " - mmdet - INFO - "
    with codecs.open(path, "r", "utf-8", "ignore") as f:
        lines = f.readlines()
        for line in lines:
            if not training and target_start in line:
                dt1 = line
                training = True
            elif training and target_end not in line:
                dt2 = pre_line
                break
            pre_line = line
    # print(dt1)
    # print(dt2)

    dt1 = dt1.split(",")[0]
    dt2 = dt2.split(",")[0]
    dt1 = datetime.datetime.strptime(dt1, "%Y-%m-%d %H:%M:%S")
    dt2 = datetime.datetime.strptime(dt2, "%Y-%m-%d %H:%M:%S")
    td = dt2 - dt1
    return td


def training_info(args):
    files = glob.glob(f"{args.dir_trainlogs}/*.out")

    for key in args.keys:
        print(key, end="\t")
    print("file")

    for f in files:
        f_basename = os.path.basename(f)
        for key in args.keys:
            print(eval(f"get_{key}")(f), end="\t")
        print(f_basename)


def get_NDS(path):
    # print(path)
    with codecs.open(path, "r", "utf-8", "ignore") as f:
        lines = f.readlines()
        for line in lines:
            if "NDS:" in line:
                nds = line.replace(" ", "").replace("\n", "").split(":")
                # ['NDS', '0.5121']
                nds = nds[-1]
                break
    return nds


def testing_info(args):
    files = glob.glob(f"{args.dir_testlogs}/*.out")

    for key in args.keys:
        print(key, end="\t")
    print("file")

    for f in files:
        f_basename = os.path.basename(f)
        for key in args.keys:
            try:
                print(eval(f"get_{key}")(f), end="\t")
            except:
                pass
        print(f_basename)


def add_train_parser(subparsers):
    parser_train = subparsers.add_parser("training", help="parser for training")
    parser_train.add_argument(
        "dir_trainlogs",
        type=str,
        # default="trainout/pp_nus_3d",
        help="path of training log in out format",
    )
    parser_train.add_argument(
        "--keys",
        type=str,
        nargs="+",
        default=["training_time"],
        help="the metric that you want to show",
    )


def add_test_parser(subparsers):
    parser_test = subparsers.add_parser(
        "testing",
        help="parser for testing",
    )
    parser_test.add_argument(
        "dir_testlogs",
        type=str,
        # default="testout/pp_nus_3d",
        help="path of testing log in out format",
    )
    parser_test.add_argument(
        "--keys",
        type=str,
        nargs="+",
        default=["NDS"],
        help="the metric that you want to show",
    )


def parse_args():
    parser = argparse.ArgumentParser(description="Analyze Out Log")
    # currently only support training time and test NDS
    subparsers = parser.add_subparsers(dest="task", help="task parser (train or test)")
    add_train_parser(subparsers)
    add_test_parser(subparsers)
    args = parser.parse_args()
    return args


def main():
    args = parse_args()
    eval(f"{args.task}_info")(args)


if __name__ == "__main__":
    main()
