#!/usr/bin/env python3
"""Build and package a RootsDance player.

Usage:  python3 Tools/build/build.py [PROFILE] [--dev] [--package-only] [--dry-run]
                                     [--force] [--output-dir DIR] [--unity PATH] [-v]

The convention and the rationale live in docs/architecture/tooling/build-and-packaging.md.
Exit codes: 0 ok, 1 preflight/usage, 2 Unity build failed, 3 packaging failed.
"""
import argparse
import datetime
import hashlib
import json
import os
import platform
import shutil
import subprocess
import sys
import time
import zipfile

from naming import parse_bundle_version, platform_for_profile, zip_stem

EXIT_OK = 0
EXIT_PREFLIGHT = 1
EXIT_BUILD = 2
EXIT_PACKAGE = 3

BUILD_METHOD = "RootsDance.Editor.Build.BuildScript.BuildFromCommandLine"
PROFILE_FOLDER = "Assets/RootsDance/Settings/BuildProfiles"
APP_NAME = "RootsDance"

RUN_README = """{stem}

Requires macOS 12 or newer on an Apple Silicon Mac.

Double-click {app}. If macOS says the app is damaged or from an unidentified
developer, that is Gatekeeper quarantining an unsigned download, not a broken
build. Either right-click the app and choose Open, or run:

    xattr -dr com.apple.quarantine "{app}"

Built from commit {sha} on {date}.
"""


class PreflightError(Exception):
    """A problem found before Unity is launched. Message names the fix."""


def repo_root():
    return os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def git_state(repo):
    """Return (short_sha, dirty)."""
    sha = subprocess.run(["git", "-C", repo, "rev-parse", "--short=7", "HEAD"],
                         capture_output=True, text=True, check=True).stdout.strip()
    status = subprocess.run(["git", "-C", repo, "status", "--porcelain"],
                            capture_output=True, text=True, check=True).stdout.strip()
    return sha, bool(status)


def editor_is_running(repo):
    """True when a Unity Editor holds this project path."""
    instance = os.path.join(repo, "Library", "EditorInstance.json")
    if not os.path.exists(instance):
        return False
    try:
        with open(instance) as handle:
            pid = int(json.load(handle).get("process_id", 0))
    except (ValueError, OSError):
        return False
    if pid <= 0:
        return False
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    return True


def editor_version(repo):
    with open(os.path.join(repo, "ProjectSettings", "ProjectVersion.txt")) as handle:
        for line in handle:
            if line.startswith("m_EditorVersion:"):
                return line.split(":", 1)[1].strip()
    raise PreflightError("No m_EditorVersion in ProjectSettings/ProjectVersion.txt")


def resolve_unity(override, version):
    """Find the Unity binary: --unity, then $UNITY_EDITOR, then the known install paths."""
    if override:
        if not os.path.exists(override):
            raise PreflightError("--unity path does not exist: " + override)
        return override

    candidates = []
    env = os.environ.get("UNITY_EDITOR")
    if env:
        candidates.append(env)
    candidates.append("/Applications/Unity/Unity-{0}/Unity.app/Contents/MacOS/Unity".format(version))
    candidates.append("/Applications/Unity/Hub/Editor/{0}/Unity.app/Contents/MacOS/Unity".format(version))

    for candidate in candidates:
        if os.path.exists(candidate):
            return candidate
    raise PreflightError(
        "Unity {0} not found. Tried:\n  {1}\nPass --unity <path> or set $UNITY_EDITOR.".format(
            version, "\n  ".join(candidates)))


def module_installed(unity_binary, target_platform):
    """True when the playback engine for this platform is installed."""
    contents = os.path.dirname(os.path.dirname(unity_binary))
    folder = "MacStandaloneSupport" if target_platform == "macOS" else "WindowsStandaloneSupport"
    return os.path.isdir(os.path.join(contents, "PlaybackEngines", folder))


def enabled_scenes(repo):
    """Return the paths of scenes marked enabled: 1 in EditorBuildSettings.asset."""
    path = os.path.join(repo, "ProjectSettings", "EditorBuildSettings.asset")
    with open(path) as handle:
        lines = handle.readlines()

    scenes = []
    pending_enabled = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("- enabled:"):
            pending_enabled = stripped == "- enabled: 1"
        elif stripped.startswith("enabled:"):
            pending_enabled = stripped == "enabled: 1"
        elif stripped.startswith("path:") and pending_enabled:
            scenes.append(stripped.split(":", 1)[1].strip())
            pending_enabled = False
    return scenes


