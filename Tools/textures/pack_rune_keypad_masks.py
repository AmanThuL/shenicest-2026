#!/usr/bin/env python3
"""Pack the RuneKeypad metallic/roughness sources into HDRP mask maps.

HDRP Lit reads metallic from R, ambient occlusion from G, detail mask from B and
smoothness from A. The source art has no authored AO or detail mask, so those channels
are neutral while smoothness is the inverse of roughness.
"""
from pathlib import Path

from PIL import Image, ImageOps


ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "SourceArt/Props/RuneKeypad/Maps"
OUTPUT = ROOT / "Assets/RootsDance/Textures/Props/RuneKeypad"

MAPS = (
    ("RuneKeypad_Base_Metallic.png", "RuneKeypad_Base_Roughness.png",
     "RuneKeypadBase_Mask.png"),
    ("RuneKeypad_Screen_Metallic.png", "RuneKeypad_Screen_Roughness.png",
     "RuneKeypadScreen_Mask.png"),
)


def pack(metallic_name, roughness_name, output_name):
    metallic = Image.open(SOURCE / metallic_name).convert("L")
    roughness = Image.open(SOURCE / roughness_name).convert("L")

    if roughness.size != metallic.size:
        roughness = roughness.resize(metallic.size, Image.Resampling.LANCZOS)

    neutral_ao = Image.new("L", metallic.size, 255)
    no_detail = Image.new("L", metallic.size, 0)
    smoothness = ImageOps.invert(roughness)
    mask = Image.merge("RGBA", (metallic, neutral_ao, no_detail, smoothness))
    target = OUTPUT / output_name
    mask.save(target, optimize=True)
    print("wrote", target, mask.size)


def main():
    OUTPUT.mkdir(parents=True, exist_ok=True)

    for specification in MAPS:
        pack(*specification)


if __name__ == "__main__":
    main()
