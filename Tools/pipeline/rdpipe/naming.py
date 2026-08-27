"""Texture / mesh naming rules for RootsDance.

The convention is NOT invented here -- the file-name *shape* is the one written
down in docs/guidelines/02-project-structure.md section "Naming" (table row
"Texture"), and the *map set* is the HDRP Lit slot set from
docs/guidelines/07-rendering-hdrp.md sections 9 and 10:

    <Asset>_<Map>   with Map in BaseMap|Normal|Mask|Emission|Height
    e.g. Crate_BaseMap.png, Crate_Normal.png, Crate_Mask.png

PascalCase, no type prefixes (no T_ / M_ / SM_), underscore reserved for the
map suffix.  The map names are the HDRP Lit shader's own slot names, which is
what makes the mapping to Unity deterministic.  HDRP channel-packs metallic,
ambient occlusion and smoothness into a single mask map, so there is no
separate Metallic / Specular / Occlusion map any more.

Multi-material assets: guideline 02 gives no rule for a per-material-slot
texture set, so this module defines one (flagged as a project decision in
docs/architecture/tooling/贴图管线.md, pending TA sign-off):

    <Asset><Part>_<Map>     e.g. HelmetVisor_Normal, HelmetShell_BaseMap

exactly one underscore, immediately before the map suffix, so the parser below
stays unambiguous.
"""

import re

# HDRP Lit slot names, in the order a material should be built.
# Mask is channel-packed: R metallic, G ambient occlusion, B detail mask
# (B height for a terrain layer), A smoothness -- see
# docs/guidelines/07-rendering-hdrp.md section 9.
MAPS = (
    "BaseMap",
    "Normal",
    "Mask",
    "Emission",
    "Height",
)

# Maps that carry colour and therefore must be imported as sRGB in Unity and
# read as sRGB in Blender.  Everything else is linear data.
# Source: docs/guidelines/07-rendering-hdrp.md section 10 table.
SRGB_MAPS = frozenset({"BaseMap", "Emission"})

# Maps that must never be produced without an alpha channel, because HDRP Lit
# has no separate smoothness slot at all: it always reads smoothness out of the
# mask map's alpha (docs/guidelines/07-rendering-hdrp.md section 9;
# docs/reference/rendering-hdrp/
# render-pipelines-high-definition-17-3-mask-map-and-detail-map.md).
ALPHA_REQUIRED_MAPS = frozenset({"Mask"})

_STEM_RE = re.compile(r"^(?P<set>[A-Z][A-Za-z0-9]*)_(?P<map>[A-Za-z]+)$")
_SET_RE = re.compile(r"^[A-Z][A-Za-z0-9]*$")


class NameError_(ValueError):
    """Raised when a name does not satisfy the convention."""


def texture_filename(texture_set, map_name, ext="png"):
    """Build 'HelmetShell_BaseMap.png' from ('HelmetShell', 'BaseMap')."""
    if map_name not in MAPS:
        raise NameError_(
            "unknown map %r; expected one of %s" % (map_name, ", ".join(MAPS))
        )
    if not _SET_RE.match(texture_set):
        raise NameError_(
            "texture set %r must be PascalCase with no underscore" % (texture_set,)
        )
    return "%s_%s.%s" % (texture_set, map_name, ext)


def parse_texture_filename(filename):
    """Inverse of texture_filename.

    Returns (texture_set, map_name, ext).  Raises NameError_ when the file does
    not follow the convention -- callers use this to *report*, not to guess.
    """
    base = filename.rsplit("/", 1)[-1]
    if "." not in base:
        raise NameError_("%r has no extension" % (filename,))
    stem, ext = base.rsplit(".", 1)
    m = _STEM_RE.match(stem)
    if not m:
        raise NameError_(
            "%r does not match <Asset>_<Map> (PascalCase, one underscore)" % (base,)
        )
    map_name = m.group("map")
    if map_name not in MAPS:
        raise NameError_(
            "%r has unknown map suffix %r; expected one of %s"
            % (base, map_name, ", ".join(MAPS))
        )
    return m.group("set"), map_name, ext


def is_srgb(map_name):
    return map_name in SRGB_MAPS


def texture_set_for_material(asset, material_slot_name):
    """Texture-set name for one material slot of an asset.

    Single-slot assets keep the bare asset name ('Helmet'); multi-slot assets
    get '<Asset><Part>'.  The slot name is used verbatim when it already starts
    with the asset name, so a slot literally called 'HelmetVisor' does not
    become 'HelmetHelmetVisor'.
    """
    part = "".join(ch for ch in material_slot_name if ch.isalnum())
    if not part:
        raise NameError_("material slot %r has no usable characters" % (material_slot_name,))
    part = part[0].upper() + part[1:]
    if part == asset or part.startswith(asset):
        return part
    return asset + part
