#!/bin/bash
git pull

HASH=$(git rev-parse --short HEAD)

docker build --pull -t garykrige/dev:${HASH} .
docker push garykrige/dev:${HASH}

sed -i "s@garykrige/dev:latest@garykrige/dev:${HASH}@g" deploy.yml

kubectl replace -f deploy.yml
