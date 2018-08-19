#!/bin/bash

docker run --rm -v `pwd`/themes/jmsmkn.com/assets/:/app/ -w="/app" -u `id -u` node:8.11-alpine npm install
