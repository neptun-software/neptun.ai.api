#!/bin/bash
set -ex

URL=$1
OUT=$2
FILENAME=$(basename $URL)

wget -nc $URL -O /build/$FILENAME

python3 /build/rwkv.cpp/python/convert_pytorch_to_ggml.py /build/$FILENAME /build/float-model float16
python3 /build/rwkv.cpp/python/quantize.py /build/float-model $OUT Q4_0
