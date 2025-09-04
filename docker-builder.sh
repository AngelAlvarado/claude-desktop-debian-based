#!/bin/sh
: "${GITHUB_OUTPUT:=$(mktemp --suffix=.builder.log)}"
time1=$(date +%s.%N)

set -eux
mkdir -p output
chmod 777 output
docker build -t claude-desktop-debian .
# Use -it flags only when we have a TTY (not in CI)
if [ -t 0 ]; then
  DOCKER_FLAGS="-it"
else
  DOCKER_FLAGS=""
fi

docker run \
  --rm \
  ${DOCKER_FLAGS} \
  -v ./output:/home/builder/output \
  claude-desktop-debian "$@"

time2=$(date +%s.%N)
diff=$(echo "scale=40;${time2} - ${time1}" | bc)
echo "time=$diff" >> "$GITHUB_OUTPUT"
