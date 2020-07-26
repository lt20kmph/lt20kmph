#!/bin/sh

str=$''
for i in {1..21}; do
    # yarn togeojson $HOME/Downloads/tracks/track$i.gpx > track$i.js
    # str=$"track$i"
    # sed -i "1 i\var $str = " track$i.js
    # sed -i "$ a\;" track$i.js
    # sed -i '2d' track$i.js
    str=$str"track$i.js "
done

cat $str > track.js
