"""Preset loading.

A preset is a JSON file under Tools/pipeline/presets/.  It answers the
questions a stage would otherwise have to invent an answer to: how big is the
texture, how much UV padding, which mesh maps get baked, what does Unity do
with the result.

Presets support single inheritance via "extends", so the PSX variants can
share one base without copy-paste drift.

JSON rather than YAML on purpose: Blender 4.5 does not bundle PyYAML, and the
whole pipeline has to run inside Blender's interpreter with no pip install.
"""

import json
import os

PRESET_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                          "presets")


class PresetError(ValueError):
    pass


def preset_path(name):
    if name.endswith(".json"):
        return name if os.path.isabs(name) else os.path.join(PRESET_DIR, name)
    return os.path.join(PRESET_DIR, name + ".json")


def load(name, _seen=None):
    """Load a preset by name ('psx_prop') or path, resolving 'extends'."""
    path = preset_path(name)
    if not os.path.isfile(path):
        raise PresetError(
            "no preset %r at %s; available: %s" % (name, path, ", ".join(available()))
        )
    _seen = _seen or []
    if path in _seen:
        raise PresetError("preset inheritance cycle: %s" % " -> ".join(_seen + [path]))
    with open(path) as fh:
        data = json.load(fh)
    parent = data.pop("extends", None)
    if parent:
        base = load(parent, _seen + [path])
        base = _deep_merge(base, data)
        data = base
    data["_name"] = os.path.splitext(os.path.basename(path))[0]
    data["_path"] = path
    return data


def available():
    if not os.path.isdir(PRESET_DIR):
        return []
    return sorted(os.path.splitext(f)[0]
                  for f in os.listdir(PRESET_DIR) if f.endswith(".json"))


def _deep_merge(base, over):
    out = dict(base)
    for k, v in over.items():
        if isinstance(v, dict) and isinstance(out.get(k), dict):
            out[k] = _deep_merge(out[k], v)
        else:
            out[k] = v
    return out


def padding_px(preset, resolution=None):
    """UV padding in pixels for a given resolution.

    Padding is stored in *texels at the preset's own resolution* and rescaled
    when the resolution changes, so 'raise the texture to 1024' does not
    silently halve the effective gutter.  This is the 'do not hardcode
    assumptions when the texture resolution changes' requirement.
    """
    uv = preset["uv"]
    res = resolution or preset["texture"]["resolution"]
    base_res = uv.get("padding_reference_resolution", preset["texture"]["resolution"])
    scaled = uv["padding_px"] * (float(res) / float(base_res))
    return max(uv.get("padding_px_min", 2), int(round(scaled)))


def padding_normalized(preset, resolution=None):
    """Same padding expressed in 0-1 UV space, which is what Blender's
    pack_islands margin actually takes."""
    res = resolution or preset["texture"]["resolution"]
    return padding_px(preset, res) / float(res)
