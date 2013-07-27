#!/bin/sh
jekyll serve --config _config.yml,_config-dev.yml --watch & sleep 1s && open "http://localhost:4000"
