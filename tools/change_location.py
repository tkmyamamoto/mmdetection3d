import argparse


def main(args):
    fname = "./tools/location.txt"
    f = open(fname, "r")
    prev_location = f.read()
    f.close()

    f = open(fname, "w")
    f.write(args.location)
    f.close()

    print(f"Changed {fname}. {prev_location} -> {args.location}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("location", type=str, help="location name (ex. singapore)")
    args = parser.parse_args()
    main(args)
