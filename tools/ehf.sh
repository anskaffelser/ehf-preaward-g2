#!/bin/sh
# This is a generated file. Please make sure to edit source files.
set -e
EHFBUILD_IMAGE=${EHFBUILD_IMAGE:-anskaffelser/ehfbuild:latest}
run_in_ehfbuild() (
docker run --rm --pull=always -i \
  -e EHFBUILD_IN_CONTAINER=1 \
  -e IDENTIFIER -e RELEASE -e TITLE \
  -v "$(pwd):/src" -w /src \
  "$EHFBUILD_IMAGE" sh tools/ehf.sh "$@"
)
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
if [ "${EHFBUILD_IN_CONTAINER:-}" != "1" ]; then
run_in_ehfbuild trigger_examples
return
fi
test ! -r target/env || . target/env
rm -rf target/examples
mkdir -p target/examples target/site/files
test ! -r tools/template/examples-readme || cat tools/template/examples-readme | envsubst > target/examples/README
for folder in $(find rules -mindepth 2 -maxdepth 2 -name example -type d); do
if [ ! -e "$folder/.skip" ]; then
mkdir -p target/examples/$(echo $folder | cut -d '/' -f 2)
cp -r $folder/* target/examples/$(echo $folder | cut -d '/' -f 2)/
fi
done
for folder in $(find src -mindepth 2 -maxdepth 2 -name example -type d); do
if [ ! -e "$folder/.skip" ]; then
mkdir -p target/examples/$(echo $folder | cut -d '/' -f 2)
cp -r $folder/* target/examples/$(echo $folder | cut -d '/' -f 2)/
fi
done
test ! -r tools/script/examples.sh || . tools/script/examples.sh
rm -rf target/examples.zip
current=$(pwd)
cd target/examples
zip -D9r ../examples.zip *
cp $current/target/examples.zip $current/target/site/files/examples.zip
)
trigger_schematron() (
if [ "${EHFBUILD_IN_CONTAINER:-}" != "1" ]; then
run_in_ehfbuild trigger_schematron
return
fi
test ! -r target/env || . target/env
rm -rf target/schematron
mkdir -p target/schematron target/site/files
test ! -r tools/template/schematron-readme || cat tools/template/schematron-readme | envsubst > target/schematron/README
for sch in $(ls rules/*/sch/*.sch); do
if [ "$(basename "$sch")" = "common.sch" ]; then
continue
fi
if [ ! -e "$(dirname $sch)/.skip" ]; then
echo "Prepare: $sch"
mkdir -p target/schematron/$(echo $sch | cut -d '/' -f 2)
saxon net.sf.saxon.Transform -s:$sch -xsl:/usr/share/xslt/iso-schematron/iso_dsdl_include.xsl \
 | saxon net.sf.saxon.Transform -s:- -xsl:/usr/share/xslt/iso-schematron/iso_abstract_expand.xsl -o:target/schematron/$(echo $sch | cut -d '/' -f 2)/$(basename $sch)
fi
done
for sch in $(ls src/*/rules/sch/*.sch); do
if [ "$(basename "$sch")" = "common.sch" ]; then
continue
fi
if [ ! -e "$(dirname $sch)/.skip" ]; then
echo "Prepare: $sch"
mkdir -p target/schematron/$(echo $sch | cut -d '/' -f 2)
saxon net.sf.saxon.Transform -s:$sch -xsl:/usr/share/xslt/iso-schematron/iso_dsdl_include.xsl \
 | saxon net.sf.saxon.Transform -s:- -xsl:/usr/share/xslt/iso-schematron/iso_abstract_expand.xsl -o:target/schematron/$(echo $sch | cut -d '/' -f 2)/$(basename $sch)
fi
done
test ! -r tools/script/schematron.sh || . tools/script/schematron.sh
rm -rf target/schematron.zip
current=$(pwd)
cd target/schematron
zip -D9r ../schematron.zip *
cp $current/target/schematron.zip $current/target/site/files/schematron.zip
)
trigger_xsd() (
if [ "${EHFBUILD_IN_CONTAINER:-}" != "1" ]; then
run_in_ehfbuild trigger_xsd
return
fi
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
zip -D9r $current/target/xsd/$name.zip *
cp $current/target/xsd/$name.zip $current/target/site/files/xsd-$name.zip
cd $current
done
)
trigger_scripts() (
if [ "${EHFBUILD_IN_CONTAINER:-}" != "1" ]; then
run_in_ehfbuild trigger_scripts
return
fi
test ! -r target/env || . target/env
for file in $(find scripts -type f -name *.sh -maxdepth 1); do
echo "> $file"
. $file
done
)
$*
