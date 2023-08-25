#!/usr/bin/env python3

import os
import sys
import subprocess

def main() -> None:
    i = 0
    while True:
        i += 1
        env = os.environ.get(f"PUBSUB_PROJECT{i}")
        if not env:
            if i == 1:
                print('$PUBSUB_PROJECT1 was not set')
                sys.exit(1)
            return

        project, *topics = env.split(',')
        if not topics:
            print(f'ERROR: $PUBSUB_PROJECT{i} had no defined topic')
            sys.exit(1)

        for topic in topics:
            # create topic
            print(f"python3 publisher.py {project} create {topic}")

            topic, *subscription = topic.split(':')
            if subscription:
                subscription, *endpoint = subscription
                if subscription and endpoint:
                    # create topic with push endpoint
                    print(f"python3 subscriber.py {project} create-push {topic} {subscription} {endpoint[0]}")
                if subscription and not endpoint:
                    # create topic with subscription
                    print(f"python3 subscriber.py {project} create {topic} {subscription}")

if __name__ == '__main__':
    main()
