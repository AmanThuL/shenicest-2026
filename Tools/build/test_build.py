"""Regression tests for build failures and preserved player provenance."""
import contextlib
import io
import json
import os
import platform
import stat
import subprocess
import tempfile
import threading
import time as time_module
import unittest
from unittest import mock
import zipfile

import build
import history
import progress


PROFILE = "macOS-Release"


def original_info():
    return {
        "product": "RootsDance", "version": "0.1.0", "commit": "abc1234",
        "dirty": False, "development": False, "profile": PROFILE,
        "platform": "macOS", "unityVersion": "6000.3.22f1",
        "builtAt": "2026-08-28T23:59:00+08:00",
    }


class BuildFlowTests(unittest.TestCase):
    def setUp(self):
        self.contexts = contextlib.ExitStack()
        self.addCleanup(self.contexts.close)
        self.repo = self.contexts.enter_context(tempfile.TemporaryDirectory())
        self.contexts.enter_context(mock.patch.object(build, "repo_root", return_value=self.repo))
        self.stdout = self.contexts.enter_context(contextlib.redirect_stdout(io.StringIO()))
        self.contexts.enter_context(contextlib.redirect_stderr(io.StringIO()))
        self.build_dir = os.path.join(self.repo, "Builds", PROFILE)
        self.app = os.path.join(self.build_dir, "RootsDance.app")
        self.log = build.build_log_path(self.repo, PROFILE)

    def prepare_build(self):
        self.contexts.enter_context(mock.patch.object(build, "editor_version", return_value="6000.3.22f1"))
        self.contexts.enter_context(mock.patch.object(build, "resolve_unity", return_value="/fake/Unity"))
        self.contexts.enter_context(mock.patch.object(build, "preflight"))
        self.contexts.enter_context(mock.patch.object(build, "snapshot_build_info", return_value=original_info()))
        # self.repo is a plain temp dir, not a git checkout; the real git binary would just
        # report "not a git repository" here, so keep it out of these process-mocking tests
        # the same way git_state's own calls are kept out via snapshot_build_info above.
        self.contexts.enter_context(mock.patch.object(build, "git_modified_paths", return_value=set()))

    def fake_unity(self, log_text, returncode):
        def launch(_command):
            # Unity can create a skeleton before a failed IL2CPP/link step.
            os.makedirs(self.app)
            if log_text is not None:
                with open(self.log, "w") as handle:
                    handle.write(log_text)
            return mock.Mock(returncode=returncode, poll=mock.Mock(return_value=returncode))
        return launch

    def test_zero_exit_without_success_never_packages_partial_player(self):
        self.prepare_build()
        for log_text in ("", "[BuildScript] macOS-Release: result=Failed\n"):
            with self.subTest(log=log_text), mock.patch.object(
                    build.subprocess, "Popen", side_effect=self.fake_unity(log_text, 0)), \
                    mock.patch.object(build, "package") as package:
                self.assertEqual(build.main([PROFILE]), build.EXIT_BUILD)
                package.assert_not_called()
                self.assertFalse(os.path.exists(os.path.join(self.build_dir, build.BUILD_INFO_FILE)))

    def test_old_success_log_cannot_authorize_new_failed_process(self):
        self.prepare_build()
        os.makedirs(os.path.dirname(self.log))
        with open(self.log, "w") as handle:
            handle.write("[BuildScript] macOS-Release: result=Succeeded\n")
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.fake_unity(None, 1)), \
                mock.patch.object(build, "package") as package:
            self.assertEqual(build.main([PROFILE]), build.EXIT_BUILD)
            self.assertEqual(progress.LogFollower(self.log).tail(), "")
            package.assert_not_called()

    def test_fresh_success_survives_shutdown_error_and_keeps_manifest_if_zip_fails(self):
        self.prepare_build()
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.fake_unity(
                "[BuildScript] macOS-Release: result=Succeeded\n", 1)), \
                mock.patch.object(build, "package", side_effect=OSError("disk full")):
            self.assertEqual(build.main([PROFILE]), build.EXIT_PACKAGE)
        self.assertEqual(build.load_build_info(self.build_dir, PROFILE, "macOS", False), original_info())

    def test_launch_error_returns_build_failure_without_packaging(self):
        self.prepare_build()
        with mock.patch.object(build.subprocess, "Popen", side_effect=OSError("not executable")), \
                mock.patch.object(build, "package") as package:
            self.assertEqual(build.main([PROFILE]), build.EXIT_BUILD)
            package.assert_not_called()

    def test_success_marker_without_player_does_not_write_provenance(self):
        self.prepare_build()

        def launch(_command):
            with open(self.log, "w") as handle:
                handle.write("[BuildScript] macOS-Release: result=Succeeded\n")
            return mock.Mock(returncode=0, poll=mock.Mock(return_value=0))

        with mock.patch.object(build.subprocess, "Popen", side_effect=launch), \
                mock.patch.object(build, "package") as package:
            self.assertEqual(build.main([PROFILE]), build.EXIT_PACKAGE)
            package.assert_not_called()
        self.assertFalse(os.path.exists(os.path.join(self.build_dir, build.BUILD_INFO_FILE)))

    def prepare_existing(self, info):
        os.makedirs(self.app, exist_ok=True)
        build.write_build_info(self.build_dir, info)
        for name in ("git_state", "editor_version", "resolve_unity", "snapshot_build_info", "preflight"):
            self.contexts.enter_context(mock.patch.object(build, name, side_effect=AssertionError("read current " + name)))

    def test_package_only_preserves_original_metadata_and_name_without_unity_or_settings(self):
        info = original_info()
        info["development"] = True
        info["dirty"] = True
        self.prepare_existing(info)

        def archive(_repo, _build_dir, stem, output_dir, saved_info):
            self.assertEqual(saved_info, info)
            self.assertEqual(stem, "RootsDance_macOS_v0.1.0_20260828_abc1234-dirty-dev")
            path = os.path.join(output_dir, stem + ".zip")
            with open(path, "wb") as handle:
                handle.write(b"test zip")
            return path

        with mock.patch.object(build, "package", side_effect=archive):
            self.assertEqual(build.main([PROFILE, "--package-only"]), build.EXIT_OK)
        self.assertEqual(build.load_build_info(self.build_dir, PROFILE, "macOS", False), info)

    def test_package_only_cannot_relabel_release_as_dev(self):
        self.prepare_existing(original_info())
        with mock.patch.object(build, "package") as package:
            self.assertEqual(build.main([PROFILE, "--package-only", "--dev"]), build.EXIT_PREFLIGHT)
            package.assert_not_called()

    def test_missing_invalid_or_mismatched_manifest_requires_rebuild(self):
        os.makedirs(self.app)
        path = os.path.join(self.build_dir, build.BUILD_INFO_FILE)
        cases = [None, "{broken", "null", "{}"]
        for field, value in (("profile", "Windows-Release"), ("platform", "Windows"),
                             ("builtAt", "yesterday"), ("builtAt", "2026-08-28"),
                             ("development", "false"), ("version", "../escape")):
            info = original_info()
            info[field] = value
            cases.append(json.dumps(info))
        for content in cases:
            with self.subTest(content=content), mock.patch.object(build, "package") as package:
                if content is not None:
                    with open(path, "w") as handle:
                        handle.write(content)
                self.assertEqual(build.main([PROFILE, "--package-only"]), build.EXIT_PREFLIGHT)
                package.assert_not_called()

    def test_package_only_dry_run_uses_saved_plan_without_changes(self):
        self.prepare_existing(original_info())
        with mock.patch.object(build, "package") as package:
            self.assertEqual(build.main([PROFILE, "--package-only", "--dry-run"]), build.EXIT_OK)
            package.assert_not_called()
        self.assertIn("20260828_abc1234.zip", self.stdout.getvalue())
        self.assertNotIn("-executeMethod", self.stdout.getvalue())
        self.assertFalse(os.path.exists(os.path.join(self.repo, "Builds", ".staging")))


