import numpy as np, os, sys
from PIL import Image
OUT = sys.argv[1]; N = 1024
os.makedirs(OUT, exist_ok=True)

def band_noise(n, seed, fmin, fmax, beta=1.0):
    """Perfectly tiling fractal noise: white noise shaped in the frequency domain."""
    rs = np.random.default_rng(seed)
    F = np.fft.fft2(rs.normal(size=(n, n)))
    fy = np.fft.fftfreq(n)[:, None]*n
    fx = np.fft.fftfreq(n)[None, :]*n
    r = np.sqrt(fx**2 + fy**2); r[0, 0] = 1.0
    filt = r**(-beta)
    filt[(r < fmin) | (r > fmax)] = 0.0
    o = np.real(np.fft.ifft2(F*filt))
    return (o - o.mean())/(o.std() + 1e-9)

def ridged(x):
    """fold the noise -> crease lines, which is what a crumpled film actually has"""
    return 1.0 - np.abs(np.tanh(x*0.9))

def warp(field, wx, wy, amt):
    """bilinear resample with wrap-around, so the tile stays seamless"""
    n = field.shape[0]
    yy, xx = np.mgrid[0:n, 0:n].astype(np.float32)
    sx = (xx + wx*amt) % n; sy = (yy + wy*amt) % n
    x0 = np.floor(sx).astype(int) % n; y0 = np.floor(sy).astype(int) % n
    x1 = (x0+1) % n; y1 = (y0+1) % n
    tx = (sx-np.floor(sx))[..., None][..., 0]; ty = (sy-np.floor(sy))[..., None][..., 0]
    return ((field[y0, x0]*(1-tx) + field[y0, x1]*tx)*(1-ty) +
            (field[y1, x0]*(1-tx) + field[y1, x1]*tx)*ty)

wx = band_noise(N, 101, 2, 10, 1.1)
wy = band_noise(N, 202, 2, 10, 1.1)

fold_big   = ridged(warp(band_noise(N, 1,  3, 14,  1.0), wx, wy, 26))   # large crumple folds
fold_med   = ridged(warp(band_noise(N, 2, 14, 42,  1.0), wx, wy, 12))   # 褶皱
fold_fine  = ridged(warp(band_noise(N, 3, 42, 96,  1.0), wx, wy, 5))    # 细碎

h = fold_big*0.50 + fold_med*0.33 + fold_fine*0.17
h = (h - h.min())/(h.max() - h.min())

STRENGTH = 2.2
gy, gx = np.gradient(h.astype(np.float32))
nx, ny, nz = -gx*STRENGTH*N/32.0, -gy*STRENGTH*N/32.0, np.ones_like(h)
l = np.sqrt(nx*nx + ny*ny + nz*nz)
nrm = np.stack([nx/l*0.5+0.5, ny/l*0.5+0.5, nz/l*0.5+0.5], -1)

# thickness / density: where the film is thick vs almost worn through
d = band_noise(N, 55, 2, 12, 1.15)
d = (d - d.min())/(d.max() - d.min())
dens = np.clip(d*1.25 - 0.10, 0, 1)

Image.fromarray((nrm*255).astype(np.uint8)).save(f"{OUT}/Algae_Wrinkle_Normal.png")
Image.fromarray((h*255).astype(np.uint8)).save(f"{OUT}/Algae_Wrinkle_Height.png")
Image.fromarray((dens*255).astype(np.uint8)).save(f"{OUT}/Algae_Density.png")
print("MAPS_OK")