def preflight(repo, profile, target_platform, unity_binary, package_only, dry_run=False):
    asset = os.path.join(repo, PROFILE_FOLDER, profile + ".asset")
    if not os.path.exists(asset):
        available = sorted(
            name[:-6] for name in os.listdir(os.path.join(repo, PROFILE_FOLDER))
            if name.endswith(".asset"))
        raise PreflightError(
            "No build profile '{0}'. Available: {1}\nRun the Editor menu "
            "RootsDance > Build > Create Default Build Profiles to create them.".format(
                profile, ", ".join(available) if available else "(none)"))

    if package_only:
        return

    host = "macOS" if platform.system() == "Darwin" else "Windows"
    if target_platform != host:
        raise PreflightError(
            "Cannot build {0} on {1}. Build {0} on a {0} machine.".format(target_platform, host))

    if not module_installed(unity_binary, target_platform):
        raise PreflightError(
            "{0} build support is not installed for this Editor.\n"
            "Install it via Unity Hub, or: unity install --version {1} --module <module>".format(
                target_platform, editor_version(repo)))

    if not dry_run and editor_is_running(repo):
        raise PreflightError(
            "A Unity Editor has this project open. Close it — one Editor instance per project.")

    if target_platform == "macOS" and shutil.which("xcodebuild") is None:
        raise PreflightError("IL2CPP macOS builds require Xcode. Install it, then run xcode-select --install.")

    scenes = enabled_scenes(repo)
    if len(scenes) == 0:
        raise PreflightError(
            "No scenes are enabled in ProjectSettings/EditorBuildSettings.asset — the build would be empty.")

    print("scenes ({0}):".format(len(scenes)))
    for scene in scenes:
        print("  " + scene)


def run_unity_build(unity_binary, repo, profile, output_path, dev, verbose):
    log_path = os.path.join(repo, "Logs", "build-{0}.log".format(profile))
    os.makedirs(os.path.dirname(log_path), exist_ok=True)

    command = [
        unity_binary, "-batchmode", "-quit", "-projectPath", repo,
        "-executeMethod", BUILD_METHOD,
        "-rdProfile", profile, "-rdOutput", output_path,
        "-logFile", log_path,
    ]
    if dev:
        command.append("-rdDev")

    print("Building {0}{1}".format(profile, " (development)" if dev else ""))
    print("  log: {0}".format(log_path))
    print("  An IL2CPP build takes a while — 10-25 minutes is normal, and batch mode is silent.")
    if verbose:
        print("  " + " ".join(command))

    started = time.time()
    process = subprocess.Popen(command)
    while process.poll() is None:
        time.sleep(10)
        print("  ... {0:.0f}s".format(time.time() - started), flush=True)
    elapsed = time.time() - started

    # A zero exit is authoritative for success. A non-zero exit can still mean
    # "succeeded, then timed out waiting on async operations", so trust the output.
    if process.returncode != 0 and not os.path.exists(output_path):
        print(tail(log_path, 40), file=sys.stderr)
        raise SystemExit(EXIT_BUILD)
    print("Build finished in {0:.0f}s".format(elapsed))


def tail(path, lines):
    try:
        with open(path, errors="replace") as handle:
            return "".join(handle.readlines()[-lines:])
    except OSError:
        return "(no log at {0})".format(path)