@unittest.skipUnless(platform.system() == "Darwin", "requires macOS ditto")
class MacPackageTests(unittest.TestCase):
    def test_ditto_round_trip_preserves_player_and_original_manifest(self):
        with tempfile.TemporaryDirectory() as repo, contextlib.redirect_stdout(io.StringIO()):
            build_dir = os.path.join(repo, "Builds", PROFILE)
            contents = os.path.join(build_dir, "RootsDance.app", "Contents")
            os.makedirs(os.path.join(contents, "MacOS"))
            executable = os.path.join(contents, "MacOS", "RootsDance")
            with open(executable, "w") as handle:
                handle.write("#!/bin/sh\nexit 0\n")
            os.chmod(executable, 0o755)
            os.symlink("MacOS/RootsDance", os.path.join(contents, "player-link"))
            os.makedirs(os.path.join(build_dir, "RootsDance_BurstDebugInformation_DoNotShip"))
            info = original_info()
            build.write_build_info(build_dir, info)
            archive = build.package(repo, build_dir, "original", os.path.join(repo, "zips"), info)
            with zipfile.ZipFile(archive) as zipped:
                self.assertEqual(json.loads(zipped.read("original/build-info.json")), info)
                self.assertIn("2026-08-28", zipped.read("original/README.txt").decode())
                self.assertFalse(any("DoNotShip" in name for name in zipped.namelist()))
            unpacked = os.path.join(repo, "unpacked")
            subprocess.run(["ditto", "-x", "-k", archive, unpacked], check=True)
            restored = os.path.join(unpacked, "original", "RootsDance.app", "Contents")
            self.assertEqual(os.readlink(os.path.join(restored, "player-link")), "MacOS/RootsDance")
            self.assertTrue(os.stat(os.path.join(restored, "MacOS", "RootsDance")).st_mode & stat.S_IXUSR)
            self.assertFalse(os.path.exists(os.path.join(repo, "Builds", ".staging")))


