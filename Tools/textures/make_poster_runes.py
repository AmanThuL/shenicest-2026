#!/usr/bin/env python3
"""Draw the four poster runes into a coverage mask for RootsDance/Environment/FluorescentReveal.

Placeholder art: the glyphs are Fehu, Raidho, Thurisaz and Mannaz, drawn as straight
strokes on black. The shader reads the red channel as glyph coverage, so the file is
greyscale-by-construction and the other channels only carry the same value.

    python3 Tools/textures/make_poster_runes.py

Writes Assets/RootsDance/Textures/Environment/PosterRunes_Mask.png. Replace that file with
authored art of the same layout and nothing else has to change.
"""
import os
from PIL import Image, ImageDraw

WIDTH, HEIGHT = 2048, 512
SUPERSAMPLE = 4                 # drawn large and box-filtered down, so the strokes antialias
STROKE = 0.055                  # stroke width as a fraction of glyph height
GLYPH_HEIGHT = 0.56             # glyph height as a fraction of the image height

# Each glyph is a list of (x0, y0, x1, y1) segments in its own box: x right, y up, y in 0..1.
GLYPHS = [
    # Fehu: stave with two arms slanting up to the right.
    [(0, 0, 0, 1), (0, 0.72, 0.50, 0.98), (0, 0.42, 0.50, 0.68)],
    # Raidho: stave, a closed head, and a leg kicking down to the right.
    [(0, 0, 0, 1), (0, 1, 0.45, 0.80), (0.45, 0.80, 0, 0.60), (0, 0.60, 0.48, 0)],
    # Thurisaz: stave with a thorn on its right flank.
    [(0, 0, 0, 1), (0, 0.75, 0.45, 0.50), (0.45, 0.50, 0, 0.25)],
    # Mannaz: two staves bridged by a cross.
    [(0, 0, 0, 1), (0.62, 0, 0.62, 1), (0, 1, 0.62, 0.45), (0.62, 1, 0, 0.45)],
]


def main():
    w, h = WIDTH * SUPERSAMPLE, HEIGHT * SUPERSAMPLE
    image = Image.new("L", (w, h), 0)
    draw = ImageDraw.Draw(image)

    glyph_h = GLYPH_HEIGHT * h
    stroke = max(1, int(round(STROKE * glyph_h)))
    baseline = (h + glyph_h) / 2.0          # y of the glyph's bottom edge, in pixels

    for index, segments in enumerate(GLYPHS):
        # Cell centres split the width evenly; each glyph is drawn from its own left edge.
        span = max(max(s[0], s[2]) for s in segments)
        centre_x = w * (index + 0.5) / len(GLYPHS)
        left = centre_x - span * glyph_h / 2.0

        for x0, y0, x1, y1 in segments:
            draw.line(
                [(left + x0 * glyph_h, baseline - y0 * glyph_h),
                 (left + x1 * glyph_h, baseline - y1 * glyph_h)],
                fill=255, width=stroke)
            # Pillow butt-caps every line, which notches the corners where strokes meet.
            for x, y in ((x0, y0), (x1, y1)):
                px, py = left + x * glyph_h, baseline - y * glyph_h
                r = stroke / 2.0
                draw.ellipse([px - r, py - r, px + r, py + r], fill=255)

    image = image.resize((WIDTH, HEIGHT), Image.LANCZOS)
    out = os.path.join(os.path.dirname(__file__), "..", "..",
                       "Assets/RootsDance/Textures/Environment/PosterRunes_Mask.png")
    out = os.path.normpath(out)
    Image.merge("RGB", (image, image, image)).save(out, optimize=True)
    print("wrote", out, (WIDTH, HEIGHT))


if __name__ == "__main__":
    main()
