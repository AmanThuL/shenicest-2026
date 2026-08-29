"""Write the greenhouse module layer stacks into their pipeline configs.

Every module shares one degradation chain; what differs is how much of each
step it got, and that follows from where the module sits on the building --
height above ground, whether its faces point up, how much sky it sees.
"""
import collections
import io
import json
import os

W = "SourceArt/Reference/Weathering"
SRC = {
    "steel":    ("Metal021/Metal021_2K-JPG_Color.jpg",
                 "Metal021/Metal021_2K-JPG_NormalGL.jpg",
                 "Metal021/Metal021_2K-JPG_Roughness.jpg"),
    "oxid":     ("metal_plate_02/metal_plate_02_diff_2k.jpg",
                 "metal_plate_02/metal_plate_02_nor_gl_2k.jpg",
                 "metal_plate_02/metal_plate_02_rough_2k.jpg"),
    "rust":     ("rusty_painted_metal/rusty_painted_metal_diff_2k.jpg",
                 "rusty_painted_metal/rusty_painted_metal_nor_gl_2k.jpg",
                 "rusty_painted_metal/rusty_painted_metal_rough_2k.jpg"),
    "moss":     ("concrete_moss/concrete_moss_diff_2k.jpg",
                 "concrete_moss/concrete_moss_nor_gl_2k.jpg",
                 "concrete_moss/concrete_moss_rough_2k.jpg"),
    "lichen":   ("lichen_rock/lichen_rock_diff_2k.jpg",
                 "lichen_rock/lichen_rock_nor_gl_2k.jpg",
                 "lichen_rock/lichen_rock_rough_2k.jpg"),
    "mud":      ("brown_mud_leaves_01/brown_mud_leaves_01_diff_2k.jpg",
                 "brown_mud_leaves_01/brown_mud_leaves_01_nor_gl_2k.jpg",
                 "brown_mud_leaves_01/brown_mud_leaves_01_rough_2k.jpg"),
    "paint":    ("PaintedMetal006/PaintedMetal006_2K-JPG_Color.jpg",
                 "PaintedMetal006/PaintedMetal006_2K-JPG_NormalGL.jpg",
                 "PaintedMetal006/PaintedMetal006_2K-JPG_Roughness.jpg"),
    "concrete": ("concrete_wall_008/concrete_wall_008_diff_2k.jpg",
                 "concrete_wall_008/concrete_wall_008_nor_gl_2k.jpg",
                 "concrete_wall_008/concrete_wall_008_rough_2k.jpg"),
    "marble":   ("Marble012/Marble012_2K-JPG_Color.jpg",
                 "Marble012/Marble012_2K-JPG_NormalGL.jpg",
                 "Marble012/Marble012_2K-JPG_Roughness.jpg"),
}


def photo(name, scale, opacity, key, mask=None, normal=True):
    diff, nor, rough = SRC[key]
    parts = ["basecolor=%s/%s" % (W, diff)]
    if normal:
        parts.append("normal=%s/%s" % (W, nor))
    parts.append("roughness=%s/%s" % (W, rough))
    spec = "%s(%s,%s):%s" % (name, scale, opacity, ";".join(parts))
    return spec + ("|" + mask if mask else "")


def tint(name, opacity, colour, rough, mask=None, metallic=None):
    parts = ["basecolor=%s" % colour, "roughness=%s" % rough]
    if metallic is not None:
        parts.append("metallic=%s" % metallic)
    spec = "%s(0,%s):%s" % (name, opacity, ";".join(parts))
    return spec + ("|" + mask if mask else "")


