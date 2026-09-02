"""Windows host checks for IL2CPP builds; no third-party Python dependencies."""
import ctypes
from ctypes import wintypes
import glob
import os
import subprocess


def unity_candidates(version):
    program_files = os.environ.get("ProgramW6432") or os.environ.get("ProgramFiles", r"C:\Program Files")
    return [
        os.path.join(program_files, "Unity", "Hub", "Editor", version, "Editor", "Unity.exe"),
        os.path.join(program_files, "Unity", "Editor", "Unity.exe"),
    ]


def process_is_running(pid):
    """Query without signals: os.kill(pid, 0) can terminate a Windows process."""
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    kernel.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
    kernel.OpenProcess.restype = wintypes.HANDLE
    kernel.WaitForSingleObject.argtypes = [wintypes.HANDLE, wintypes.DWORD]
    kernel.WaitForSingleObject.restype = wintypes.DWORD
    kernel.CloseHandle.argtypes = [wintypes.HANDLE]
    kernel.CloseHandle.restype = wintypes.BOOL
    handle = kernel.OpenProcess(0x00100000, False, pid)  # SYNCHRONIZE only
    if not handle:
        error = ctypes.get_last_error()
        if error == 87:  # ERROR_INVALID_PARAMETER: PID no longer exists
            return False
        if error == 5:  # ERROR_ACCESS_DENIED: assume running rather than risk collision
            return True
        raise ctypes.WinError(error)
    try:
        result = kernel.WaitForSingleObject(handle, 0)
        if result == 0:  # WAIT_OBJECT_0: process exited
            return False
        if result == 258:  # WAIT_TIMEOUT: process still running
            return True
        raise ctypes.WinError(ctypes.get_last_error())
    finally:
        kernel.CloseHandle(handle)


def sdk_roots():
    """Registered SDK locations, with standard installation fallback."""
    import winreg

    roots = []
    if os.environ.get("WindowsSdkDir"):
        roots.append(os.environ["WindowsSdkDir"])
    for view in (winreg.KEY_WOW64_32KEY, winreg.KEY_WOW64_64KEY):
        try:
            with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE,
                                r"SOFTWARE\Microsoft\Windows Kits\Installed Roots",
                                0, winreg.KEY_READ | view) as key:
                roots.append(winreg.QueryValueEx(key, "KitsRoot10")[0])
        except OSError:
            pass
    roots.append(os.path.join(os.environ.get("ProgramFiles(x86)", r"C:\Program Files (x86)"),
                              "Windows Kits", "10"))
    return list(dict.fromkeys(roots))


def find_windows_sdk(roots):
    """Require one complete x64 SDK >= 10.0.19041.0, including UCRT and rc.exe."""
    for root in roots:
        for library in sorted(glob.glob(os.path.join(root, "Lib", "*")), reverse=True):
            version = os.path.basename(library)
            try:
                numbers = tuple(int(part) for part in version.split("."))
            except ValueError:
                continue
            if len(numbers) != 4 or numbers < (10, 0, 19041, 0):
                continue
            required = (
                os.path.join(library, "um", "x64", "kernel32.lib"),
                os.path.join(library, "ucrt", "x64", "ucrt.lib"),
                os.path.join(root, "Include", version, "um", "Windows.h"),
                os.path.join(root, "Include", version, "shared", "sdkddkver.h"),
                os.path.join(root, "Include", version, "ucrt", "stdio.h"),
                os.path.join(root, "bin", version, "x64", "rc.exe"),
            )
            if all(os.path.isfile(path) for path in required):
                return version
    return None


def validate_toolchain():
    """Return detected paths/version or raise ValueError with installation guidance."""
    installer = os.path.join(os.environ.get("ProgramFiles(x86)", r"C:\Program Files (x86)"),
                             "Microsoft Visual Studio", "Installer", "vswhere.exe")
    if not os.path.isfile(installer):
        raise ValueError(
            "Windows IL2CPP requires Visual Studio 2019+ or Build Tools with Desktop development "
            "with C++. Install it using Visual Studio Installer (vswhere.exe was not found).")
    try:
        result = subprocess.run(
            [installer, "-products", "*", "-version", "[16.0,)",
             "-requires", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
             "-property", "installationPath", "-utf8"],
            capture_output=True, text=True, encoding="utf-8-sig", check=True, timeout=30)
    except (OSError, subprocess.SubprocessError) as error:
        raise ValueError("Cannot inspect Visual Studio C++ tools with vswhere: " + str(error))

    compiler = None
    for installation in result.stdout.splitlines():
        if not installation.strip():
            continue
        for toolset in glob.glob(os.path.join(installation.strip(), "VC", "Tools", "MSVC", "*")):
            for host in ("Hostx64", "Hostarm64", "Hostx86"):
                candidate = os.path.join(toolset, "bin", host, "x64", "cl.exe")
                if os.path.isfile(candidate) and os.path.isfile(os.path.join(os.path.dirname(candidate), "link.exe")):
                    compiler = candidate
                    break
            if compiler:
                break
        if compiler:
            break
    if compiler is None:
        raise ValueError(
            "No usable MSVC x64 compiler/linker found. In Visual Studio Installer, install "
            "Desktop development with C++ and the MSVC x64/x86 build tools (VS 2019 or newer).")
    sdk = find_windows_sdk(sdk_roots())
    if sdk is None:
        raise ValueError(
            "No complete Windows SDK >= 10.0.19041.0 found. Install a Windows 10/11 SDK "
            "including x64 libraries, UCRT and resource compiler via Visual Studio Installer.")
    return compiler, sdk