class CommandTests(unittest.TestCase):
    def test_build_command_adds_timestamps_quit_timeout_and_flags(self):
        cmd = build.unity_build_command("/U", "/repo", "macOS-Release", "/out", False, "/log",
                                        strict=True, skip_audit=True)
        self.assertIn("-timestamps", cmd)
        self.assertEqual(cmd[cmd.index("-quitTimeout") + 1], "30")
        self.assertIn("-rdStrict", cmd)
        self.assertIn("-rdSkipAudit", cmd)
        self.assertNotIn("-rdDev", cmd)

    def test_audit_command(self):
        cmd = build.unity_audit_command("/U", "/repo", "/log", fix=True)
        self.assertEqual(cmd[cmd.index("-executeMethod") + 1], build.AUDIT_METHOD)
        self.assertIn("-rdFix", cmd)
        self.assertIn("-batchmode", cmd)
        self.assertNotIn("-rdFix", build.unity_audit_command("/U", "/repo", "/log", fix=False))


class StatusLineTests(unittest.TestCase):
    def test_single_phase_tracker_has_no_percent_or_bar(self):
        tracker = progress.PhaseTracker(phases=[progress.Phase("Auditing", None, 0, False)])
        self.assertNotIn("%", build._status_line(tracker))


class StreamingBuildTests(BuildFlowTests):
    """run_unity_build follows the log while Unity runs and returns a code instead of raising."""

    def streaming_unity(self, lines, returncode, delay=0.01):
        def launch(_command):
            os.makedirs(self.app, exist_ok=True)

            def write():
                with open(self.log, "a") as handle:
                    for line in lines:
                        handle.write(line + "\n")
                        handle.flush()
                        time_module.sleep(delay)
            worker = threading.Thread(target=write)
            worker.start()
            proc = mock.Mock(returncode=returncode)
            proc.poll = lambda: None if worker.is_alive() else returncode
            return proc
        return launch

    def test_success_marker_seen_while_streaming_returns_ok(self):
        self.prepare_build()
        lines = ["[ScriptCompilation] Requested script compilation because: x",
                 "[BuildScript] build start profile=macOS-Release dev=False",
                 "[BuildScript] scene 1/2 A.unity", "[BuildScript] scene 2/2 B.unity",
                 "[BuildScript] scenes done",
                 "[BuildScript] macOS-Release: result=Succeeded size=1 bytes errors=0 time=0"]
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.streaming_unity(lines, 0)), \
                mock.patch.object(build, "POLL_SECONDS", 0.005):
            code = build.run_unity_build("/fake/Unity", self.repo, PROFILE, self.app, False, False,
                                         strict=False, skip_audit=False)
        self.assertEqual(code, build.EXIT_OK)
        timings = history.load_timings(self.repo, PROFILE)
        self.assertIn("Packing player data", timings)

    def test_wrong_profile_marker_is_a_failure(self):
        self.prepare_build()
        lines = ["[BuildScript] Windows-Release: result=Succeeded size=1 bytes errors=0 time=0"]
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.streaming_unity(lines, 0)), \
                mock.patch.object(build, "POLL_SECONDS", 0.005):
            code = build.run_unity_build("/fake/Unity", self.repo, PROFILE, self.app, False, False,
                                         strict=False, skip_audit=False)
        self.assertEqual(code, build.EXIT_BUILD)

    def test_failure_prints_collected_errors(self):
        self.prepare_build()
        lines = ["Assets/X.cs(1,1): error CS0001: boom", "Aborting batchmode due to failure:"]
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.streaming_unity(lines, 1)), \
                mock.patch.object(build, "POLL_SECONDS", 0.005):
            code = build.run_unity_build("/fake/Unity", self.repo, PROFILE, self.app, False, False,
                                         strict=False, skip_audit=False)
        self.assertEqual(code, build.EXIT_BUILD)
        self.assertIn("error CS0001", self.stdout.getvalue())