def vertical_iron(moss, lichen, lime, grime, damp, runoff, edgerust, edgewear,
                  paint=0.45):
    """Wall, window band, columns: the piece stands up and sheds water."""
    return [
        photo("SteelBase", 0.6, 1.0, "steel"),
        # a Victorian glasshouse was painted iron; the peeled-paint procedural
        # has the hard-edged flake shapes a smart mask smears away, and the
        # remnant sits right on the steel so everything later eats into it
        photo("PaintRemnant", 0.30, paint, "paint", "~grunge_paint_peeled"),
        photo("Oxidation", 0.18, 0.75, "oxid", "Surface Rust"),
        photo("EdgeRust", 0.45, edgerust, "rust", "Edge Rust"),
        photo("RustRunoff", 0.35, runoff, "rust", "Rust Drips", normal=False),
        tint("GrimeStreak", grime, "#241F1A", 0.80, "Water Drips"),
        tint("LimeDeposit", lime, "#C3BDAE", 0.90, "Dirt Leak Dry"),
        tint("DampRecess", damp, "#1E1C19", 0.55, "Moisture"),
        photo("MossTop", 0.22, moss, "moss", "Moss From Top"),
        photo("Lichen", 0.30, lichen, "lichen", "Moss"),
        tint("EdgeWear", edgewear, "#9AA0A3", 0.35, "Edges Scratched", metallic=1.0),
    ]


def sloped_roof(moss, lichen, lime, grime, damp, runoff, edgerust, silt, oxid):
    """The domes: rain runs off the slopes rather than standing on them, so
    the story is streaking and washing, and silt only settles in the up-facing
    channels between the glazing bars."""
    return [
        photo("SteelBase", 0.6, 1.0, "steel"),
        photo("Oxidation", 0.18, oxid, "oxid", "Surface Rust"),
        photo("EdgeRust", 0.45, edgerust, "rust", "Edge Rust"),
        photo("RustRunoff", 0.35, runoff, "rust", "Rust Drips", normal=False),
        tint("GrimeStreak", grime, "#241F1A", 0.80, "Water Drips"),
        tint("LimeDeposit", lime, "#C3BDAE", 0.90, "Dirt Leak Dry"),
        tint("DampRecess", damp, "#1E1C19", 0.55, "Moisture"),
        photo("GutterSilt", 0.25, silt, "mud", "Dirt Ground"),
        photo("MossTop", 0.22, moss, "moss", "Moss From Top"),
        photo("Lichen", 0.30, lichen, "lichen", "Moss"),
        tint("EdgeWear", 0.18, "#9AA0A3", 0.35, "Edges Scratched", metallic=1.0),
    ]


def horizontal_deck(moss, mud, water, grime):
    """Terrace slabs: water stands instead of running, so dirt beds down."""
    return [
        photo("SteelBase", 0.6, 1.0, "steel"),
        photo("Oxidation", 0.18, 0.85, "oxid", "Surface Rust"),
        photo("EdgeRust", 0.45, 0.30, "rust", "Edge Rust"),
        photo("RustRunoff", 0.35, 0.20, "rust", "Rust Drips", normal=False),
        tint("GrimeFilm", grime, "#241F1A", 0.82, "Dirt"),
        photo("MudBed", 0.25, mud, "mud", "Dirt Ground"),
        tint("StandingWater", water, "#17150F", 0.22, "Moisture"),
        photo("MossCarpet", 0.20, moss, "moss", "Moss From Top"),
        photo("Lichen", 0.30, 0.15, "lichen", "Moss"),
        tint("EdgeWear", 0.15, "#9AA0A3", 0.35, "Edges Scratched", metallic=1.0),
    ]


def stone_plinth():
    """The ground platform is masonry in the splash zone, not iron."""
    return [
        photo("StoneBase", 0.5, 1.0, "concrete"),
        tint("GrimeFilm", 0.58, "#2A251E", 0.85, "Dirt"),
        photo("MudSplash", 0.30, 0.45, "mud", "Dirt Ground"),
        tint("StandingWater", 0.30, "#17150F", 0.22, "Moisture"),
        photo("MossCarpet", 0.18, 0.38, "moss", "Moss From Top"),
        photo("Lichen", 0.30, 0.18, "lichen", "Moss"),
        tint("LimeDeposit", 0.20, "#C3BDAE", 0.90, "Dirt Leak Dry"),
    ]


