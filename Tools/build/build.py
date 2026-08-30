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
import shlex
import shutil
import subprocess
import sys
import time
import zipfile

from naming import parse_bundle_version, platform_for_profile, zip_stem
import windows as windows_tools

EXIT_OK = 0
EXIT_PREFLIGHT = 1
EXIT_BUILD = 2
EXIT_PACKAGE = 3

BUILD_METHOD = "RootsDance.Editor.Build.BuildScript.BuildFromCommandLine"
PROFILE_FOLDER = "Assets/RootsDance/Settings/BuildProfiles"
APP_NAME = "RootsDance"
BUILD_INFO_FILE = "build-info.json"

# Unity's IL2CPP backend drops these next to the player it builds. Their own folder
# names say not to ship them (multi-gigabyte debug symbols / Burst debug info), and the
# prefix varies with productName, so match by suffix instead of by exact name.
EXCLUDED_SIDECAR_SUFFIXES = (
    "_BackUpThisFolder_ButDontShipItWithYourGame",
    "_BurstDebugInformation_DoNotShip",
)

RUN_README = """{stem}

Requires macOS 12 or newer on an Apple Silicon Mac.

Double-click {app}. If macOS says the app is damaged or from an unidentified
developer, that is Gatekeeper quarantining an unsigned download, not a broken
build. Either right-click the app and choose Open, or run:

    xattr -dr com.apple.quarantine "{app}"

Built from commit {sha} on {date}.
"""