class SummaryTests(unittest.TestCase):
    def test_print_build_summary_shows_steps_types_top_and_delta(self):
        out = io.StringIO()
        con = build.console_module.Console(stream=out, color=False)
        report = {
            "result": "Succeeded", "totalSeconds": 192.0, "totalBytes": 4000, "outputPath": "x",
            "warnings": 3, "errors": 0,
            "steps": [{"name": "Build player", "depth": 0, "seconds": 192.0},
                      {"name": "Creating compressed player package", "depth": 1, "seconds": 134.9}],
            "byType": [{"type": "Mesh", "bytes": 3000, "count": 2}],
            "topAssets": [{"path": "Assets/A.fbx", "type": "Mesh", "bytes": 3000}],
            "files": [],
        }
        previous = dict(report, totalBytes=5000,
                        topAssets=[{"path": "Assets/A.fbx", "type": "Mesh", "bytes": 4000}])
        build.print_build_summary(con, report, previous)
        text = out.getvalue()
        self.assertIn("Creating compressed player package", text)
        self.assertIn("Mesh", text)
        self.assertIn("Assets/A.fbx", text)
        self.assertIn("-1000", text.replace(",", ""))  # delta shown


class ChurnRestoreTests(unittest.TestCase):
    def test_restores_only_allowlisted_files_that_were_clean_before(self):
        before = {"Assets/RootsDance/Scenes/Bootstrap.unity"}
        after = before | {"ProjectSettings/ProjectSettings.asset",
                          "Assets/RootsDance/Fonts/FZJingLei SDF.asset",
                          "Assets/RootsDance/Data/Foo.asset"}
        calls = []

        def fake_run(cmd, **kw):
            calls.append(cmd)
            return mock.Mock(returncode=0, stderr="")

        with mock.patch.object(build, "git_modified_paths", return_value=after), \
                mock.patch.object(build.subprocess, "run", side_effect=fake_run):
            restored, left = build.restore_build_churn("/repo", before)
        self.assertEqual(sorted(restored), ["Assets/RootsDance/Fonts/FZJingLei SDF.asset",
                                            "ProjectSettings/ProjectSettings.asset"])
        self.assertEqual(left, ["Assets/RootsDance/Data/Foo.asset"])
        self.assertEqual(len(calls), 1)
        self.assertEqual(calls[0][:4], ["git", "-C", "/repo", "checkout"])
        self.assertIn("ProjectSettings/ProjectSettings.asset", calls[0])

    def test_nothing_to_restore(self):
        with mock.patch.object(build, "git_modified_paths", return_value=set()), \
                mock.patch.object(build.subprocess, "run") as run:
            self.assertEqual(build.restore_build_churn("/repo", set()), ([], []))
            run.assert_not_called()

    def test_checkout_failure_is_reported_and_leaves_the_paths_unrestored(self):
        before = set()
        after = {"ProjectSettings/ProjectSettings.asset", "Assets/RootsDance/Fonts/A.asset"}
        with mock.patch.object(build, "git_modified_paths", return_value=after), \
                mock.patch.object(build.subprocess, "run",
                                   return_value=mock.Mock(returncode=1, stderr="error: could not checkout\n")), \
                mock.patch.object(build, "con") as con:
            restored, left = build.restore_build_churn("/repo", before)
        self.assertEqual(restored, [])
        self.assertEqual(sorted(left), sorted(after))
        con.warn.assert_called_once()
        self.assertIn("could not checkout", con.warn.call_args.args[0])

    def test_git_modified_paths_parses_dash_z_porcelain(self):
        output = " M ProjectSettings/ProjectSettings.asset\0?? Builds/x\0M  Assets/A.cs\0"
        with mock.patch.object(build.subprocess, "run",
                               return_value=mock.Mock(stdout=output, returncode=0)):
            self.assertEqual(build.git_modified_paths("/repo"),
                             {"ProjectSettings/ProjectSettings.asset", "Assets/A.cs"})

    def test_paths_with_spaces_are_not_quoted_in_dash_z_mode(self):
        # The default (non -z) porcelain format double-quotes any path containing a space
        # (every file under Assets/RootsDance/Fonts/ has one); -z must not do that, or the
        # quoted string never matches CHURN_ALLOWLIST and the fonts are never restored.
        output = "M  Assets/RootsDance/Fonts/FZJingLei SDF.asset\0"
        with mock.patch.object(build.subprocess, "run",
                               return_value=mock.Mock(stdout=output, returncode=0)):
            self.assertEqual(build.git_modified_paths("/repo"),
                             {"Assets/RootsDance/Fonts/FZJingLei SDF.asset"})

    def test_git_status_is_decoded_as_utf8_regardless_of_locale(self):
        # -z emits raw UTF-8 path bytes; on a Windows machine with a GBK/cp1252 locale a
        # text=True decode could raise on a Chinese file name and abort the build.
        captured = {}

        def fake_run(command, **kwargs):
            captured.update(kwargs)
            return mock.Mock(stdout="M  docs/\u8d34\u56fe\u7ba1\u7ebf.md\0", stderr="", returncode=0)

        with mock.patch.object(build.subprocess, "run", side_effect=fake_run):
            self.assertEqual(build.git_modified_paths("/repo"), {"docs/\u8d34\u56fe\u7ba1\u7ebf.md"})
        self.assertEqual(captured.get("encoding"), "utf-8")
        self.assertEqual(captured.get("errors"), "replace")
        self.assertNotIn("text", captured)

    def test_rename_entries_skip_the_extra_original_path_field(self):
        output = "R  new.txt\0old.txt\0"
        with mock.patch.object(build.subprocess, "run",
                               return_value=mock.Mock(stdout=output, returncode=0)):
            self.assertEqual(build.git_modified_paths("/repo"), {"new.txt"})

    def test_nonzero_returncode_is_reported_and_returns_none(self):
        # None, not set(): an empty set means "clean", which would make every file the build
        # touches look like fresh churn and hand it to git checkout --.
        with mock.patch.object(build.subprocess, "run",
                               return_value=mock.Mock(stdout="", stderr="fatal: not a git repository\n",
                                                      returncode=128)), \
                mock.patch.object(build, "con") as con:
            self.assertIsNone(build.git_modified_paths("/repo"))
        con.warn.assert_called_once()
        self.assertIn("not a git repository", con.warn.call_args.args[0])

    def test_git_failure_returns_none(self):
        with mock.patch.object(build.subprocess, "run", side_effect=OSError("no git")), \
                mock.patch.object(build, "con"):
            self.assertIsNone(build.git_modified_paths("/repo"))

    def test_unknown_baseline_skips_the_restore_entirely(self):
        with mock.patch.object(build, "git_modified_paths") as paths, \
                mock.patch.object(build.subprocess, "run") as run, \
                mock.patch.object(build, "con") as con:
            self.assertEqual(build.restore_build_churn("/repo", None), ([], []))
            paths.assert_not_called()
            run.assert_not_called()
        self.assertIn("git status failed before the build", con.warn.call_args.args[0])

    def test_git_failure_after_the_build_skips_the_restore(self):
        with mock.patch.object(build, "git_modified_paths", return_value=None), \
                mock.patch.object(build.subprocess, "run") as run, \
                mock.patch.object(build, "con"):
            self.assertEqual(build.restore_build_churn("/repo", set()), ([], []))
            run.assert_not_called()

    def test_hdrp_settings_churn_is_restored(self):
        before = {"Assets/RootsDance/Scenes/Bootstrap.unity"}
        after = before | {"Assets/RootsDance/Settings/HDRP/DefaultVolumeProfile.asset",
                          "Assets/RootsDance/Settings/HDRP/HDRenderPipelineGlobalSettings.asset",
                          "Assets/RootsDance/Data/Foo.asset"}
        calls = []

        def fake_run(cmd, **kw):
            calls.append(cmd)
            return mock.Mock(returncode=0, stderr="")

        with mock.patch.object(build, "git_modified_paths", return_value=after), \
                mock.patch.object(build.subprocess, "run", side_effect=fake_run):
            restored, left = build.restore_build_churn("/repo", before)
        self.assertEqual(sorted(restored), ["Assets/RootsDance/Settings/HDRP/DefaultVolumeProfile.asset",
                                            "Assets/RootsDance/Settings/HDRP/HDRenderPipelineGlobalSettings.asset"])
        self.assertEqual(left, ["Assets/RootsDance/Data/Foo.asset"])
        self.assertEqual(len(calls), 1)
        self.assertEqual(calls[0][:4], ["git", "-C", "/repo", "checkout"])
        self.assertIn("Assets/RootsDance/Settings/HDRP/DefaultVolumeProfile.asset", calls[0])


