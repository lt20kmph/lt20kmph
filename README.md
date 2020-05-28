## Info

Code for my photo blog [lt20kmph.co.uk](https://www.lt20kmph.co.uk).
Assuming that you have folder numbers 0..n in pics forlder, then run the 
script genNewPage.sh with arguments 0..n to generate page html. For example:

    for i in $(seq 0 n);do genNewPage.sh $i; done

The script autoThumbs.sh will generate web sized pictures and thumbnails from a
folder of pictures. For example:

    autoThumbs.sh "path/to/your/pics" "output/path"

