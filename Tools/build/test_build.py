"""Regression tests for build failures and preserved player provenance."""
import contextlib
import io
import json
import os
import platform
import stat
import subprocess
import tempfile
import unittest
from unittest import mock
import zipfile

import build


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
                with self.assertRaises(SystemExit) as failure:
                    build.main([PROFILE])
                self.assertEqual(failure.exception.code, build.EXIT_BUILD)
                package.assert_not_called()
                self.assertFalse(os.path.exists(os.path.join(self.build_dir, build.BUILD_INFO_FILE)))

    def test_old_success_log_cannot_authorize_new_failed_process(self):
        self.prepare_build()
        os.makedirs(os.path.dirname(self.log))
        with open(self.log, "w") as handle:
            handle.write("[BuildScript] macOS-Release: result=Succeeded\n")
        with mock.patch.object(build.subprocess, "Popen", side_effect=self.fake_unity(None, 1)), \
                mock.patch.object(build, "package") as package:
            with self.assertRaises(SystemExit) as failure:
                build.main([PROFILE])
            self.assertEqual(failure.exception.code, build.EXIT_BUILD)
            self.assertEqual(build.read_log(self.log), "")
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
            with self.assertRaises(SystemExit) as failure:
                build.main([PROFILE])
            self.assertEqual(failure.exception.code, build.EXIT_BUILD)
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


if __name__ == "__main__":
    unittest.main()
