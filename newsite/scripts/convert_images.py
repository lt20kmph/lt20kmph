#!/bin/python

import os
from PIL import Image
import pathlib
import sys


WIDTHS = [20, 240, 400, 800, 1500]


# Usage: python convert_images.py <image_dir>
# The script will create a directory called resized in the image_dir
# and create subdirectories for each width in WIDTHS
def main():
    image_dir = sys.argv[1]

    output_dir = f"{image_dir}/resized"

    # Create the output directory

    pathlib.Path(output_dir).mkdir(parents=True, exist_ok=True)

    for width in WIDTHS:
        pathlib.Path(f"{output_dir}/{width}").mkdir(
            parents=True, exist_ok=True
        )

    image_index = 1

    for image in sorted(os.listdir(image_dir)):
        print("Processing: ", f"{image_dir}/{image}, Index: ", image_index)
        if image.endswith(".JPG"):
            img = Image.open(f"{image_dir}/{image}")
            for width in WIDTHS:
                # Resize the image, to width keeping aspect ratio
                print("Resizing to: ", width)
                resized_img = img.resize(
                    (width, int(img.height * width / img.width))
                )
                # Save the image
                resized_img.save(
                    f"{output_dir}/{width}/{image_index}.jpg",
                    "JPEG",
                    quality=90,
                    optimize=True,
                )
            image_index += 1
        print("-" * 50)


if __name__ == "__main__":
    main()
