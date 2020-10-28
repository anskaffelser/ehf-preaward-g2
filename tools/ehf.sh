#!/bin/sh
# This is a generated file. Please make sure to edit source files.
trigger_environment() (
rm -f target/env
append() {
echo export $1=\"$2\" >> target/env
}
test ! -d .git || append GIT $(git rev-parse HEAD)
append IDENTIFIER "$IDENTIFIER"
append RELEASE "$RELEASE"
append TIMESTAMP "$(date -u +"%Y-%m-%d %H:%Mz")"
append TITLE "$TITLE"
test ! -r tools/script/environment.sh || . tools/script/environment.sh
)
trigger_examples() (
test ! -r target/env || . target/env
rm -rf target/examples
mkdir -p target/examples target/site/files
test ! -r tools/template/examples-readme || cat tools/template/examples-readme | envsubst > target/examples/README
for folder in $(find rules -mindepth 2 -maxdepth 2 -name example -type d); do
mkdir -p target/examples/$(echo $folder | cut -d '/' -f 2)
cp -r $folder/* target/examples/$(echo $folder | cut -d '/' -f 2)/
done
for folder in $(find src -mindepth 2 -maxdepth 2 -name example -type d); do
mkdir -p target/examples/$(echo $folder | cut -d '/' -f 2)
cp -r $folder/* target/examples/$(echo $folder | cut -d '/' -f 2)/
done
test ! -r tools/script/examples.sh || . tools/script/examples.sh
rm -rf target/examples.zip
current=$(pwd)
cd target/examples
zip -9r ../examples.zip *
cp $current/target/examples.zip $current/target/site/files/examples.zip
)
trigger_schematron() (
test ! -r target/env || . target/env
rm -rf target/schematron
mkdir -p target/schematron target/site/files
test ! -r tools/template/schematron-readme || cat tools/template/schematron-readme | envsubst > target/schematron/README
for sch in $(ls rules/*/sch/*.sch); do
echo "Prepare: $sch"
mkdir -p target/schematron/$(echo $sch | cut -d '/' -f 2)
saxon -s:$sch -xsl:/usr/share/xslt/iso-schematron/iso_dsdl_include.xsl \
 | saxon -s:- -xsl:/usr/share/xslt/iso-schematron/iso_abstract_expand.xsl -o:target/schematron/$(echo $sch | cut -d '/' -f 2)/$(basename $sch)
done
for sch in $(ls src/*/rules/sch/*.sch); do
echo "Prepare: $sch"
mkdir -p target/schematron/$(echo $sch | cut -d '/' -f 2)
saxon -s:$sch -xsl:/usr/share/xslt/iso-schematron/iso_dsdl_include.xsl \
 | saxon -s:- -xsl:/usr/share/xslt/iso-schematron/iso_abstract_expand.xsl -o:target/schematron/$(echo $sch | cut -d '/' -f 2)/$(basename $sch)
done
test ! -r tools/script/schematron.sh || . tools/script/schematron.sh
rm -rf target/schematron.zip
current=$(pwd)
cd target/schematron
zip -9 -r ../schematron.zip *
cp $current/target/schematron.zip $current/target/site/files/schematron.zip
)
trigger_xsd() (
test ! -r target/env || . target/env
rm -rf target/xsd
mkdir -p target/xsd target/site/files
current=$(pwd)
for folder in $(find xsd -mindepth 1 -maxdepth 1 -type d); do
name=$(basename $folder)
echo "Packaging $name"
cp -r $folder /tmp/$name
cd /tmp/$name
test ! -e prepare.sh || . prepare.sh
rm -rf prepare.sh
zip -9 -r $current/target/xsd/$name.zip *
cp $current/target/xsd/$name.zip $current/target/site/files/xsd-$name.zip
cd $current
done
)
trigger_scripts() (
test ! -r target/env || . target/env
for file in $(find scripts -type f -name *.sh -maxdepth 1); do
echo "> $file"
. $file
done
)
$*
