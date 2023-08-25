#!/bin/bash

(
    set -eu
    echo "Waiting for emulator..."
    /usr/bin/wait-for localhost:8681 -- env PUBSUB_EMULATOR_HOST=localhost:8681 /usr/bin/pubsub
    echo "Done building projects/topics/subscriptions! Opening readiness port..."
    nc -lkp 8682
) &

gcloud beta emulators pubsub start --host-port=0.0.0.0:8681 "$@"
