#!/bin/bash

# https://github.com/swift-server/swift-aws-lambda-runtime/blob/a5b50764a482970a19a17064bc3b1eb0a487c77a/Sources/AWSLambdaRuntimeCore/Documentation.docc/Getting-started.md

set -eu

executable=NextICalEvent

target=.build/lambda/$executable
rm -rf "$target"
mkdir -p "$target"
cp ".build/release/$executable" "$target/"
cd "$target"
ln -s "$executable" "bootstrap"
zip --symlinks lambda.zip *

echo "Output file at: $target/lambda.zip"