WINDOWS_RUN_README = """{stem}

Windows x64 player. Extract the entire zip to a folder, then launch RootsDance.exe.
Keep UnityPlayer.dll, GameAssembly.dll, RootsDance_Data and the other shipped files
beside the executable; do not copy only the .exe. HDRP requires a compatible GPU.

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
        with open(instance, encoding="utf-8") as handle:
            pid = int(json.load(handle).get("process_id", 0))
    except (ValueError, TypeError, AttributeError, OSError):
        return False
    if pid <= 0:
        return False
    if platform.system() == "Windows":
        return windows_tools.process_is_running(pid)
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    return True


def editor_version(repo):
    with open(os.path.join(repo, "ProjectSettings", "ProjectVersion.txt"), encoding="utf-8") as handle:
        for line in handle:
            if line.startswith("m_EditorVersion:"):
                return line.split(":", 1)[1].strip()
    raise PreflightError("No m_EditorVersion in ProjectSettings/ProjectVersion.txt")


def resolve_unity(override, version):
    """Find the Unity binary: --unity, then $UNITY_EDITOR, then the known install paths."""
    if override:
        if not os.path.isfile(override):
            raise PreflightError("--unity must point to the Editor executable: " + override)
        return override

    candidates = []
    env = os.environ.get("UNITY_EDITOR")
    if env:
        candidates.append(env)
    if platform.system() == "Windows":
        candidates.extend(windows_tools.unity_candidates(version))
    else:
        candidates.append("/Applications/Unity/Unity-{0}/Unity.app/Contents/MacOS/Unity".format(version))
        candidates.append("/Applications/Unity/Hub/Editor/{0}/Unity.app/Contents/MacOS/Unity".format(version))

    for candidate in candidates:
        if os.path.isfile(candidate):
            return candidate
    raise PreflightError(
        "Unity {0} not found. Tried:\n  {1}\nPass --unity <path> or set $UNITY_EDITOR.".format(
            version, "\n  ".join(candidates)))


def module_installed(unity_binary, target_platform):
    """True when the playback engine for this platform is installed."""
    if platform.system() == "Windows":
        contents = os.path.join(os.path.dirname(unity_binary), "Data")
    else:
        contents = os.path.dirname(os.path.dirname(unity_binary))
    folder = "MacStandaloneSupport" if target_platform == "macOS" else "WindowsStandaloneSupport"
    return os.path.isdir(os.path.join(contents, "PlaybackEngines", folder))


def windows_il2cpp_installed(unity_binary, dev):
    variant = "win64_player_{0}_il2cpp".format("development" if dev else "nondevelopment")
    return os.path.isdir(os.path.join(os.path.dirname(unity_binary), "Data", "PlaybackEngines",
                                     "WindowsStandaloneSupport", "Variations", variant))


def enabled_scenes(repo):
    """Return the paths of scenes marked enabled: 1 in EditorBuildSettings.asset."""
    path = os.path.join(repo, "ProjectSettings", "EditorBuildSettings.asset")
    with open(path, encoding="utf-8") as handle:
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


def preflight(repo, profile, target_platform, unity_binary, package_only, dry_run=False, dev=False):
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

    host = {"Darwin": "macOS", "Windows": "Windows"}.get(platform.system(), platform.system())
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
    if target_platform == "Windows":
        if not windows_il2cpp_installed(unity_binary, dev):
            raise PreflightError(
                "Windows Build Support (IL2CPP) is missing for this Editor/build variant. "
                "Add that module in Unity Hub; Mono support alone is insufficient.")
        compiler, sdk = windows_tools.validate_toolchain()
        print("MSVC: " + compiler)
        print("Windows SDK: " + sdk)

    scenes = enabled_scenes(repo)
    if len(scenes) == 0:
        raise PreflightError(
            "No scenes are enabled in ProjectSettings/EditorBuildSettings.asset — the build would "
            "be empty. Enable at least one in File > Build Profiles > Scene List (Bootstrap first).")

    print("scenes ({0}):".format(len(scenes)))
    for scene in scenes:
        print("  " + scene)


def unity_build_command(unity_binary, repo, profile, output_path, dev, log_path):
    command = [
        unity_binary, "-batchmode", "-quit", "-projectPath", repo,
        "-buildTarget", "StandaloneWindows64" if platform_for_profile(profile) == "Windows" else "StandaloneOSX",
        "-executeMethod", BUILD_METHOD,
        "-rdProfile", profile, "-rdOutput", output_path,
        "-logFile", log_path,
    ]
    if dev:
        command.append("-rdDev")
    return command


def format_command(command):
    return subprocess.list2cmdline(command) if platform.system() == "Windows" else shlex.join(command)


def build_log_path(repo, profile):
    return os.path.join(repo, "Logs", "build-{0}.log".format(profile))


def build_succeeded(profile, log_text):
    """True when BuildScript's own success marker is present in the log.

    Exit code alone is not trustworthy: Unity can report a non-zero exit after
    "Timeout after 300 seconds while waiting async operations to finish" even
    though BuildPipeline.BuildPlayer already succeeded. It can also report a
    zero-ish exit while StrictMode or an IL2CPP/link failure happened after the
    .app skeleton was already written to disk, which existence-of-output alone
    would miss. Trust BuildScript.cs's own marker line instead of either signal.
    """
    return "[BuildScript] {0}: result=Succeeded".format(profile) in log_text


def run_unity_build(unity_binary, repo, profile, output_path, dev, verbose):
    log_path = build_log_path(repo, profile)

    command = unity_build_command(unity_binary, repo, profile, output_path, dev, log_path)

    print("Building {0}{1}".format(profile, " (development)" if dev else ""))
    print("  log: {0}".format(log_path))
    print("  An IL2CPP build takes a while — 10-25 minutes is normal, and batch mode is silent.")
    if verbose:
        print("  " + format_command(command))

    started = time.time()
    try:
        os.makedirs(os.path.dirname(log_path), exist_ok=True)
        # An early launch failure may leave Unity unable to open its log. Never
        # let a previous invocation's success marker authorize this build.
        with open(log_path, "w"):
            pass
        process = subprocess.Popen(command)
    except OSError as error:
        print("error: could not launch Unity build: {0}".format(error), file=sys.stderr)
        raise SystemExit(EXIT_BUILD)
    while process.poll() is None:
        time.sleep(10)
        print("  ... {0:.0f}s".format(time.time() - started), flush=True)
    elapsed = time.time() - started

    if not build_succeeded(profile, read_log(log_path)):
        print(tail(log_path, 40), file=sys.stderr)
        raise SystemExit(EXIT_BUILD)
    print("Build finished in {0:.0f}s".format(elapsed))


def read_log(path):
    try:
        with open(path, encoding="utf-8", errors="replace") as handle:
            return handle.read()
    except OSError:
        return ""


def tail(path, lines):
    try:
        with open(path, encoding="utf-8", errors="replace") as handle:
            return "".join(handle.readlines()[-lines:])
    except OSError:
        return "(no log at {0})".format(path)


def stageable_entries(names):
    """Return the names to copy into the staged build, dropping Unity's debug sidecars."""
    return [name for name in names if not name.endswith(EXCLUDED_SIDECAR_SUFFIXES)]


