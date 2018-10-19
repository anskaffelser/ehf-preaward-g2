#!/bin/sh

. /target/env

name=$IDENTIFIER-schematron

if [ -e /target/schematron ]; then
  rm -r /target/schematron
fi

mkdir /target/schematron

for sch in $(ls /src/rules/*/sch/*.sch); do
  echo "Prepare: $sch"
  schematron prepare $sch /target/schematron/$(basename $sch)
done

cd /target/schematron

if [ -e /target/site/files/$name.zip ]; then
  rm /target/site/files/$name.zip
fi

if [ -e /target/site/files ]; then
  zip -9 /target/site/files/$name.zip *
else
  zip -9 /target/$name.zip *
fi
