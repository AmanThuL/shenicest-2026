#!/usr/bin/env python3
"""Build a seamless grayscale emission map for the Chapter House undercroft.

The 3D mycelium carries the close silhouette and breathing. This map supplies the dense,
distant network that would be wasteful as swept-tube geometry.

    python3 Tools/textures/make_mycelium_emission.py
    python3 Tools/textures/make_mycelium_emission.py --out /tmp/MyceliumNetwork_Emission.png
"""
import argparse
import os

import numpy as np
from PIL import Image


SIZE = 1024


def band_noise(size, seed, minimum, maximum, beta=1.0):
    """Perfectly tiling spectral noise within one frequency band."""
    random = np.random.default_rng(seed)
    spectrum = np.fft.fft2(random.normal(size=(size, size)))
    fy = np.fft.fftfreq(size)[:, None] * size
    fx = np.fft.fftfreq(size)[None, :] * size
    radius = np.sqrt(fx * fx + fy * fy)
    radius[0, 0] = 1.0
    frequency_filter = radius ** (-beta)
    frequency_filter[(radius < minimum) | (radius > maximum)] = 0.0
    field = np.real(np.fft.ifft2(spectrum * frequency_filter))
    return (field - field.mean()) / (field.std() + 1e-9)


def warp(field, x_offset, y_offset, amount):
    """Wrap-around bilinear warp, preserving seamless tile edges."""
    size = field.shape[0]
    yy, xx = np.mgrid[0:size, 0:size].astype(np.float32)
    sample_x = (xx + x_offset * amount) % size
    sample_y = (yy + y_offset * amount) % size
    x0 = np.floor(sample_x).astype(int) % size
    y0 = np.floor(sample_y).astype(int) % size
    x1 = (x0 + 1) % size
    y1 = (y0 + 1) % size
    tx = sample_x - np.floor(sample_x)
    ty = sample_y - np.floor(sample_y)
    return ((field[y0, x0] * (1.0 - tx) + field[y0, x1] * tx) * (1.0 - ty)
            + (field[y1, x0] * (1.0 - tx) + field[y1, x1] * tx) * ty)


def periodic_blur(field, sigma):
    """Gaussian blur in frequency space so the glow also tiles cleanly."""
    size = field.shape[0]
    fy = np.fft.fftfreq(size)[:, None]
    fx = np.fft.fftfreq(size)[None, :]
    kernel = np.exp(-2.0 * np.pi * np.pi * sigma * sigma * (fx * fx + fy * fy))
    return np.real(np.fft.ifft2(np.fft.fft2(field) * kernel))


def build_texture(size):
    warp_x = band_noise(size, 101, 2, 9, 1.1)
    warp_y = band_noise(size, 202, 2, 9, 1.1)
    coarse = warp(band_noise(size, 11, 3, 18, 0.8), warp_x, warp_y, 34.0)
    fine = warp(band_noise(size, 29, 12, 55, 0.65), warp_y, warp_x, 13.0)

    # Zero contours make connected, branching lines rather than cloudy noise.
    coarse_lines = np.exp(-np.square(np.abs(coarse) / 0.105))
    fine_lines = np.exp(-np.square(np.abs(fine) / 0.085))
    colony = band_noise(size, 47, 2, 12, 1.2)
    colony = np.clip(colony * 0.32 + 0.72, 0.0, 1.0)
    core = np.maximum(coarse_lines, fine_lines * 0.62) * colony
    core = np.clip((core - 0.18) / 0.82, 0.0, 1.0)
    glow = periodic_blur(core, 2.4)
    emission = np.clip(core * 0.82 + glow * 0.42, 0.0, 1.0)
    return (np.power(emission, 0.8) * 255.0).astype(np.uint8)


def main():
    parser = argparse.ArgumentParser(description="build a tiling mycelium emission map")
    default = os.path.normpath(os.path.join(
        os.path.dirname(__file__), "..", "..", "Assets", "RootsDance", "Textures",
        "Environment", "ChapterHouse", "MyceliumNetwork_Emission.png"))
    parser.add_argument("--out", default=default)
    args = parser.parse_args()

    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    Image.fromarray(build_texture(SIZE), mode="L").save(args.out, optimize=True)
    print("wrote", args.out, (SIZE, SIZE))


if __name__ == "__main__":
    main()