def snapshot_build_info(repo, profile, target_platform, dev):
    with open(os.path.join(repo, "ProjectSettings", "ProjectSettings.asset"),
              encoding="utf-8", errors="replace") as handle:
        version = parse_bundle_version(handle.read())
    sha, dirty = git_state(repo)
    return {
        "product": APP_NAME,
        "version": version,
        "commit": sha,
        "dirty": dirty,
        "development": dev,
        "profile": profile,
        "platform": target_platform,
        "unityVersion": editor_version(repo),
        "builtAt": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
    }


def write_build_info(build_dir, info):
    path = os.path.join(build_dir, BUILD_INFO_FILE)
    temporary = path + ".tmp"
    try:
        with open(temporary, "w", encoding="utf-8") as handle:
            json.dump(info, handle, indent=2)
            handle.write("\n")
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.remove(temporary)


def load_build_info(build_dir, profile, target_platform, dev):
    """Read original provenance; never guess it from a newer checkout."""
    path = os.path.join(build_dir, BUILD_INFO_FILE)
    try:
        with open(path, encoding="utf-8") as handle:
            info = json.load(handle)
        if not isinstance(info, dict):
            raise ValueError("expected a JSON object")
        for field in ("product", "version", "commit", "profile", "platform", "unityVersion", "builtAt"):
            if not isinstance(info.get(field), str) or not info[field]:
                raise ValueError("missing or invalid " + field)
        for field in ("dirty", "development"):
            if type(info.get(field)) is not bool:
                raise ValueError("missing or invalid " + field)
        for field in ("version", "commit"):
            if any(character in info[field] for character in "/\\\0\n\r"):
                raise ValueError("invalid filename component: " + field)
        if (info["product"] != APP_NAME or info["profile"] != profile
                or info["platform"] != target_platform):
            raise ValueError("product, profile or platform does not match the requested player")
        built_at = datetime.datetime.fromisoformat(info["builtAt"])
        if built_at.utcoffset() is None:
            raise ValueError("builtAt must include a timezone")
    except (OSError, ValueError) as error:
        raise PreflightError(
            "Cannot reuse {0}: {1}. Rebuild without --package-only to record provenance.".format(path, error))
    if dev and not info["development"]:
        raise PreflightError(
            "--dev cannot relabel an existing release player. Rebuild with --dev, or omit --dev.")
    return info


