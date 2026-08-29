#!/usr/bin/env python3
"""Draw one poster rune per coverage mask for RootsDance/Environment/FluorescentReveal.

The glyphs are Ansuz, Raidho, Berkana and Dagaz: the keypad's intended password. Each is drawn as
straight strokes on black in its own square file, because each one hangs on its own poster
in the lab corridor - a player who finds one mark has found one, not a set.

    python3 Tools/textures/make_poster_runes.py

Writes Assets/RootsDance/Textures/Environment/PosterRune_<Name>_Mask.png. The shader reads
the red channel as glyph coverage, so the files are greyscale-by-construction and the other
channels only carry the same value. Replace one with authored art of the same square layout
and nothing else has to change.
"""
import os
from PIL import Image, ImageDraw

SIZE = 512                      # one square file per glyph
SUPERSAMPLE = 4                 # drawn large and box-filtered down, so the strokes antialias
STROKE = 0.055                  # stroke width as a fraction of glyph height
GLYPH_HEIGHT = 0.72             # glyph height as a fraction of the image height

# Each glyph is a list of (x0, y0, x1, y1) segments in its own box: x right, y up, y in 0..1.
GLYPHS = {
    # Ansuz: stave with two descending arms on its right side.
    "Ansuz": [(0, 0, 0, 1), (0, 0.82, 0.52, 0.58), (0, 0.52, 0.52, 0.28)],
    # Raidho: stave, a closed head, and a leg kicking down to the right.
    "Raidho": [(0, 0, 0, 1), (0, 1, 0.45, 0.80), (0.45, 0.80, 0, 0.60), (0, 0.60, 0.48, 0)],
    # Berkana: stave with two angular bowls opening to the right.
    "Berkana": [(0, 0, 0, 1), (0, 1, 0.48, 0.75), (0.48, 0.75, 0, 0.50),
                (0, 0.50, 0.48, 0.25), (0.48, 0.25, 0, 0)],
    # Dagaz: two staves joined diagonally into the day/hourglass rune.
    "Dagaz": [(0, 0, 0, 1), (0.62, 0, 0.62, 1), (0, 1, 0.62, 0), (0, 0, 0.62, 1)],
}

OUT_DIR = "Assets/RootsDance/Textures/Environment"


def draw(segments):
    """One glyph, centred in its own square, as a greyscale coverage image."""
    side = SIZE * SUPERSAMPLE
    image = Image.new("L", (side, side), 0)
    artist = ImageDraw.Draw(image)

    glyph_h = GLYPH_HEIGHT * side
    stroke = max(1, int(round(STROKE * glyph_h)))
    baseline = (side + glyph_h) / 2.0       # y of the glyph's bottom edge, in pixels

    # The glyphs are narrow and none of them is the same width, so each is centred on its own
    # span rather than on a shared cell; this keeps all four password clues visually aligned.
    span = max(max(s[0], s[2]) for s in segments)
    left = (side - span * glyph_h) / 2.0

    for x0, y0, x1, y1 in segments:
        artist.line(
            [(left + x0 * glyph_h, baseline - y0 * glyph_h),
             (left + x1 * glyph_h, baseline - y1 * glyph_h)],
            fill=255, width=stroke)
        # Pillow butt-caps every line, which notches the corners where strokes meet.
        for x, y in ((x0, y0), (x1, y1)):
            px, py = left + x * glyph_h, baseline - y * glyph_h
            r = stroke / 2.0
            artist.ellipse([px - r, py - r, px + r, py + r], fill=255)

    return image.resize((SIZE, SIZE), Image.LANCZOS)


def main():
    root = os.path.normpath(os.path.join(os.path.dirname(__file__), "..", ".."))

    for name, segments in GLYPHS.items():
        image = draw(segments)
        out = os.path.join(root, OUT_DIR, f"PosterRune_{name}_Mask.png")
        Image.merge("RGB", (image, image, image)).save(out, optimize=True)
        print("wrote", out, (SIZE, SIZE))


if __name__ == "__main__":
    main()
