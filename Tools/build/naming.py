"""Naming convention for build artifacts. Pure logic — no I/O, no side effects.

The convention is documented in docs/architecture/tooling/build-and-packaging.md.
This module is the only place it is implemented.
"""
import re

BASE_NAME = "RootsDance"

PLATFORM_BY_PROFILE = {
    "macOS-Release": "macOS",
    "Windows-Release": "Windows",
}

_BUNDLE_VERSION_RE = re.compile(r"^\s*bundleVersion:\s*(\S+)\s*$", re.MULTILINE)


def platform_for_profile(profile):
    """Return the platform token for a build profile name."""
    try:
        return PLATFORM_BY_PROFILE[profile]
    except KeyError:
        known = ", ".join(sorted(PLATFORM_BY_PROFILE))
        raise ValueError("unknown build profile '{0}'; known profiles: {1}".format(profile, known))


def parse_bundle_version(text):
    """Extract bundleVersion from the text of ProjectSettings/ProjectSettings.asset."""
    match = _BUNDLE_VERSION_RE.search(text)
    if match is None:
        raise ValueError("no 'bundleVersion:' line found in ProjectSettings.asset")
    return match.group(1)


def zip_stem(platform, version, date, sha, dirty, dev):
    """Build the zip file name without its .zip extension."""
    stem = "{0}_{1}_v{2}_{3}_{4}".format(BASE_NAME, platform, version, date, sha)
    if dirty:
        stem += "-dirty"
    if dev:
        stem += "-dev"
    return stem