def package(repo, build_dir, stem, output_dir, target_platform, sha, dirty, version, profile, dev, force):
    zip_path = os.path.join(output_dir, stem + ".zip")
    if os.path.exists(zip_path) and not force:
        raise SystemExit(
            "Refusing to overwrite {0}\nPass --force to replace it.".format(zip_path))

    staging_root = os.path.join(repo, "Builds", ".staging")
    staging = os.path.join(staging_root, stem)
    shutil.rmtree(staging_root, ignore_errors=True)
    os.makedirs(staging)

    try:
        for entry in sorted(os.listdir(build_dir)):
            source = os.path.join(build_dir, entry)
            destination = os.path.join(staging, entry)
            if target_platform == "macOS":
                # ditto preserves the symlinks and permission bits inside a .app bundle;
                # shutil.copytree and zipfile do not, and the copied app will not launch.
                subprocess.run(["ditto", source, destination], check=True)
            elif os.path.isdir(source):
                shutil.copytree(source, destination)
            else:
                shutil.copy2(source, destination)

        app_name = APP_NAME + ".app"
        with open(os.path.join(staging, "build-info.json"), "w") as handle:
            json.dump({
                "product": APP_NAME,
                "version": version,
                "commit": sha,
                "dirty": dirty,
                "development": dev,
                "profile": profile,
                "platform": target_platform,
                "unityVersion": editor_version(repo),
                "builtAt": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
            }, handle, indent=2)
            handle.write("\n")

        if target_platform == "macOS":
            with open(os.path.join(staging, "README.txt"), "w") as handle:
                handle.write(RUN_README.format(
                    stem=stem, app=app_name, sha=sha,
                    date=datetime.date.today().isoformat()))

        os.makedirs(output_dir, exist_ok=True)
        if target_platform == "macOS":
            subprocess.run(
                ["ditto", "-c", "-k", "--sequesterRsrc", "--keepParent", staging, zip_path],
                check=True)
        else:
            with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as archive:
                for folder, _dirs, files in os.walk(staging):
                    for name in files:
                        full = os.path.join(folder, name)
                        archive.write(full, os.path.join(stem, os.path.relpath(full, staging)))
    finally:
        shutil.rmtree(staging_root, ignore_errors=True)

    return zip_path


def sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main(argv=None):
    parser = argparse.ArgumentParser(description="Build and package a RootsDance player.")
    parser.add_argument("profile", nargs="?", default="macOS-Release")
    parser.add_argument("--dev", action="store_true", help="development build; tags the zip -dev")
    parser.add_argument("--package-only", action="store_true", help="package an existing build")
    parser.add_argument("--dry-run", action="store_true", help="print the plan and exit")
    parser.add_argument("--force", action="store_true", help="overwrite an existing zip")
    parser.add_argument("--output-dir", default=None, help="where the zip goes (default Builds/)")
    parser.add_argument("--unity", default=None, help="path to the Unity binary")
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    repo = repo_root()
    try:
        target_platform = platform_for_profile(args.profile)
        version_text = open(os.path.join(repo, "ProjectSettings", "ProjectSettings.asset"),
                            errors="replace").read()
        version = parse_bundle_version(version_text)
        unity_binary = resolve_unity(args.unity, editor_version(repo))
        preflight(repo, args.profile, target_platform, unity_binary, args.package_only, dry_run=args.dry_run)
    except (PreflightError, ValueError) as error:
        print("error: {0}".format(error), file=sys.stderr)
        return EXIT_PREFLIGHT

    sha, dirty = git_state(repo)
    stem = zip_stem(target_platform, version, datetime.date.today().strftime("%Y%m%d"),
                    sha, dirty, args.dev)
    build_dir = os.path.join(repo, "Builds", args.profile)
    extension = ".app" if target_platform == "macOS" else ".exe"
    output_path = os.path.join(build_dir, APP_NAME + extension)
    output_dir = args.output_dir or os.path.join(repo, "Builds")

    if args.dry_run:
        print("profile:  {0}{1}".format(args.profile, " (dev)" if args.dev else ""))
        print("unity:    {0}".format(unity_binary))
        print("player:   {0}".format(output_path))
        print("zip:      {0}".format(os.path.join(output_dir, stem + ".zip")))
        if dirty:
            print("note:     working tree is dirty, the zip is tagged -dirty")
        return EXIT_OK

    if not args.package_only:
        shutil.rmtree(build_dir, ignore_errors=True)
        os.makedirs(build_dir, exist_ok=True)
        run_unity_build(unity_binary, repo, args.profile, output_path, args.dev, args.verbose)

    if not os.path.exists(output_path):
        print("error: no player at {0}. Build first, or drop --package-only.".format(output_path),
              file=sys.stderr)
        return EXIT_PACKAGE

    try:
        zip_path = package(repo, build_dir, stem, output_dir, target_platform,
                           sha, dirty, version, args.profile, args.dev, args.force)
    except (subprocess.CalledProcessError, OSError) as error:
        print("error: packaging failed: {0}".format(error), file=sys.stderr)
        return EXIT_PACKAGE

    size_mb = os.path.getsize(zip_path) / (1024.0 * 1024.0)
    print("\n{0}\n  {1:.1f} MB\n  sha256 {2}".format(zip_path, size_mb, sha256(zip_path)))
    return EXIT_OK


if __name__ == "__main__":
    sys.exit(main())