class AssetAuditTests(unittest.TestCase):
    def setUp(self):
        self.contexts = contextlib.ExitStack()
        self.addCleanup(self.contexts.close)
        self.repo = self.contexts.enter_context(tempfile.TemporaryDirectory())
        self.stdout = self.contexts.enter_context(contextlib.redirect_stdout(io.StringIO()))
        self.contexts.enter_context(contextlib.redirect_stderr(io.StringIO()))
        self.report = build.audit_report_path(self.repo)

    def write_stale_report(self):
        os.makedirs(os.path.dirname(self.report), exist_ok=True)
        with open(self.report, "w") as handle:
            json.dump({"scanned": 999, "fixedCount": 0, "violations": []}, handle)

    def test_failed_run_deletes_the_stale_report_instead_of_summarising_it(self):
        self.write_stale_report()

        def launch(_command):
            return mock.Mock(returncode=1, poll=mock.Mock(return_value=1))

        with mock.patch.object(build.subprocess, "Popen", side_effect=launch):
            code = build.run_asset_audit("/fake/Unity", self.repo, False, False)
        self.assertEqual(code, build.EXIT_BUILD)
        self.assertFalse(os.path.exists(self.report))
        self.assertNotIn("999", self.stdout.getvalue())

    def test_fresh_report_is_summarised(self):
        def launch(_command):
            os.makedirs(os.path.dirname(self.report), exist_ok=True)
            with open(self.report, "w") as handle:
                json.dump({"scanned": 7, "fixedCount": 0, "violations": []}, handle)
            return mock.Mock(returncode=0, poll=mock.Mock(return_value=0))

        with mock.patch.object(build.subprocess, "Popen", side_effect=launch):
            self.assertEqual(build.run_asset_audit("/fake/Unity", self.repo, False, False), build.EXIT_OK)
        self.assertIn("scanned 7 assets", self.stdout.getvalue())

    def test_fix_without_audit_is_a_usage_error(self):
        with mock.patch.object(build, "repo_root", return_value=self.repo), \
                self.assertRaises(SystemExit) as caught:
            build.main([PROFILE, "--fix"])
        self.assertEqual(caught.exception.code, 2)

    def test_audit_dry_run_prints_the_command_and_launches_nothing(self):
        with mock.patch.object(build, "repo_root", return_value=self.repo), \
                mock.patch.object(build, "editor_version", return_value="6000.3.22f1"), \
                mock.patch.object(build, "resolve_unity", return_value="/fake/Unity"), \
                mock.patch.object(build.subprocess, "Popen") as popen:
            self.assertEqual(build.main(["--audit", "--fix", "--dry-run"]), build.EXIT_OK)
            popen.assert_not_called()
        printed = self.stdout.getvalue()
        self.assertIn(build.AUDIT_METHOD, printed)
        self.assertIn("-rdFix", printed)
        self.assertFalse(os.path.exists(build.audit_log_path(self.repo)))


