#!/usr/bin/env python3
"""Build and package a RootsDance player.

Usage:  python3 Tools/build/build.py [PROFILE] [--dev] [--package-only] [--dry-run]
                                     [--force] [--output-dir DIR] [--unity PATH] [-v]
                                     [--audit] [--fix] [--strict] [--skip-audit]
                                     [--max-zip-mb MB] [--no-color] [--keep-churn]

The convention and the rationale live in docs/architecture/tooling/build-and-packaging.md.
Exit codes: 0 ok, 1 preflight/usage, 2 Unity build failed, 3 packaging failed,
4 zip larger than --max-zip-mb.
"""
import argparse
import datetime
import hashlib
import json
import os
import platform
import re
import shlex
import shutil
import subprocess
import sys
import time
import zipfile

import console as console_module
import history
import progress
from console import bar, fmt_bytes, fmt_duration
from naming import parse_bundle_version, platform_for_profile, zip_stem
import windows as windows_tools

EXIT_OK = 0
EXIT_PREFLIGHT = 1
EXIT_BUILD = 2
EXIT_PACKAGE = 3
EXIT_SIZE = 4

BUILD_METHOD = "RootsDance.Editor.Build.BuildScript.BuildFromCommandLine"
AUDIT_METHOD = "RootsDance.Editor.Build.AssetSizeAudit.RunFromCommandLine"
PROFILE_FOLDER = "Assets/RootsDance/Settings/BuildProfiles"
APP_NAME = "RootsDance"
BUILD_INFO_FILE = "build-info.json"
BUILD_REPORT_FILE = "build-report.json"
AUDIT_REPORT_FILE = "asset-audit.json"
POLL_SECONDS = 0.5
QUIT_TIMEOUT_SECONDS = "30"


class _StdoutProxy:
    """Looks up sys.stdout at each write/flush/isatty call, the way print()'s own
    file=sys.stdout default does. `con` is a module-level global rebuilt by
    make_console() whenever main() runs, but a test calling a build step directly
    (skipping main()) sees whatever the previous test last left it bound to. A
    plain Console(stream=sys.stdout) would capture one process's stdout (or one
    test's contextlib.redirect_stdout target) and keep writing to it forever;
    this proxy keeps `con` pointed at whichever stream is current."""

    def write(self, text):
        sys.stdout.write(text)

    def flush(self):
        sys.stdout.flush()

    def isatty(self):
        return bool(getattr(sys.stdout, "isatty", lambda: False)())


class _StderrProxy:
    """The same late lookup as _StdoutProxy, for the stream Console.warn/error use."""

    def write(self, text):
        sys.stderr.write(text)

    def flush(self):
        sys.stderr.flush()

    def isatty(self):
        return bool(getattr(sys.stderr, "isatty", lambda: False)())


con = console_module.Console(stream=_StdoutProxy(), error_stream=_StderrProxy())


def make_console(no_color=False):
    global con
    con = console_module.Console(stream=_StdoutProxy(), error_stream=_StderrProxy(),
                                 color=False if no_color else None)
    return con


# Unity's IL2CPP backend drops these next to the player it builds. Their own folder
# names say not to ship them (multi-gigabyte debug symbols / Burst debug info), and the
# prefix varies with productName, so match by suffix instead of by exact name.
EXCLUDED_SIDECAR_SUFFIXES = (
    "_BackUpThisFolder_ButDontShipItWithYourGame",
    "_BurstDebugInformation_DoNotShip",
)

# Written into the build directory by BuildScript for build.py's own size summary, and
# archived to Builds/.history/<profile>/. It is internal tooling data, not part of the
# player, so it stays out of the zip (build-info.json is the shipped provenance file).
EXCLUDED_NAMES = (BUILD_REPORT_FILE,)

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


CHURN_ALLOWLIST = (
    "ProjectSettings/ProjectSettings.asset",
    "Assets/RootsDance/Fonts/",
    "Assets/RootsDance/Settings/HDRP/",
)


