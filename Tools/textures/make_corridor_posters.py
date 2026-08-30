#!/usr/bin/env python3
"""Print the Briggs Botanical Gardens art onto the corridor poster's base map.

The lab corridor hangs five copies of one folded sheet (BandPoster.fbx) and four runes are
daubed across them, so the wall needs four printed faces rather than one. Each source poster
is laid into the exact rectangle the old art occupied on BandPoster_BaseMap - centred, full
height, white either side - because the sheet is folded and its back faces sample that white
margin. Nothing about the mesh, its UVs or the crease maps changes.

    python3 Tools/textures/make_corridor_posters.py

Writes Assets/RootsDance/Textures/Environment/BriggsPoster_<Name>_BaseMap.png, one per source
file in SourceArt/Posters/Briggs_Botanical_Gardens/. Re-run it after the art is redrawn.
"""
import os
from PIL import Image

SHEET = 2048                    # BandPoster_BaseMap is square

# The printed face on the old base map, measured off it: full height, centred, white either
# side. Keeping the new art inside the same rectangle makes it a drop-in for the same UVs.
ART_LEFT = 263
ART_WIDTH = 1523

SOURCE_DIR = "SourceArt/Posters/Briggs_Botanical_Gardens"
OUT_DIR = "Assets/RootsDance/Textures/Environment"

# Source stem -> the name the base map and its material carry.
POSTERS = {
    "Briggs_Ferns": "Ferns",
    "Briggs_Flowering_Plants": "FloweringPlants",
    "Briggs_Fungal": "Fungal",
    "Briggs_Lichens": "Lichens",
}

WHITE = (255, 255, 255)

# How far a pixel may sit from paper white and still count as the file's own blank margin.
MARGIN_TOLERANCE = 12


def trim(image):
    """The art without the blank margin some of the files were exported with."""
    box = Image.eval(image, lambda v: 255 - v).getbbox()

    if box is None:
        return image

    # getbbox works per channel on the inverted image, which is exactly "not white", but it
    # trims nothing for a near-white margin; redo it against a tolerance.
    grey = image.convert("L").point(lambda v: 0 if v >= 255 - MARGIN_TOLERANCE else 255)
    box = grey.getbbox() or box

    return image.crop(box)


def fit(art):
    """The art scaled to sit inside the printed rectangle whole, on its own extended border."""
    scale = min(ART_WIDTH / art.width, SHEET / art.height)
    size = (max(1, round(art.width * scale)), max(1, round(art.height * scale)))
    art = art.resize(size, Image.LANCZOS)

    if size == (ART_WIDTH, SHEET):
        return art

    # Every one of these posters ends in a solid printed border, so stretching its outermost
    # row or column over the shortfall extends that border rather than showing a seam.
    face = Image.new("RGB", (ART_WIDTH, SHEET))
    left = (ART_WIDTH - size[0]) // 2
    top = (SHEET - size[1]) // 2

    if left > 0:
        face.paste(art.crop((0, 0, 1, size[1])).resize((left, size[1])), (0, top))
        face.paste(art.crop((size[0] - 1, 0, size[0], size[1])).resize((ART_WIDTH - left - size[0], size[1])),
                   (left + size[0], top))
    if top > 0:
        wide = Image.new("RGB", (ART_WIDTH, size[1]))
        wide.paste(face.crop((0, top, ART_WIDTH, top + size[1])), (0, 0))
        wide.paste(art, (left, 0))
        face.paste(wide.crop((0, 0, ART_WIDTH, 1)).resize((ART_WIDTH, top)), (0, 0))
        face.paste(wide.crop((0, size[1] - 1, ART_WIDTH, size[1])).resize((ART_WIDTH, SHEET - top - size[1])),
                   (0, top + size[1]))

    face.paste(art, (left, top))

    return face


def main():
    os.makedirs(OUT_DIR, exist_ok=True)

    for stem, name in sorted(POSTERS.items()):
        source = next((os.path.join(SOURCE_DIR, f) for f in sorted(os.listdir(SOURCE_DIR))
                       if os.path.splitext(f)[0] == stem), None)

        if source is None:
            raise SystemExit(f"no source file for {stem} in {SOURCE_DIR}")

        art = fit(trim(Image.open(source).convert("RGB")))
        sheet = Image.new("RGB", (SHEET, SHEET), WHITE)
        sheet.paste(art, (ART_LEFT, 0))

        path = os.path.join(OUT_DIR, f"BriggsPoster_{name}_BaseMap.png")
        sheet.save(path)
        print(f"{path}  <- {os.path.basename(source)}")


if __name__ == "__main__":
    main()
