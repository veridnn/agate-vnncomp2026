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

echo "Preparing $TOOL_NAME for benchmark instance in category '$CATEGORY' with onnx file '$ONNX_FILE' and vnnlib file '$VNNLIB_FILE'"

# kill any zombie processes
killall -q python3

# # perform a quick warmup run
# ./agate verify $VNNLIB_FILE --network N $ONNX_FILE --timeout 60

# to skip a benchmark category, return non-zero
exit 0
