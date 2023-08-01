#! /bin/bash

set -e

docker build -t muthuinc/react:v1 .

docker login -u muthuinc -p 8973214268

docker push muthuinc/react:v1

echo "done"
