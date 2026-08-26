"""RootsDance texture pipeline — shared, dependency-free core.

Importable from three different Python interpreters, so it must stay pure
stdlib:

* Blender 4.5 bundled Python 3.11  (stages/*.py)
* Substance 3D Painter bundled Python (painter/*.py)
* system Python 3               (stages/validate_textures.py, CI)

No PyYAML: Blender does not bundle it, so presets are JSON.
"""

__all__ = ["naming", "report", "presets", "paths"]
