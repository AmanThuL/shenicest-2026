#!/usr/bin/env python3
"""Build the helmet visor opening SDF from the helmet's actual on-screen silhouette.

The visor shader derives "depth into the glass" from this texture and gathers the
smudges just inside its edge, so the shape here IS where the grime band sits. The
old texture was an authored arch that no longer matched the helmet mesh once the
arms framing and eye height were finalized - the smudges curved one way and the
rim another. These control points are traced from an in-game screenshot of the
rim (2026-08-29); re-trace and re-run if the helmet or the framing changes.

    python3 Tools/textures/make_visor_shape.py

Writes Assets/RootsDance/UI/Sprites/HelmetVisorShape.png. Same format as before:
768x512 L, <0.5 inside the glass, >0.5 in the frame, ~1.67/uv-y gradient so the
smudge band keeps its width and every shader tunable keeps its meaning.
"""
import os
import numpy as np
from PIL import Image
from scipy.ndimage import distance_transform_edt

WIDTH, HEIGHT = 768, 512
SUPER = 2                       # rasterised at 2x and averaged down

# Slope of the old texture, measured: 0.4 of value over 123/512 of uv-y.
GRADIENT_PER_UV = 1.67

# The rim's screen silhouette, traced off the annotated screenshot: (u, v-from-top)
# pairs, left edge to right edge. The dip past u=0.75 is the helmet's right-side
# vent bulge, not sag - it is on the mesh.
TOP_EDGE = [
    (0.00, 0.312), (0.05, 0.264), (0.13, 0.229), (0.24, 0.223),
    (0.39, 0.193), (0.53, 0.184), (0.61, 0.177), (0.73, 0.208),
    (0.81, 0.252), (0.90, 0.236), (1.00, 0.223),
]

# The chin corners: a straight cut from the side edge down to the bottom edge,
# as (u_on_bottom, v_on_side). Between the two cuts the glass runs to the bottom.
BOTTOM_LEFT = (0.18, 0.870)
BOTTOM_RIGHT = (0.80, 0.930)


def catmull_rom(points, samples_per_span=32):
    """A smooth open curve through every control point."""
    pts = [points[0]] + points + [points[-1]]
    curve = []

    for i in range(1, len(pts) - 2):
        p0, p1, p2, p3 = (np.array(pts[j]) for j in (i - 1, i, i + 1, i + 2))

        for s in range(samples_per_span):
            t = s / samples_per_span
            curve.append(
                0.5 * ((2 * p1) + (-p0 + p2) * t
                       + (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t
                       + (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t))

    curve.append(np.array(points[-1]))
    return curve


def glass_mask(w, h):
    """Boolean inside-the-glass mask: under the rim curve, above the corner cuts."""
    yy, xx = np.mgrid[0:h, 0:w]
    u = (xx + 0.5) / w
    v = (yy + 0.5) / h

    curve = catmull_rom(TOP_EDGE)
    us = np.array([p[0] for p in curve])
    vs = np.array([p[1] for p in curve])
    order = np.argsort(us)
    top = np.interp(u, us[order], vs[order])

    inside = v > top

    # Corner cuts: the frame triangle sits between the side edge and the bottom edge,
    # so glass is whatever lies on the same side of the cut line as the screen centre.
    def keep_centre_side(ax, av, bx, bv):
        cross = (bx - ax) * (v - av) - (bv - av) * (u - ax)
        centre = (bx - ax) * (0.5 - av) - (bv - av) * (0.5 - ax)
        return cross * centre > 0

    cu, cv = BOTTOM_LEFT
    inside &= keep_centre_side(0.0, cv, cu, 1.0)
    cu2, cv2 = BOTTOM_RIGHT
    inside &= keep_centre_side(1.0, cv2, cu2, 1.0)

    return inside


def main():
    w, h = WIDTH * SUPER, HEIGHT * SUPER
    inside = glass_mask(w, h)

    # Signed distance in uv-y units: positive in the frame, negative in the glass.
    scale = 1.0 / h
    outside_d = distance_transform_edt(~inside) * scale
    inside_d = distance_transform_edt(inside) * scale
    signed = np.where(inside, -inside_d, outside_d)

    value = np.clip(0.5 + signed * GRADIENT_PER_UV, 0.0, 1.0)

    image = Image.fromarray((value * 255).astype(np.uint8))
    image = image.resize((WIDTH, HEIGHT), Image.LANCZOS)

    out = os.path.normpath(os.path.join(
        os.path.dirname(__file__), "..", "..",
        "Assets/RootsDance/UI/Sprites/HelmetVisorShape.png"))
    image.save(out, optimize=True)
    print("wrote", out, (WIDTH, HEIGHT))


if __name__ == "__main__":
    main()
