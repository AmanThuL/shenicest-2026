#!/usr/bin/env python3
"""Synthesize the ambience beds and water one-shots the audition library has no candidate for.

Every bed is built in the frequency domain: a spectrum with random phase, inverse-FFT'd over
exactly the loop length. The result is periodic by construction, so the loop point is sample-exact
with no crossfade — which is the whole reason these are synthesized rather than cut from a
recording. Any modulation on top uses frequencies that are integer multiples of 1/duration, for the
same reason.

These are placeholders with the right shape and length, not final sound design: they exist so a
wired bed is audible and mixable today. Replacing one is dropping a file with the same name.

    python3 Tools/audio/generate_beds.py [output-root]

output-root defaults to Assets/RootsDance/Audio; the script writes Ambience/*.wav and SFX/*.wav.
"""

import os
import sys

import numpy as np
from scipy.io import wavfile

SR = 48000


def circular_noise(n, rng):
    """White noise that is periodic over exactly n samples."""
    spectrum = rng.normal(size=n // 2 + 1) + 1j * rng.normal(size=n // 2 + 1)
    spectrum[0] = 0.0
    noise = np.fft.irfft(spectrum, n)
    return noise / np.max(np.abs(noise))


def shape(x, response):
    """Apply a magnitude response to a periodic signal, keeping it periodic."""
    freqs = np.fft.rfftfreq(len(x), 1.0 / SR)
    return np.fft.irfft(np.fft.rfft(x) * response(freqs), len(x))


def low_pass(cut, order=2):
    return lambda f: 1.0 / (1.0 + (f / cut) ** order)


def high_pass(cut, order=2):
    return lambda f: (f / cut) ** order / (1.0 + (f / cut) ** order)


def band(low, high, order=2):
    return lambda f: high_pass(low, order)(f) * low_pass(high, order)(f)


def resonance(centre, q=12.0, gain=6.0):
    def response(f):
        width = centre / q
        return 1.0 + gain / (1.0 + ((f - centre) / width) ** 2)

    return response


def combine(*responses):
    return lambda f: np.prod([r(f) for r in responses], axis=0)


def times(n):
    return np.arange(n) / SR


def tone(n, freq, duration):
    """A sine whose frequency is snapped to the nearest whole cycle count in the loop."""
    cycles = max(1, round(freq * duration))
    return np.sin(2.0 * np.pi * cycles * np.arange(n) / n)


def modulation(n, freq, duration, depth):
    """1 ± depth, wandering at freq, and periodic over the loop."""
    return 1.0 + depth * tone(n, freq, duration)


def bursts(n, duration, count, length, rng, offset=0.0):
    """`count` envelope bumps spread over the loop, none of them touching the loop point."""
    envelope = np.zeros(n)
    span = int(length * SR)
    window = np.hanning(span)
    margin = span + 1

    for i in range(count):
        centre = (i + 0.5 + offset) / count
        start = int(centre * (n - 2 * margin)) + margin
        envelope[start:start + span] += window * rng.uniform(0.6, 1.0)

    return np.clip(envelope, 0.0, 1.0)


def stereo(left, right, rms_target=0.063, peak_ceiling=0.5):
    """
    Two channels, scaled together so the image is kept, written as 16-bit.

    Beds are matched on RMS (about -24 dBFS) rather than on peak: a bed of sparse rustles and a
    bed of continuous rumble have very different crest factors, and peak-matching them would leave
    the sparse one inaudible under the same cue volume. The peak ceiling only catches the case
    where that scaling would clip.
    """
    both = np.stack([left, right], axis=1)
    both = both / np.sqrt(np.mean(both ** 2)) * rms_target
    peak = np.max(np.abs(both))

    if peak > peak_ceiling:
        both = both / peak * peak_ceiling

    return (both * 32767.0).astype(np.int16)


def mono(signal, peak=0.6):
    signal = signal / np.max(np.abs(signal)) * peak
    return (signal * 32767.0).astype(np.int16)


def bed(duration, build):
    """One bed: build(n, rng) per channel, with a different seed for each side."""
    n = int(duration * SR)
    return stereo(build(n, np.random.default_rng(1)), build(n, np.random.default_rng(2)))


# ---- the beds ------------------------------------------------------------------------------


def radio_static(n, rng):
    # Carrier hiss: bright, thin, and breathing slightly so it does not read as a flat tone.
    hiss = shape(circular_noise(n, rng), combine(high_pass(700, 1), low_pass(9000, 2)))
    crackle = shape(circular_noise(n, rng), band(2000, 6000, 3)) * bursts(n, 12, 9, 0.05, rng)
    return hiss * modulation(n, 0.4, 12, 0.25) + crackle * 0.5


def pipe_hum(n, rng):
    # Water in a pipe behind a wall: mains hum, its harmonics, and a low turbulent bed.
    hum = (tone(n, 50, 16) + 0.5 * tone(n, 100, 16) + 0.25 * tone(n, 150, 16)) * 0.08
    flow = shape(circular_noise(n, rng), combine(band(120, 900, 2), resonance(220, 8, 4))) * 2.0
    return hum * modulation(n, 0.25, 16, 0.15) + flow


def vent_fan(n, rng):
    # A fan is broadband air plus the tone of blades passing: 12 turns a second, eight blades.
    air = shape(circular_noise(n, rng), band(250, 5000, 2)) * 3.0
    blades = tone(n, 96, 12) * 0.08 + tone(n, 192, 12) * 0.03
    motor = tone(n, 100, 12) * 0.05
    return (air * modulation(n, 12, 12, 0.35) + blades + motor) * modulation(n, 0.3, 12, 0.1)


def maintenance_tunnel(n, rng):
    # Enclosed duct: rumble, two standing resonances, and a thin sheet of air above them.
    rumble = shape(circular_noise(n, rng),
                   combine(low_pass(180, 2), resonance(80, 14, 8), resonance(160, 14, 5)))
    air = shape(circular_noise(n, rng), band(1200, 6000, 2)) * 0.5
    return rumble * modulation(n, 0.15, 20, 0.2) * 0.8 + air


def corridor(n, rng):
    # Interior room tone: almost nothing, which is the point — it is what silence sounds like.
    tone_bed = shape(circular_noise(n, rng), combine(low_pass(700, 2), resonance(120, 10, 4)))
    air = shape(circular_noise(n, rng), band(1200, 7000, 2)) * 1.2
    electrical = tone(n, 60, 20) * 0.08 + tone(n, 120, 20) * 0.04
    return tone_bed * modulation(n, 0.1, 20, 0.15) + air + electrical


def greenhouse(n, rng):
    # Glass house: wind pressing on the panes, swelling twice across the loop, and leaves.
    wind = shape(circular_noise(n, rng), band(200, 3500, 2))
    swell = modulation(n, 0.1, 20, 0.35) * modulation(n, 0.15, 20, 0.25)
    leaves = shape(circular_noise(n, rng), band(2500, 9000, 3)) * bursts(n, 20, 6, 0.7, rng)
    glass = tone(n, 210, 20) * 0.05
    return wind * swell + leaves * 0.35 + glass


def underground_network(n, rng):
    # Under the floor: sub rumble that breathes, and the slow organic ticking of things growing.
    sub = shape(circular_noise(n, rng), combine(low_pass(90, 3), resonance(45, 10, 8)))
    breath = modulation(n, 0.1, 20, 0.4)
    ticks = shape(circular_noise(n, rng), band(700, 4000, 3)) * bursts(n, 20, 14, 0.04, rng)
    fibre = shape(circular_noise(n, rng), band(300, 1200, 2)) * bursts(n, 20, 5, 1.2, rng, 0.3)
    return sub * breath * 0.6 + ticks * 1.2 + fibre * 1.0


def scan_loop(n, rng):
    # The survey tool working: a soft carrier with a tremolo, and a sweep once per turn.
    carrier = tone(n, 1200, 4) * 0.35 * modulation(n, 8, 4, 0.5)
    sweep = shape(circular_noise(n, rng), band(600, 4000, 2)) * bursts(n, 4, 2, 0.35, rng)
    hum = tone(n, 300, 4) * 0.12
    return carrier + sweep * 0.5 + hum


def plant_on_structure(n, rng):
    # Leaves and vines moving against a metal building: dry rustles over a faint sheet resonance.
    rustle = shape(circular_noise(n, rng), band(1500, 8000, 3)) * bursts(n, 16, 9, 0.55, rng)
    sheet = shape(circular_noise(n, rng),
                  combine(band(150, 900, 2), resonance(320, 16, 6))) * 0.18
    return rustle + sheet * modulation(n, 0.2, 16, 0.3)


BEDS = [
    ("Radio_Static_Loop.wav", 12, radio_static),
    ("Pipe_Hum_Loop.wav", 16, pipe_hum),
    ("Vent_Fan_Loop.wav", 12, vent_fan),
    ("Maintenance_Tunnel_Loop.wav", 20, maintenance_tunnel),
    ("Corridor_Loop.wav", 20, corridor),
    ("Greenhouse_Loop.wav", 20, greenhouse),
    ("Underground_Network_Loop.wav", 20, underground_network),
    ("Scan_Loop.wav", 4, scan_loop),
    ("Plant_On_Structure_Loop.wav", 16, plant_on_structure),
]


# ---- the water one-shots -------------------------------------------------------------------


def water_drip(pitch, seed):
    """A drip is a short resonant blip that bends upward — that rise is what reads as water."""
    rng = np.random.default_rng(seed)
    n = int(0.35 * SR)
    t = times(n)
    bend = pitch * (1.0 + 0.35 * (1.0 - np.exp(-t * 28.0)))
    body = np.sin(2.0 * np.pi * np.cumsum(bend) / SR) * np.exp(-t * 26.0)
    splash = rng.normal(size=n) * np.exp(-t * 220.0) * 0.25
    return body + splash


def water_trickle(seed, duration=4.0):
    """Running water: a narrow band of noise, bubbling, faded in and out so it can be a one-shot."""
    rng = np.random.default_rng(seed)
    n = int(duration * SR)
    stream = shape(circular_noise(n, rng), band(900, 6000, 2))
    bubble = 1.0 + 0.4 * np.sin(2.0 * np.pi * 3.1 * times(n)) * np.sin(2.0 * np.pi * 0.7 * times(n))
    fade = np.minimum(1.0, np.minimum(times(n) * 6.0, (duration - times(n)) * 6.0))
    return stream * bubble * fade


ONE_SHOTS = [
    ("Water_Drip_01.wav", lambda: water_drip(1150, 11)),
    ("Water_Drip_02.wav", lambda: water_drip(880, 12)),
    ("Water_Drip_03.wav", lambda: water_drip(1420, 13)),
    ("Water_Trickle_01.wav", lambda: water_trickle(14)),
]


def main():
    root = sys.argv[1] if len(sys.argv) > 1 else "Assets/RootsDance/Audio"
    ambience = os.path.join(root, "Ambience")
    sfx = os.path.join(root, "SFX")
    os.makedirs(ambience, exist_ok=True)
    os.makedirs(sfx, exist_ok=True)

    for name, duration, build in BEDS:
        data = bed(duration, build)
        wavfile.write(os.path.join(ambience, name), SR, data)
        seam = abs(int(data[0][0]) - int(data[-1][0])) / 32767.0
        level = np.sqrt(np.mean((data / 32767.0) ** 2))
        print(f"  {name:34s} {duration:5.1f}s  peak {np.max(np.abs(data)) / 32767.0:.2f}"
              f"  rms {20 * np.log10(level):6.1f} dBFS  seam step {seam:.4f}")

    for name, build in ONE_SHOTS:
        data = mono(build())
        wavfile.write(os.path.join(sfx, name), SR, data)
        print(f"  {name:34s} {len(data) / SR:5.2f}s  peak {np.max(np.abs(data)) / 32767.0:.2f}")


if __name__ == "__main__":
    main()
