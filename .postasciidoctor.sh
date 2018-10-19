#!/bin/sh

if [ -e /target/site ]; then
    cp -r /target/docs/* /target/site/
    rm -r /target/docs
fi
