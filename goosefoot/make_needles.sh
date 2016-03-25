#!/bin/sh

CENTRE=$(grep '<centre ' input.final/settings.xml | sed -e 's/centre/target/g')
NEEDLES=$(grep '<needle ' input.final/settings.xml | grep offset | sed 's/\(.*\)name\(="[0-9a-zA-Z]"\)\(.*\)/\1name\2 file\2\3/g')

mkdir -p input.final/needlelibrary
echo '<needlelibrary scaling="0.001" version="1.0.2">' $CENTRE $NEEDLES '</needlelibrary>' > input.final/needlelibrary/needlelibrary.xml
cd input.final/needlelibrary
go-smart-needle-library --output=elmer_libnuma needlelibrary.xml
