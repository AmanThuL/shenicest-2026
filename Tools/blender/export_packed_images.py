#!/usr/bin/env python3
"""Export named packed Blender images without changing the source .blend."""

from __future__ import annotations

import argparse
import os
import sys

import bpy


def parse_args():
    argv = sys.argv
    argv = argv[argv.index("--") + 1:] if "--" in argv else []
    parser = argparse.ArgumentParser(description="Export packed images from the open Blender file")
    parser.add_argument("--project-root", required=True)
    parser.add_argument("--image", action="append", required=True, help="BlenderName=relative/output/path")
    return parser.parse_args(argv)


def main():
    args = parse_args()
    project_root = os.path.abspath(args.project_root)

    for mapping in args.image:
        source_name, separator, relative_output = mapping.partition("=")

        if not separator or not source_name or not relative_output:
            raise ValueError("--image must use BlenderName=relative/output/path")

        image = bpy.data.images.get(source_name)

        if image is None:
            raise KeyError(f"Packed image was not found: {source_name}")

        if image.packed_file is None:
            raise ValueError(f"Image is not packed in the Blender file: {source_name}")

        output_path = os.path.normpath(os.path.join(project_root, relative_output))

        if os.path.commonpath((project_root, output_path)) != project_root:
            raise ValueError(f"Output escapes project root: {relative_output}")

        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        with open(output_path, "wb") as output:
            output.write(image.packed_file.data)

        print(f"Exported packed image: {relative_output}")


if __name__ == "__main__":
    main()
