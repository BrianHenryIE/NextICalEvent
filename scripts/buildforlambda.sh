#!/bin/bash

docker run \
    --rm \
    --volume "$(pwd)/:/src" \
    --workdir "/src/" \
    swift:5.7-amazonlinux2 \
    swift build --product NextICalEventParser -c release -Xswiftc -static-stdlib