def git_modified_paths(repo):
    """Tracked files with working-tree modifications (porcelain -z status, untracked ignored).

    Returns None — not an empty set — when git status could not be read at all. An empty set
    means "the tree was clean"; treating an unreadable status as clean would make every file the
    build touches look like fresh churn and hand it to `git checkout --`, discarding real work.

    -z mode is required, not cosmetic: the default porcelain format double-quotes any path
    containing a space (and every file under Assets/RootsDance/Fonts/ has one), so a plain
    line[3:] would capture the quotes and never match CHURN_ALLOWLIST. -z never quotes paths,
    NUL-terminates each record, and appends an extra NUL-terminated original-path field after
    a rename/copy (status R or C) that must be skipped.
    """
    try:
        result = subprocess.run(["git", "-C", repo, "status", "--porcelain", "-z", "--untracked-files=no"],
                                capture_output=True, text=True, check=False)
    except (subprocess.SubprocessError, OSError) as error:
        con.warn("  could not read git status: {0}".format(error))
        return None
    if result.returncode != 0:
        con.warn("  git status failed: {0}".format(result.stderr.strip()))
        return None
    paths = set()
    fields = result.stdout.split("\0")
    index = 0
    while index < len(fields):
        entry = fields[index]
        index += 1
        if not entry:
            continue
        status, path = entry[:2], entry[3:]
        if status[0] in ("R", "C"):
            # Rename/copy: the next NUL-terminated field is the original path, not a record.
            index += 1
        if status != "??":
            paths.add(path)
    return paths


def restore_build_churn(repo, dirty_before):
    """Undo the re-serialisation Unity does after every build (HDRP's post-build SaveAssets
    rewrites ProjectSettings.asset, the TMP font atlases, and the default volume profile and
    global settings). Only files that were clean before the build and match the allowlist are restored.

    `dirty_before` is None when the pre-build `git status` failed: without a baseline every
    allowlisted file looks newly dirty, so restoring would throw away edits the build never made."""
    if dirty_before is None:
        con.warn("skipping post-build churn restore: git status failed before the build")
        return [], []

    dirty_after = git_modified_paths(repo)
    if dirty_after is None:
        con.warn("skipping post-build churn restore: git status failed after the build")
        return [], []

    new = sorted(dirty_after - set(dirty_before))
    candidates = [p for p in new if p.startswith(CHURN_ALLOWLIST)]
    restore = []
    if candidates:
        result = subprocess.run(["git", "-C", repo, "checkout", "--"] + candidates,
                                capture_output=True, text=True, check=False)
        if result.returncode == 0:
            restore = candidates
        else:
            con.warn("  could not restore build churn: {0}".format(result.stderr.strip()))
    left = [p for p in new if p not in restore]
    return restore, left


def clone_or_copy(source, destination, target_platform):
    """Stage a build entry. On macOS use an APFS clone (instant, keeps symlinks/permissions
    inside the .app); fall back to ditto when the volume cannot clone."""
    if target_platform == "macOS":
        result = subprocess.run(["/bin/cp", "-Rpc", source, destination], capture_output=True, text=True)
        if result.returncode == 0:
            return
        shutil.rmtree(destination, ignore_errors=True)
        subprocess.run(["ditto", source, destination], check=True)
    elif os.path.isdir(source):
        shutil.copytree(source, destination)
    else:
        shutil.copy2(source, destination)


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


def preflight(repo, profile, target_platform, unity_binary, dry_run=False, dev=False):
    asset = os.path.join(repo, PROFILE_FOLDER, profile + ".asset")
    if not os.path.exists(asset):
        available = sorted(
            name[:-6] for name in os.listdir(os.path.join(repo, PROFILE_FOLDER))
            if name.endswith(".asset"))
        raise PreflightError(
            "No build profile '{0}'. Available: {1}\nRun the Editor menu "
            "RootsDance > Build > Create Default Build Profiles to create them.".format(
                profile, ", ".join(available) if available else "(none)"))

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
        con.println("MSVC: " + compiler)
        con.println("Windows SDK: " + sdk)

    scenes = enabled_scenes(repo)
    if len(scenes) == 0:
        raise PreflightError(
            "No scenes are enabled in ProjectSettings/EditorBuildSettings.asset — the build would "
            "be empty. Enable at least one in File > Build Profiles > Scene List (Bootstrap first).")

    con.println("scenes ({0}):".format(len(scenes)))
    for scene in scenes:
        con.println("  " + scene)


