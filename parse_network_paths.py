#!/usr/bin/env python3
import ast
import sys


def main():
    if not len(sys.argv) == 2:
        print("Usage: parse_network_paths.py <networks_string>")
        sys.exit(1)
    networks_string = sys.argv[1]
    try:
        names_and_paths = ast.literal_eval(networks_string)
    except SyntaxError:
        print(f"--network N={networks_string}")
        return
    network_args = []
    for network_name, network_path in names_and_paths:
        network_args.append(f"--network {network_name}={network_path}")
    print(" ".join(network_args))


main()