class CloneTests(unittest.TestCase):
    @unittest.skipUnless(platform.system() == "Darwin", "APFS clone is macOS only")
    def test_clone_preserves_symlinks_and_falls_back_to_ditto(self):
        with tempfile.TemporaryDirectory() as tmp:
            src = os.path.join(tmp, "src.app")
            os.makedirs(os.path.join(src, "Contents"))
            with open(os.path.join(src, "Contents", "f"), "w") as handle:
                handle.write("x")
            os.symlink("Contents/f", os.path.join(src, "link"))
            dst = os.path.join(tmp, "dst.app")
            build.clone_or_copy(src, dst, "macOS")
            self.assertTrue(os.path.islink(os.path.join(dst, "link")))
            self.assertEqual(open(os.path.join(dst, "Contents", "f")).read(), "x")

    def test_windows_path_uses_copytree(self):
        with tempfile.TemporaryDirectory() as tmp:
            src = os.path.join(tmp, "RootsDance_Data")
            os.makedirs(src)
            with open(os.path.join(src, "f"), "w") as handle:
                handle.write("x")
            build.clone_or_copy(src, os.path.join(tmp, "out"), "Windows")
            self.assertTrue(os.path.exists(os.path.join(tmp, "out", "f")))


class SizeGateTests(BuildFlowTests):
    def test_size_gate_returns_exit_size_but_keeps_zip(self):
        self.prepare_build()

        def fake_build(*_args, **_kwargs):
            # main() wipes and recreates build_dir right before calling run_unity_build; a
            # real Unity invocation repopulates it, so this stand-in must too.
            os.makedirs(self.app, exist_ok=True)
            return build.EXIT_OK

        with mock.patch.object(build, "run_unity_build", side_effect=fake_build), \
                mock.patch.object(build, "restore_build_churn", return_value=([], [])), \
                mock.patch.object(build, "package") as package:
            zip_path = os.path.join(self.repo, "Builds", "big.zip")
            os.makedirs(os.path.dirname(zip_path), exist_ok=True)
            with open(zip_path, "wb") as handle:
                handle.write(b"\0" * (2 * 1024 * 1024))
            package.return_value = zip_path
            self.assertEqual(build.main([PROFILE, "--max-zip-mb", "1"]), build.EXIT_SIZE)
            self.assertTrue(os.path.exists(zip_path))


if __name__ == "__main__":
    unittest.main()