def unity_build_command(unity_binary, repo, profile, output_path, dev, log_path, strict=False, skip_audit=False):
    command = [
        unity_binary, "-batchmode", "-quit", "-quitTimeout", QUIT_TIMEOUT_SECONDS, "-timestamps",
        "-projectPath", repo,
        "-buildTarget", "StandaloneWindows64" if platform_for_profile(profile) == "Windows" else "StandaloneOSX",
        "-executeMethod", BUILD_METHOD,
        "-rdProfile", profile, "-rdOutput", output_path,
        "-logFile", log_path,
    ]
    if dev:
        command.append("-rdDev")
    if strict:
        command.append("-rdStrict")
    if skip_audit:
        command.append("-rdSkipAudit")
    return command


def unity_audit_command(unity_binary, repo, log_path, fix):
    command = [
        unity_binary, "-batchmode", "-quit", "-quitTimeout", QUIT_TIMEOUT_SECONDS, "-timestamps",
        "-projectPath", repo, "-executeMethod", AUDIT_METHOD, "-logFile", log_path,
    ]
    if fix:
        command.append("-rdFix")
    return command


def audit_log_path(repo):
    return os.path.join(repo, "Logs", "asset-audit.log")


def format_command(command):
    return subprocess.list2cmdline(command) if platform.system() == "Windows" else shlex.join(command)


def build_log_path(repo, profile):
    return os.path.join(repo, "Logs", "build-{0}.log".format(profile))


def _status_line(tracker):
    if len(tracker.phases) == 1:
        # A single-phase tracker (the asset audit) has no weight to derive a percent
        # from: PhaseTracker.percent() always reports 100% at the only/last phase,
        # which would misleadingly read as "done" for the whole run.
        return "{0}  {1}".format(con.paint("phase", tracker.current), fmt_duration(tracker.elapsed()))
    text = "{0} {1} {2:3.0f}%  {3}".format(
        con.paint("phase", tracker.current.ljust(22)), bar(tracker.percent() / 100.0),
        tracker.percent(), fmt_duration(tracker.elapsed()))
    eta = tracker.eta_seconds()
    if eta is not None and tracker.index < len(tracker.phases) - 1:
        text += "  eta ~" + fmt_duration(eta)
    if tracker.scene and tracker.current == "Building scenes":
        text += "  (scene {0}/{1})".format(*tracker.scene)
    return text


def _follow_process(process, follower, tracker, verbose):
    """Poll the log until the process exits; render progress; return the tracker."""
    last_phase = tracker.current
    while True:
        finished = process.poll() is not None
        lines = follower.poll()
        for line in lines:
            tracker.feed(line)
            if verbose and ("[BuildScript]" in line or "[AssetSizeAudit]" in line):
                con.println(con.dim("  " + line.strip()))
        if tracker.current != last_phase:
            if not con.interactive:
                con.println("  {0}  {1:3.0f}%  {2}".format(tracker.current.ljust(22), tracker.percent(),
                                                          fmt_duration(tracker.elapsed())))
            last_phase = tracker.current
        con.status("  " + _status_line(tracker))
        if finished:
            break
        time.sleep(POLL_SECONDS)
    con.end_status()
    return tracker


def _launch(command, log_path):
    os.makedirs(os.path.dirname(log_path), exist_ok=True)
    # An early launch failure may leave Unity unable to open its log. Never
    # let a previous invocation's success marker authorize this build.
    with open(log_path, "w"):
        pass
    return subprocess.Popen(command)


def run_unity_build(unity_binary, repo, profile, output_path, dev, verbose, strict=False, skip_audit=False):
    log_path = build_log_path(repo, profile)
    command = unity_build_command(unity_binary, repo, profile, output_path, dev, log_path,
                                  strict=strict, skip_audit=skip_audit)

    con.header("Building {0}{1}".format(profile, " (development)" if dev else ""))
    con.println(con.dim("  log: " + log_path))
    if verbose:
        con.println(con.dim("  " + format_command(command)))

    try:
        process = _launch(command, log_path)
    except OSError as error:
        con.error("error: could not launch Unity build: {0}".format(error))
        return EXIT_BUILD

    follower = progress.LogFollower(log_path)
    tracker = progress.PhaseTracker(weights=history.load_timings(repo, profile))
    _follow_process(process, follower, tracker, verbose)
    durations = tracker.finish()

    # Neither the exit code nor the presence of the player proves anything: Unity can exit
    # non-zero after a successful build ("Timeout ... while waiting async operations to finish"),
    # and it writes the .app skeleton before the IL2CPP/link stages that can still fail. Only
    # BuildScript.cs's own marker line, for this profile, in this run's freshly truncated log.
    success = tracker.success_marker is not None and re.search(
        progress.success_marker_pattern(profile), tracker.success_marker) is not None
    if not success:
        con.error("Build failed after {0}".format(fmt_duration(tracker.elapsed())))
        for line in tracker.errors[:20]:
            con.println("  " + line)
        con.println(con.dim(follower.tail()))
        con.println("  full log: " + log_path)
        return EXIT_BUILD

    history.save_timings(repo, profile, durations)
    con.ok("Build finished in {0}".format(fmt_duration(tracker.elapsed())))
    return EXIT_OK


