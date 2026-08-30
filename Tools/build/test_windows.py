"""Windows host fixtures run anywhere; the live process probe runs only on Windows."""
import contextlib
import ctypes
import io
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile
import unittest
from unittest import mock
import zipfile

import build
import windows


class WindowsTests(unittest.TestCase):
    def setUp(self):
        self.contexts = contextlib.ExitStack()
        self.addCleanup(self.contexts.close)
        self.root = Path(self.contexts.enter_context(tempfile.TemporaryDirectory())) / "build machine 测试"
        self.root.mkdir()
        self.contexts.enter_context(mock.patch.object(build.platform, "system", return_value="Windows"))
        self.contexts.enter_context(mock.patch.dict(os.environ, {
            "ProgramFiles": str(self.root), "ProgramW6432": str(self.root),
            "ProgramFiles(x86)": str(self.root), "UNITY_EDITOR": "",
        }))

    def touch(self, path):
        path.parent.mkdir(parents=True, exist_ok=True)
        path.touch()
        return path

    def editor(self, il2cpp=True):
        editor = self.touch(self.root / "Unity/Hub/Editor/6000.3.22f1/Editor/Unity.exe")
        support = editor.parent / "Data/PlaybackEngines/WindowsStandaloneSupport"
        support.mkdir(parents=True, exist_ok=True)
        if il2cpp:
            (support / "Variations/win64_player_nondevelopment_il2cpp").mkdir(parents=True, exist_ok=True)
        return str(editor)

    def toolchain(self, version="10.0.26100.0"):
        self.touch(self.root / "Microsoft Visual Studio/Installer/vswhere.exe")
        installation = self.root / "VS/2022/BuildTools"
        compiler = self.touch(installation / "VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe")
        self.touch(compiler.parent / "link.exe")
        sdk = self.root / "Windows Kits/10"
        for name in ("Lib/{0}/um/x64/kernel32.lib", "Lib/{0}/ucrt/x64/ucrt.lib",
                     "Include/{0}/um/Windows.h", "Include/{0}/shared/sdkddkver.h",
                     "Include/{0}/ucrt/stdio.h", "bin/{0}/x64/rc.exe"):
            self.touch(sdk / name.format(version))
        self.contexts.enter_context(mock.patch.object(windows, "sdk_roots", return_value=[str(sdk)]))
        probe = self.contexts.enter_context(mock.patch.object(windows.subprocess, "run", return_value=
            subprocess.CompletedProcess([], 0, stdout=str(installation) + "\n")))
        return compiler, sdk, probe

    def test_detects_hub_install_in_program_files_with_spaces(self):
        editor = self.editor()
        self.assertEqual(build.resolve_unity(None, "6000.3.22f1"), editor)

    def test_custom_editor_override_and_environment_take_precedence(self):
        self.editor()
        custom = str(self.touch(self.root / "custom/Editor/Unity.exe"))
        with mock.patch.dict(os.environ, {"UNITY_EDITOR": custom}):
            self.assertEqual(build.resolve_unity(None, "6000.3.22f1"), custom)
        self.assertEqual(build.resolve_unity(custom, "6000.3.22f1"), custom)

    def test_direct_install_fallback_and_directory_rejected(self):
        direct = str(self.touch(self.root / "Unity/Editor/Unity.exe"))
        self.assertEqual(build.resolve_unity(None, "6000.3.22f1"), direct)
        with self.assertRaises(build.PreflightError):
            build.resolve_unity(str(self.root), "6000.3.22f1")

    def test_windows_uses_editor_data_and_requires_selected_il2cpp_variant(self):
        editor = self.editor(il2cpp=False)
        self.assertTrue(build.module_installed(editor, "Windows"))
        self.assertFalse(build.windows_il2cpp_installed(editor, False))
        self.editor()
        self.assertTrue(build.windows_il2cpp_installed(editor, False))
        self.assertFalse(build.windows_il2cpp_installed(editor, True))
        (Path(editor).parent / "Data/PlaybackEngines/WindowsStandaloneSupport/Variations/"
         "win64_player_development_il2cpp").mkdir()
        self.assertTrue(build.windows_il2cpp_installed(editor, True))

    def test_macos_module_layout_still_works(self):
        editor = self.touch(self.root / "Unity.app/Contents/MacOS/Unity")
        (editor.parent.parent / "PlaybackEngines/MacStandaloneSupport").mkdir(parents=True)
        with mock.patch.object(build.platform, "system", return_value="Darwin"):
            self.assertTrue(build.module_installed(str(editor), "macOS"))

    def test_detects_build_tools_without_developer_shell(self):
        compiler, _sdk, probe = self.toolchain()
        self.assertEqual(windows.validate_toolchain(), (str(compiler), "10.0.26100.0"))
        args = probe.call_args.args[0]
        self.assertIn("Microsoft.VisualStudio.Component.VC.Tools.x86.x64", args)
        self.assertIn("[16.0,)", args)
        self.assertEqual(args[args.index("-products") + 1], "*")

    def test_missing_visual_studio_has_actionable_error(self):
        with self.assertRaisesRegex(ValueError, "Visual Studio Installer"):
            windows.validate_toolchain()

    def test_incomplete_msvc_fails_before_sdk_check(self):
        compiler, _sdk, _probe = self.toolchain()
        (compiler.parent / "link.exe").unlink()
        with self.assertRaisesRegex(ValueError, "compiler/linker"):
            windows.validate_toolchain()

    def test_old_sdk_is_rejected(self):
        self.toolchain("10.0.18362.0")
        with self.assertRaisesRegex(ValueError, "10.0.19041.0"):
            windows.validate_toolchain()

    def test_partial_sdk_is_rejected(self):
        _compiler, sdk, _probe = self.toolchain()
        (sdk / "bin/10.0.26100.0/x64/rc.exe").unlink()
        with self.assertRaisesRegex(ValueError, "resource compiler"):
            windows.validate_toolchain()

    def test_sdk_minimum_and_fallback_root(self):
        _compiler, sdk, _probe = self.toolchain("10.0.19041.0")
        self.assertEqual(windows.find_windows_sdk([str(self.root / "missing"), str(sdk)]), "10.0.19041.0")

    def test_vswhere_timeout_is_actionable(self):
        self.toolchain()
        with mock.patch.object(windows.subprocess, "run", side_effect=subprocess.TimeoutExpired("vswhere", 30)):
            with self.assertRaisesRegex(ValueError, "vswhere"):
                windows.validate_toolchain()

    def test_windows_editor_check_never_sends_a_signal(self):
        path = self.touch(self.root / "Library/EditorInstance.json")
        path.write_text('{"process_id": 12345}', encoding="utf-8")
        with mock.patch.object(windows, "process_is_running", return_value=True) as query, \
                mock.patch.object(build.os, "kill", side_effect=AssertionError("must not signal")):
            self.assertTrue(build.editor_is_running(str(self.root)))
            query.assert_called_once_with(12345)

    def test_win32_query_closes_handle_for_running_and_exited_process(self):
        for wait, expected in ((258, True), (0, False)):
            kernel = mock.Mock()
            kernel.OpenProcess.return_value = 123
            kernel.WaitForSingleObject.return_value = wait
            with self.subTest(wait=wait), mock.patch.object(ctypes, "WinDLL", return_value=kernel, create=True):
                self.assertEqual(windows.process_is_running(42), expected)
                kernel.OpenProcess.assert_called_once_with(0x00100000, False, 42)
                kernel.WaitForSingleObject.assert_called_once_with(123, 0)
                kernel.CloseHandle.assert_called_once_with(123)

    def test_win32_missing_pid_and_access_denied(self):
        for error, expected in ((87, False), (5, True)):
            kernel = mock.Mock()
            kernel.OpenProcess.return_value = None
            with self.subTest(error=error), \
                    mock.patch.object(ctypes, "WinDLL", return_value=kernel, create=True), \
                    mock.patch.object(ctypes, "get_last_error", return_value=error, create=True):
                self.assertEqual(windows.process_is_running(42), expected)
                kernel.CloseHandle.assert_not_called()

    def test_preflight_rejects_linux_and_macos_cross_build(self):
        editor = self.editor()
        self.touch(self.root / build.PROFILE_FOLDER / "Windows-Release.asset")
        for host in ("Darwin", "Linux"):
            with self.subTest(host=host), mock.patch.object(build.platform, "system", return_value=host):
                with self.assertRaisesRegex(build.PreflightError, "Cannot build Windows"):
                    build.preflight(str(self.root), "Windows-Release", "Windows", editor, False)

    def test_full_windows_preflight_and_target_argument(self):
        editor = self.editor()
        self.toolchain()
        self.touch(self.root / build.PROFILE_FOLDER / "Windows-Release.asset")
        with mock.patch.object(build, "enabled_scenes", return_value=["Assets/RootsDance/Scenes/Bootstrap.unity"]), \
                contextlib.redirect_stdout(io.StringIO()):
            build.preflight(str(self.root), "Windows-Release", "Windows", editor, False)
        command = build.unity_build_command(editor, str(self.root), "Windows-Release", "RootsDance.exe", True, "log")
        self.assertEqual(command[command.index("-buildTarget") + 1], "StandaloneWindows64")
        self.assertIn("-rdDev", command)
        self.assertEqual(command[0], editor)

    def test_printed_windows_command_quotes_paths_with_spaces(self):
        command = [r"C:\Program Files\Unity\Editor\Unity.exe", "-projectPath", r"D:\Game Jam\RootsDance"]
        self.assertEqual(build.format_command(command),
                         '"C:\\Program Files\\Unity\\Editor\\Unity.exe" -projectPath "D:\\Game Jam\\RootsDance"')

    def test_preflight_rejects_open_editor_before_toolchain_or_build(self):
        editor = self.editor()
        self.touch(self.root / build.PROFILE_FOLDER / "Windows-Release.asset")
        with mock.patch.object(build, "editor_is_running", return_value=True), \
                mock.patch.object(windows, "validate_toolchain") as toolchain:
            with self.assertRaisesRegex(build.PreflightError, "Editor has this project open"):
                build.preflight(str(self.root), "Windows-Release", "Windows", editor, False)
            toolchain.assert_not_called()

    def test_preflight_rejects_mono_only_module(self):
        editor = self.editor(il2cpp=False)
        self.touch(self.root / build.PROFILE_FOLDER / "Windows-Release.asset")
        with self.assertRaisesRegex(build.PreflightError, "Mono support alone is insufficient"):
            build.preflight(str(self.root), "Windows-Release", "Windows", editor, False)

    def test_windows_default_dry_run_is_read_only(self):
        editor = self.editor()
        self.toolchain()
        self.touch(self.root / build.PROFILE_FOLDER / "Windows-Release.asset")
        info = {"version": "0.1.0", "commit": "abc1234", "dirty": False,
                "development": False, "builtAt": "2026-08-30T12:00:00+08:00"}
        with mock.patch.object(build, "repo_root", return_value=str(self.root)), \
                mock.patch.object(build, "editor_version", return_value="6000.3.22f1"), \
                mock.patch.object(build, "enabled_scenes", return_value=["Bootstrap.unity"]), \
                mock.patch.object(build, "snapshot_build_info", return_value=info), \
                mock.patch.object(build.subprocess, "Popen") as launch, \
                contextlib.redirect_stdout(io.StringIO()) as output:
            self.assertEqual(build.main(["--dry-run"]), build.EXIT_OK)
            self.assertIn("Windows-Release", output.getvalue())
            self.assertIn(editor, output.getvalue())
            launch.assert_not_called()
        self.assertFalse((self.root / "Builds").exists())

    def test_windows_zip_keeps_dlls_data_and_provenance(self):
        folder = self.root / "Builds/Windows-Release"
        for name in ("RootsDance.exe", "UnityPlayer.dll", "GameAssembly.dll",
                     "RootsDance_Data/globalgamemanagers", "RootsDance_Data/Plugins/x86_64/plugin.dll",
                     "RootsDance_BurstDebugInformation_DoNotShip/debug.pdb"):
            self.touch(folder / name)
        info = {"product": "RootsDance", "version": "0.1.0", "commit": "abc1234", "dirty": False,
                "development": False, "profile": "Windows-Release", "platform": "Windows",
                "unityVersion": "6000.3.22f1", "builtAt": "2026-08-30T12:00:00+08:00"}
        build.write_build_info(str(folder), info)
        with contextlib.redirect_stdout(io.StringIO()), \
                mock.patch.object(build.subprocess, "run", side_effect=AssertionError("no ditto on Windows")):
            archive = build.package(str(self.root), str(folder), "windows-test", str(self.root / "zips"), info)
        with zipfile.ZipFile(archive) as zipped:
            for name in ("RootsDance.exe", "UnityPlayer.dll", "GameAssembly.dll",
                         "RootsDance_Data/globalgamemanagers", "RootsDance_Data/Plugins/x86_64/plugin.dll"):
                self.assertIn("windows-test/" + name, zipped.namelist())
            self.assertFalse(any("DoNotShip" in name for name in zipped.namelist()))
            self.assertEqual(json.loads(zipped.read("windows-test/build-info.json")), info)
            self.assertIn("Extract the entire zip", zipped.read("windows-test/README.txt").decode())
            self.assertIsNone(zipped.testzip())
        self.assertFalse((self.root / "Builds/.staging").exists())


@unittest.skipUnless(platform.system() == "Windows", "requires Windows kernel32")
class LiveWindowsProcessTests(unittest.TestCase):
    def test_process_probe_does_not_terminate_child(self):
        child = subprocess.Popen([sys.executable, "-c", "import time; time.sleep(30)"])
        try:
            self.assertTrue(windows.process_is_running(child.pid))
            self.assertIsNone(child.poll())
        finally:
            child.terminate()
            child.wait(timeout=10)
        self.assertFalse(windows.process_is_running(child.pid))


if __name__ == "__main__":
    unittest.main()