def package(repo, build_dir, stem, output_dir, info):
    target_platform = info["platform"]
    zip_path = os.path.join(output_dir, stem + ".zip")

    staging_root = os.path.join(repo, "Builds", ".staging")
    staging = os.path.join(staging_root, stem)
    shutil.rmtree(staging_root, ignore_errors=True)
    os.makedirs(staging)

    try:
        all_entries = sorted(os.listdir(build_dir))
        keep = set(stageable_entries(all_entries))
        for entry in all_entries:
            if entry not in keep:
                print("  skip: {0} (Unity debug sidecar, not shipped)".format(entry))
                continue
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
        write_build_info(staging, info)

        readme = RUN_README if target_platform == "macOS" else WINDOWS_RUN_README
        with open(os.path.join(staging, "README.txt"), "w", encoding="utf-8") as handle:
            handle.write(readme.format(
                stem=stem, app=app_name, sha=info["commit"],
                date=datetime.datetime.fromisoformat(info["builtAt"]).date().isoformat()))

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
    parser.add_argument("profile", nargs="?",
                        default="Windows-Release" if platform.system() == "Windows" else "macOS-Release")
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
        build_dir = os.path.join(repo, "Builds", args.profile)
        if args.package_only:
            info = load_build_info(build_dir, args.profile, target_platform, args.dev)
        else:
            unity_binary = resolve_unity(args.unity, editor_version(repo))
            preflight(repo, args.profile, target_platform, unity_binary, False, dry_run=args.dry_run, dev=args.dev)
            info = snapshot_build_info(repo, args.profile, target_platform, args.dev)
    except (PreflightError, ValueError, OSError, subprocess.SubprocessError) as error:
        print("error: {0}".format(error), file=sys.stderr)
        return EXIT_PREFLIGHT

    build_date = datetime.datetime.fromisoformat(info["builtAt"]).strftime("%Y%m%d")
    stem = zip_stem(target_platform, info["version"], build_date,
                    info["commit"], info["dirty"], info["development"])
    extension = ".app" if target_platform == "macOS" else ".exe"
    output_path = os.path.join(build_dir, APP_NAME + extension)
    output_dir = args.output_dir or os.path.join(repo, "Builds")
    zip_path = os.path.join(output_dir, stem + ".zip")

    if args.dry_run:
        print("profile:  {0}{1}".format(args.profile, " (dev)" if info["development"] else ""))
        if args.package_only:
            print("mode:     package existing player with saved build-info.json")
        else:
            log_path = build_log_path(repo, args.profile)
            command = unity_build_command(unity_binary, repo, args.profile, output_path, args.dev, log_path)
            print("unity:    {0}".format(unity_binary))
            print("command:  {0}".format(format_command(command)))
        print("player:   {0}".format(output_path))
        print("zip:      {0}".format(zip_path))
        if info["dirty"]:
            print("note:     build source was dirty, the zip is tagged -dirty")
        return EXIT_OK

    # Checked before the (possibly 10-25 minute) build, not just before packaging — two
    # builds from the same commit on the same day is the normal pattern, and failing only
    # after Unity is done would burn a full build for nothing.
    if os.path.exists(zip_path) and not args.force:
        print("error: Refusing to overwrite {0}\nPass --force to replace it.".format(zip_path),
              file=sys.stderr)
        return EXIT_PREFLIGHT

    if not args.package_only:
        shutil.rmtree(build_dir, ignore_errors=True)
        os.makedirs(build_dir, exist_ok=True)
        run_unity_build(unity_binary, repo, args.profile, output_path, args.dev, args.verbose)

    if not os.path.exists(output_path):
        print("error: no player at {0}. Build first, or drop --package-only.".format(output_path),
              file=sys.stderr)
        return EXIT_PACKAGE

    try:
        # Only a successful build with a player on disk gets reusable provenance.
        # Keep it even if archiving fails, so --package-only can retry safely.
        if not args.package_only:
            write_build_info(build_dir, info)
        zip_path = package(repo, build_dir, stem, output_dir, info)
    except (subprocess.CalledProcessError, OSError) as error:
        print("error: packaging failed: {0}".format(error), file=sys.stderr)
        return EXIT_PACKAGE

    size_mb = os.path.getsize(zip_path) / (1024.0 * 1024.0)
    print("\n{0}\n  {1:.1f} MB\n  sha256 {2}".format(zip_path, size_mb, sha256(zip_path)))
    return EXIT_OK


if __name__ == "__main__":
    sys.exit(main())