def audit_report_path(repo):
    return os.path.join(repo, "Logs", AUDIT_REPORT_FILE)


def run_asset_audit(unity_binary, repo, fix, verbose):
    log_path = audit_log_path(repo)
    report_path = audit_report_path(repo)
    command = unity_audit_command(unity_binary, repo, log_path, fix)
    con.header("Asset size audit ({0})".format("fix" if fix else "report"))
    con.println(con.dim("  log: " + log_path))
    if verbose:
        con.println(con.dim("  " + format_command(command)))
    # Delete the previous report first: a run that dies before writing one would otherwise
    # be summarised from last time's numbers and read as a clean audit.
    try:
        os.remove(report_path)
    except OSError:
        pass
    try:
        process = _launch(command, log_path)
    except OSError as error:
        con.error("error: could not launch Unity: {0}".format(error))
        return EXIT_BUILD
    follower = progress.LogFollower(log_path)
    tracker = progress.PhaseTracker(phases=[progress.Phase("Auditing", None, 0, False)])
    _follow_process(process, follower, tracker, verbose)
    audit = history.load_report_any(report_path)
    if audit is None:
        con.error("error: Unity exited {0} and wrote no {1}; see the log.".format(
            process.returncode, AUDIT_REPORT_FILE))
        con.println(con.dim(follower.tail()))
        con.println("  full log: " + log_path)
        return EXIT_BUILD
    print_audit_summary(con, audit)
    return EXIT_OK


def print_audit_summary(con, audit):
    violations = audit.get("violations", [])
    con.println("  scanned {0} assets, {1} violations, {2} fixed".format(
        audit.get("scanned", 0), len(violations), audit.get("fixedCount", 0)))
    rows = [[v.get("rule", ""), v.get("assetPath", ""), v.get("message", "")] for v in violations[:60]]
    if rows:
        con.table(["rule", "asset", "message"], rows)
    if len(violations) > 60:
        con.println(con.dim("  ... {0} more in Logs/{1}".format(len(violations) - 60, AUDIT_REPORT_FILE)))


def print_build_summary(con, report, previous):
    con.header("Build report")
    steps = [[("  " * int(s.get("depth", 0))) + s.get("name", ""), fmt_duration(s.get("seconds", 0))]
             for s in report.get("steps", []) if float(s.get("seconds", 0)) >= 1.0]
    if steps:
        con.table(["step", "time"], steps, align="lr")
    delta = history.report_delta(previous, report)
    con.println()
    rows = []
    for name, before, after in delta["by_type"]:
        rows.append([name, fmt_bytes(after), _signed(after - before) if previous else ""])
    rows.append(["total", fmt_bytes(delta["total_after"]),
                 _signed(delta["total_after"] - delta["total_before"]) if previous else ""])
    con.table(["type", "size", "delta"], rows, align="lrr")
    con.println()
    top = [[a.get("path", ""), a.get("type", ""), fmt_bytes(a.get("bytes", 0))]
           for a in report.get("topAssets", [])[:10]]
    if top:
        con.table(["largest assets", "type", "size"], top, align="llr")
    if previous and delta["assets"]:
        con.println()
        con.table(["changed assets", "before", "after"],
                  [[p, fmt_bytes(b), fmt_bytes(a)] for p, b, a in delta["assets"]], align="lrr")
    warnings = int(report.get("warnings", 0))
    if warnings:
        con.warn("  {0} warnings during the build (see the log)".format(warnings))


def _signed(delta_bytes):
    if delta_bytes == 0:
        return "0"
    sign = "+" if delta_bytes > 0 else "-"
    return sign + fmt_bytes(abs(delta_bytes))


