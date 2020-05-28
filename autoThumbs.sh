#!/bin/sh

path=$1
newpath=pics/$2
counter="1"

if [ -d "$newpath" ]; then
    echo "$newpath exists!"
else
    mkdir $newpath
    for X in $path/*.JPG
    do 
        convert "$X" -resize 120x80 -strip -quality 86 "$newpath/$counter.thumb.jpg"
        convert "$X" -resize 1200x800 -strip -quality 86 "$newpath/$counter.jpg"
        counter=$[$counter +1]
    done
fi

