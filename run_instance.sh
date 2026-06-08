#!/bin/sh

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

./agate verify $VNNLIB_FILE --network N $ONNX_FILE --timeout $TIMEOUT --serialise-assignments cex/ > $RESULTS_FILE

# TODO: convert counter example to correct format