def stageable_entries(names):
    """Return the names to copy into the staged build, dropping Unity's debug sidecars
    and the tooling files (build-report.json) that are not part of the player."""
    return [name for name in names
            if not name.endswith(EXCLUDED_SIDECAR_SUFFIXES) and name not in EXCLUDED_NAMES]


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
        started = time.time()
        all_entries = sorted(os.listdir(build_dir))
        keep = set(stageable_entries(all_entries))
        for entry in all_entries:
            if entry not in keep:
                con.println("  skip: {0} (not shipped)".format(entry))
                continue
            source = os.path.join(build_dir, entry)
            destination = os.path.join(staging, entry)
            # clone_or_copy preserves the symlinks and permission bits inside a .app bundle
            # (shutil.copytree and zipfile do not, and the copied app will not launch), and on
            # APFS clones instead of duplicating bytes for the ~2.8 GB player.
            clone_or_copy(source, destination, target_platform)
        con.println("  staged in {0}".format(fmt_duration(time.time() - started)))

        app_name = APP_NAME + ".app"
        write_build_info(staging, info)

        readme = RUN_README if target_platform == "macOS" else WINDOWS_RUN_README
        with open(os.path.join(staging, "README.txt"), "w", encoding="utf-8") as handle:
            handle.write(readme.format(
                stem=stem, app=app_name, sha=info["commit"],
                date=datetime.datetime.fromisoformat(info["builtAt"]).date().isoformat()))

        os.makedirs(output_dir, exist_ok=True)
        started = time.time()
        if target_platform == "macOS":
            process = subprocess.Popen(
                ["ditto", "-c", "-k", "--sequesterRsrc", "--keepParent", staging, zip_path])
            while process.poll() is None:
                try:
                    con.status("  zipping  {0}  {1}".format(fmt_bytes(os.path.getsize(zip_path)),
                                                          fmt_duration(time.time() - started)))
                except OSError:
                    pass
                time.sleep(POLL_SECONDS)
            con.end_status()
            if process.returncode != 0:
                raise subprocess.CalledProcessError(process.returncode, "ditto")
        else:
            with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED, compresslevel=1) as archive:
                for folder, _dirs, files in os.walk(staging):
                    for name in files:
                        full = os.path.join(folder, name)
                        archive.write(full, os.path.join(stem, os.path.relpath(full, staging)))
        con.println("  zipped in {0}".format(fmt_duration(time.time() - started)))
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
    parser.add_argument("--audit", action="store_true", help="run the asset size audit instead of building")
    parser.add_argument("--fix", action="store_true", help="with --audit: apply fixes and reimport")
    parser.add_argument("--strict", action="store_true", help="fail the build on audit violations")
    parser.add_argument("--skip-audit", action="store_true", help="do not run the pre-build audit")
    parser.add_argument("--max-zip-mb", type=float, default=None, help="exit 4 if the zip is larger")
    parser.add_argument("--no-color", action="store_true", help="plain output")
    parser.add_argument("--keep-churn", action="store_true",
                        help="do not restore files Unity re-serialises during the build")
    args = parser.parse_args(argv)
    if args.fix and not args.audit:
        # --fix alone would silently do nothing: only the audit run applies fixes.
        parser.error("--fix requires --audit")
    make_console(args.no_color)

    repo = repo_root()

    if args.audit:
        try:
            unity_binary = resolve_unity(args.unity, editor_version(repo))
            if not args.dry_run and editor_is_running(repo):
                raise PreflightError("A Unity Editor has this project open. Close it, or use the menu "
                                     "RootsDance > Build > Asset Size Audit instead.")
        except (PreflightError, OSError) as error:
            con.error("error: {0}".format(error))
            return EXIT_PREFLIGHT
        if args.dry_run:
            command = unity_audit_command(unity_binary, repo, audit_log_path(repo), args.fix)
            con.println("mode:     asset size audit ({0})".format("fix" if args.fix else "report"))
            con.println("unity:    {0}".format(unity_binary))
            con.println("command:  {0}".format(format_command(command)))
            con.println("report:   {0}".format(audit_report_path(repo)))
            return EXIT_OK
        return run_asset_audit(unity_binary, repo, args.fix, args.verbose)

    try:
        target_platform = platform_for_profile(args.profile)
        build_dir = os.path.join(repo, "Builds", args.profile)
        if args.package_only:
            info = load_build_info(build_dir, args.profile, target_platform, args.dev)
        else:
            unity_binary = resolve_unity(args.unity, editor_version(repo))
            preflight(repo, args.profile, target_platform, unity_binary, dry_run=args.dry_run, dev=args.dev)
            info = snapshot_build_info(repo, args.profile, target_platform, args.dev)
    except (PreflightError, ValueError, OSError, subprocess.SubprocessError) as error:
        con.error("error: {0}".format(error))
        return EXIT_PREFLIGHT

    build_date = datetime.datetime.fromisoformat(info["builtAt"]).strftime("%Y%m%d")
    stem = zip_stem(target_platform, info["version"], build_date,
                    info["commit"], info["dirty"], info["development"])
    extension = ".app" if target_platform == "macOS" else ".exe"
    output_path = os.path.join(build_dir, APP_NAME + extension)
    output_dir = args.output_dir or os.path.join(repo, "Builds")
    zip_path = os.path.join(output_dir, stem + ".zip")

    if args.dry_run:
        con.println("profile:  {0}{1}".format(args.profile, " (dev)" if info["development"] else ""))
        if args.package_only:
            con.println("mode:     package existing player with saved build-info.json")
        else:
            log_path = build_log_path(repo, args.profile)
            command = unity_build_command(unity_binary, repo, args.profile, output_path, args.dev, log_path,
                                          strict=args.strict, skip_audit=args.skip_audit)
            con.println("unity:    {0}".format(unity_binary))
            con.println("command:  {0}".format(format_command(command)))
        con.println("player:   {0}".format(output_path))
        con.println("zip:      {0}".format(zip_path))
        if info["dirty"]:
            con.println("note:     build source was dirty, the zip is tagged -dirty")
        return EXIT_OK

    # Checked before the (possibly multi-minute) build, not just before packaging — two
    # builds from the same commit on the same day is the normal pattern, and failing only
    # after Unity is done would burn a full build for nothing.
    if os.path.exists(zip_path) and not args.force:
        con.error("error: Refusing to overwrite {0}\nPass --force to replace it.".format(zip_path))
        return EXIT_PREFLIGHT

    if not args.package_only:
        dirty_before = git_modified_paths(repo)
        shutil.rmtree(build_dir, ignore_errors=True)
        os.makedirs(build_dir, exist_ok=True)
        code = run_unity_build(unity_binary, repo, args.profile, output_path, args.dev, args.verbose,
                               strict=args.strict, skip_audit=args.skip_audit)
        if code != EXIT_OK:
            return code

        if not args.keep_churn:
            restored, left = restore_build_churn(repo, dirty_before)
            for path in restored:
                con.println(con.dim("  restored post-build churn: " + path))
            for path in left:
                con.warn("  left modified by the build: " + path)

        report_path = os.path.join(build_dir, BUILD_REPORT_FILE)
        report = history.load_report(report_path)
        if report is None:
            con.warn("  no {0} written by BuildScript; skipping the size summary".format(BUILD_REPORT_FILE))
        else:
            print_build_summary(con, report, history.load_previous_report(repo, args.profile))
            history.archive_report(repo, args.profile, report_path)

    if not os.path.exists(output_path):
        con.error("error: no player at {0}. Build first, or drop --package-only.".format(output_path))
        return EXIT_PACKAGE

    try:
        # Only a successful build with a player on disk gets reusable provenance.
        # Keep it even if archiving fails, so --package-only can retry safely.
        if not args.package_only:
            write_build_info(build_dir, info)
        zip_path = package(repo, build_dir, stem, output_dir, info)
    except (subprocess.CalledProcessError, OSError) as error:
        con.error("error: packaging failed: {0}".format(error))
        return EXIT_PACKAGE

    size_mb = os.path.getsize(zip_path) / (1024.0 * 1024.0)
    con.println()
    con.ok(zip_path)
    con.println("  {0:.1f} MB\n  sha256 {1}".format(size_mb, sha256(zip_path)))
    if args.max_zip_mb is not None and size_mb > args.max_zip_mb:
        con.error("error: zip is {0:.1f} MB, above the --max-zip-mb {1:.0f} limit".format(size_mb, args.max_zip_mb))
        return EXIT_SIZE
    return EXIT_OK


if __name__ == "__main__":
    sys.exit(main())
