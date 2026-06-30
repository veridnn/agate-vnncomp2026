#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TOOL_NAME=agate
VERSION_STRING=v1

# check arguments
if [ "$1" != ${VERSION_STRING} ]; then
	echo "Expected first argument (version string) '$VERSION_STRING', got '$1'"
	exit 1
fi

CATEGORY=$2
ONNX_FILE=$3
VNNLIB_FILE=$4

echo "Preparing $TOOL_NAME for benchmark instance in category '$CATEGORY' with onnx file '$ONNX_FILE' and vnnlib file '$VNNLIB_FILE'"

# kill any zombie processes
# killall -q python3

# configure environment and solver
if [ -f ".venv/bin/activate" ]; then
	source .venv/bin/activate
fi
source "$SCRIPT_DIR/.env"
# use the cpu if the onnx file is small
if [ -f "$ONNX_FILE" ]; then
	if [ $(stat -c %s "$ONNX_FILE") -lt 100000 ]; then
		export JAX_PLATFORMS=cpu
	fi
fi
# set batch size per benchmark category
batch_size=2048
if [ "$CATEGORY" = "vgg16_2022" ]; then
	batch_size=32
fi
if [ "$CATEGORY" = "cgan2026" ]; then
	batch_size=512
fi
# TODO: nn4sys
export AGATE_SOLVER_CONFIG='{"type": "multi", "params": {"parallel": true, "solver_configs": [{"type": "genetic", "params": {"population_size": '$batch_size'}}, {"type": "dpll"}]}}'

# perform a quick warmup run
agate --version
agate verify -h
# agate verify $VNNLIB_FILE --network N $ONNX_FILE --timeout 60

# to skip a benchmark category, return non-zero
if [ "$CATEGORY" = "smart_turn_multimodal_2026" ]; then
	echo "Skipping benchmark category '$CATEGORY'"
	exit 1
elif [ "$CATEGORY" = "cctsdb_yolo_2023" ]; then
	echo "Skipping benchmark category '$CATEGORY'"
	exit 1
elif [ "$CATEGORY" = "adaptive_cruise_control_non_linear_2026" ]; then
	echo "Skipping benchmark category '$CATEGORY'"
	exit 1
elif [ "$CATEGORY" = "isomorphic_acasxu_2026" ]; then
	echo "Skipping benchmark category '$CATEGORY'"
	exit 1
elif [ "$CATEGORY" = "monotonic_acasxu_2026" ]; then
	echo "Skipping benchmark category '$CATEGORY'"
	exit 1
fi
exit 0