def marble_stair(moss, lichen, lime, grime, damp, silt, polish):
    """The spiral stair is stone, not iron, so the chain starts one link later:
    no paint, no oxidation, no rust.  What a marble stair loses first is its
    polish -- feet take it off the nosings, standing water takes it off
    everywhere else -- and calcite is soluble, so the wash leaves a dull bloom
    rather than the runoff stains iron gives.  The treads are open (the swap
    deleted the railings), so every one of them is a horizontal slab that
    catches whatever comes through the broken glazing above."""
    return [
        photo("MarbleBase", 0.45, 1.0, "marble"),
        # airborne grime settles over the whole slab before anything grows
        tint("SootFilm", grime, "#3A3833", 0.72, "Dirt"),
        # the nosings are the one place still walked on: the polish survives
        # there and nowhere else, so this layer goes lighter *and* smoother
        tint("TreadPolish", polish, "#B9BCBD", 0.22, "Edges Scratched"),
        # marble dissolves; the wash redeposits calcite as a dull bloom
        tint("LimeBloom", lime, "#C3BDAE", 0.92, "Dirt Leak Dry"),
        tint("DampRecess", damp, "#1E1C19", 0.55, "Moisture"),
        # treads are horizontal, so silt beds down instead of running off
        photo("SiltBed", 0.25, silt, "mud", "Dirt Ground"),
        photo("MossCarpet", 0.20, moss, "moss", "Moss From Top"),
        photo("Lichen", 0.30, lichen, "lichen", "Moss"),
    ]


NOTE = ("Layered per docs/architecture/废弃温室材质研究.md, dialled per "
        "docs/architecture/废墟风化分层策略.md tier 1: the pattern belongs to "
        "the module, the position-driven amount is tier 2 in the shader.")

RECIPES = {
    # z 1.3-14.6, vertical panel, lower tier: some ground moss, moderate wash
    "GreenHouse1Wall":      vertical_iron(0.28, 0.10, 0.30, 0.45, 0.35, 0.30, 0.45, 0.18, paint=0.45),
    # z 22-29.5, vertical panel, high up: rain scours it, little grows
    "GreenHouse1Window":    vertical_iron(0.12, 0.06, 0.40, 0.50, 0.25, 0.35, 0.45, 0.22, paint=0.28),
    # z 1.3-14.6, column, foot near the ground: strongest vertical runoff
    "GreenHouse1Column":    vertical_iron(0.40, 0.12, 0.25, 0.65, 0.45, 0.35, 0.25, 0.18, paint=0.50),
    # z 22-29.5, slim column, high up
    "GreenHouse1WinColumn": vertical_iron(0.12, 0.06, 0.38, 0.60, 0.25, 0.35, 0.25, 0.20, paint=0.28),
    # z 35.2-42.7, the crowning finial: most exposed, cleanest, most scoured
    "GreenHouse1Top":       vertical_iron(0.06, 0.05, 0.45, 0.55, 0.20, 0.40, 0.50, 0.28, paint=0.18),
    # z 14.6-22.4: the lower dome, 39 m across -- a sloped roof, not a deck
    "GreenHouse1Floor1":    sloped_roof(0.32, 0.14, 0.50, 0.62, 0.35, 0.28, 0.18, 0.30, 0.60),
    # z 29.5-35.3: the upper dome, higher and more scoured
    "GreenHouse1Floor2":    sloped_roof(0.20, 0.10, 0.52, 0.60, 0.30, 0.28, 0.20, 0.20, 0.60),
    # z 0-1.3, the splash zone
    "GreenHouse1Ground":    stone_plinth(),
    # z 1.4-22.9, the interior spiral: the one module that is stone rather
    # than iron, and the only one whose faces are all walked on
    "GreenHouse1SpiralStair": marble_stair(0.30, 0.15, 0.30, 0.35, 0.35, 0.25, 0.30),
}

for asset, fills in RECIPES.items():
    path = os.path.join("Tools/pipeline/assets", asset + ".json")
    cfg = json.load(io.open(path, encoding="utf-8"),
                    object_pairs_hook=collections.OrderedDict)
    cfg["painter"]["fills"] = fills
    cfg["painter"]["layers"] = []
    cfg["painter"]["note"] = NOTE
    io.open(path, "w", encoding="utf-8").write(
        json.dumps(cfg, indent=2, ensure_ascii=False) + "\n")
    print("  %-22s %d layers" % (asset, len(fills)))
