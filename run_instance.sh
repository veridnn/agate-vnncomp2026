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
RESULTS_FILE=$5
TIMEOUT=$6

rm -rf cex/
rm -f $RESULTS_FILE

echo ""
echo "Running '$TOOL_NAME' in category '$CATEGORY' with onnx file '$ONNX_FILE', vnnlib file '$VNNLIB_FILE', results file '$RESULTS_FILE', and timeout '$TIMEOUT'"
echo ""

TIMEOUT=${TIMEOUT%.*}

# configure the solver
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
export AGATE_SOLVER_CONFIG='{"type": "multi", "params": {"parallel": true, "solver_configs": [{"type": "genetic", "params": {"population_size": '$batch_size'}}, {"type": "dpll"}]}}'

./agate verify $VNNLIB_FILE $(scripts/vnncomp/parse_network_paths.py "$ONNX_FILE") --timeout $TIMEOUT > $RESULTS_FILE
