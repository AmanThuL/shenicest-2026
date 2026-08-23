---
title: "System requirements for Unity 6.3"
page_title: "Unity - Manual: System requirements for Unity 6.3"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# System requirements for Unity 6.3

This page outlines the system requirements you need to run Unity 6.3 on all supported platforms.

-   [Unity Editor system requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#editor)
-   [Unity Editor platform limitations](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#limitations)
-   [Unity Player system requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#player):
    -   [Mobile](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#mobile)
    -   [Console](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#console)
    -   [Desktop](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#desktop)
    -   [Server platform](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#server)
    -   [Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#web)
    -   [XR platform](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#xr)
        -   [Standalone XR devices](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#standalone-xr)
        -   [Meta](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#oculus)
        -   [OpenXR](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#openxr)
        -   [Windows Mixed Reality](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#wmr)
        -   [Magic Leap](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#magic)
        -   [Google ARCore](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#arcore)
        -   [Apple visionOS](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#visionos)
    -   [Embedded Systems](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#embedded)

<span id="editor"></span>

## Unity Editor system requirements

This section lists the hardware and software requirements to run the Unity Editor. Actual performance and rendering quality might vary depending on the complexity of your project.

For all operating systems, the Unity Editor is supported on workstations or laptop form factors running without emulation, container or compatibility layer.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Operating system</strong></th><th style="text-align: left;"><strong>Operating system version</strong></th><th style="text-align: left;"><strong>CPU</strong></th><th style="text-align: left;"><strong>Graphics API</strong></th><th style="text-align: left;"><strong>Additional requirements</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">Windows 10 version 21H1 (build 19043) or newer (X64), Windows 11 21H2 (build 22000) or newer (Arm64)</td><td style="text-align: left;">X64 architecture with SSE2 instruction set support, Arm64</td><td style="text-align: left;">DX10, DX11, DX12 or Vulkan capable GPUs</td><td style="text-align: left;">Hardware vendor officially supported drivers</td></tr><tr class="even"><td style="text-align: left;"><strong>macOS</strong></td><td style="text-align: left;">Ventura 13 or newer</td><td style="text-align: left;">X64 architecture with SSE2 instruction set support (Intel processors)<br />
Apple M1 or above (Apple silicon-based processors)</td><td style="text-align: left;">Metal-capable Intel and AMD GPUs</td><td style="text-align: left;">Apple officially supported drivers (Intel processor)<br />
Rosetta 2 is required for Apple silicon devices running on either Apple silicon or Intel versions of the Unity Editor</td></tr><tr class="odd"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">Ubuntu 22.04, Ubuntu 24.04</td><td style="text-align: left;">X64 architecture with SSE2 instruction set support</td><td style="text-align: left;">OpenGL 3.2+ or Vulkan-capable, Nvidia and AMD GPUs</td><td style="text-align: left;">Gnome desktop environment running on top of X11 or Wayland windowing system, Nvidia official proprietary graphics driver, or AMD Mesa graphics driver. Other configurations and user environments as provided with the supported distribution (Kernel, Compositor, etc.)<br />
<br />
<strong>Notes:</strong><ul><li><strong>Ubuntu 22.04:</strong> Wayland is supported with AMD graphics cards.</li><li><strong>Ubuntu 24.04:</strong> Wayland is supported with AMD graphics cards and Nvidia graphics cards utilizing Nvidia proprietary graphics drivers 550 and above.</li></ul></td></tr></tbody></table>

### RAM recommendations for the Unity Editor

To run the Unity Editor on Windows, macOS, or Linux, a minimum of 8 GB RAM is recommended.

However, the amount of RAM required to load and run your project depends on your project’s size and complexity. Larger and more complex projects require additional RAM.

### Hard disk recommendations for the Unity Editor

When creating a build, the Editor reads and writes many small files to disk. To improve performance when creating a build, it’s recommended to use a disk drive with a high Input/Output Operations Per Second (IOPS) rating.

For more information on creating a build, refer to [Introduction to building](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html).

<span id="limitations"></span>

## Unity Editor platform limitations

### Windows on Arm

-   Download and install of Windows on Arm Editor via the Unity Hub is only possible through Hub version v3.7.0 Beta 1 or later. For more information, see the [Unity Hub release notes](https://unity.com/unity-hub/release-notes).

    To switch to the latest beta version of the Hub, change **Preferences** > **Advanced** > **Channel** to **Beta**. Alternatively, re-download Unity: <https://unity.com/download>.

-   Unity doesn’t support platforms that don’t provide native Windows Arm64 SDKs. Build for these platforms might still work with x86 emulation for Windows on Arm.

-   Unity doesn’t support packages with third-party binary dependencies that don’t provide native Windows on Arm support. These packages might work with x86 emulation for Windows on Arm.

-   Unity doesn’t support Vulkan for Windows on Arm.

-   Unity doesn’t support CPU lightmapping for Windows on Arm, only GPU lightmapping.

### Apple

On macOS, secondary Editor windows only maximize, and don’t enter full screen mode.

### Apple silicon devices

Unity doesn’t support CPU lightmapping for Apple silicon devices, only GPU lightmapping.

<span id="linux"></span>

### Linux

The Linux Editor has the following limitations:

-   Video importing is limited to the VP8 video format.
-   File systems are case sensitive.
-   If the Editor generates a `Pipe error !` message, you must increase the maximum open file limit in your current Editor session. For example, run `ulimit -n 4096` in the terminal before launching the Editor. For more information, refer to the [Troubleshooting Linux Editor issues](https://docs.unity3d.com/6000.3/Documentation/Manual/linux-editor-troubleshooting.html) page.
-   Wayland support for Desktop Linux is currently in experimental stage. To run the Linux player in Native Wayland mode when using a Wayland session, use `-force-wayland` command line argument.

<span id="player"></span>

## Unity Player system requirements

This section lists the minimum requirements to build and run the Unity Player. Actual performance and rendering quality might vary depending on the complexity of your project.

<span id="mobile"></span>

### Mobile

<table><thead><tr class="header"><th style="text-align: left;"><strong>Operating system</strong></th><th style="text-align: left;"><strong>Operating system version</strong></th><th style="text-align: left;"><strong>CPU</strong></th><th style="text-align: left;"><strong>Graphics API</strong></th><th style="text-align: left;"><strong>Additional requirements</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Android</strong></td><td style="text-align: left;">7.1 (API 25)+<br />
Customized versions of Android must include all supported Google standard APIs.</td><td style="text-align: left;">ARMv7 with Neon Support (32-bit) or ARM64</td><td style="text-align: left;">OpenGL ES 3.0+, Vulkan</td><td style="text-align: left;"><ul><li>1GB+ RAM</li><li>Supported hardware devices must meet or exceed Google’s Android Compatibility Definition (<a href="https://source.android.com/compatibility/9/android-9-cdd.html">Version 9.0</a>) limited to the following Device Types:<ol><li>Handheld (Section 2.2)</li><li>Television (Section 2.3)</li><li>Tablets (Section 2.6)</li></ol></li><li>Hardware must be running Android OS natively. Android within a container or emulator isn’t supported.</li><li>For development: Android SDK (15/API 35), Android NDK (r27c) and OpenJDK (17), which are installed by default with <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/android-sdksetup.html">Unity Hub</a>.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>iOS/iPadOS</strong></td><td style="text-align: left;">15+</td><td style="text-align: left;">A8 SoC+</td><td style="text-align: left;">Metal</td><td style="text-align: left;"><ul><li>Xcode version 16 or later.</li><li>For development and debugging: refer to Apple documentation on <a href="https://developer.apple.com/support/xcode/">Xcode support</a>.</li><li>For App Store submission: refer to Apple’s <a href="https://developer.apple.com/app-store/submitting/">submission guidelines</a> for the required Xcode version.</li></ul></td></tr><tr class="odd"><td style="text-align: left;"><strong>tvOS</strong></td><td style="text-align: left;">15+</td><td style="text-align: left;">A8 SoC+</td><td style="text-align: left;">Metal</td><td style="text-align: left;"><ul><li>Xcode version 16 or later.</li><li>Apple TV HD or newer.</li></ul></td></tr></tbody></table>

<span id="console"></span>

### Console

For information on PlayStation®4 (including PS VR), PlayStation®5 (including PS VR2), Xbox One, Xbox Series X\|S, and Nintendo Switch™, refer to the [Game Development For Console Platforms](https://unity.com/solutions/console) page. To build on console platforms, only Windows versions of Unity are supported. For specific requirements on any additional platform specific software needed, please refer to the developer documentation on the platform holders website, or contact your platform representative directly for further information.

For specific system requirements of the Unity Editor, refer to the version of Unity you’re using on the [Unity downloads page](https://unity3d.com/get-unity/download).

| **Platform**                         | **Operating system**                                                           |
|:-------------------------------------|:-------------------------------------------------------------------------------|
| **Nintendo Switch™**                 | Microsoft Windows 10 Pro (64-bit) English or Japanese version                  |
| **Nintendo Switch™ 2**               | Microsoft Windows 10 Pro (64-bit) English or Japanese version                  |
| **Xbox Series X\|S**                 | Windows 10 64-bit (Version 1709 or higher): Home, Professional, and Enterprise |
| **Xbox One**                         | Windows 10 64-bit (Version 1709 or higher): Home, Professional, and Enterprise |
| **PlayStation®4 (including PS VR)**  | Windows 10 Pro 64-bit (x64) Version 22H2                                       |
| **PlayStation®5 (including PS VR2)** | Windows 10 Pro 64-bit (x64) Version 22H2                                       |

<span id="desktop"></span>

### Desktop

For all operating systems, the Unity Player is supported on workstations, laptop or tablet form factors, running without emulation, container or compatibility layer.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Operating system</strong></th><th style="text-align: left;"><strong>Operating system version</strong></th><th style="text-align: left;"><strong>CPU</strong></th><th style="text-align: left;"><strong>Graphics API</strong></th><th style="text-align: left;"><strong>Additional requirements</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;">Windows 10 version 21H1 (build 19043) or newer</td><td style="text-align: left;">x86, x64 architecture with SSE2 instruction set support, Arm64</td><td style="text-align: left;">DX10, DX11, DX12 or Vulkan capable GPUs</td><td style="text-align: left;">Hardware vendor officially supported drivers<br />
For development: IL2CPP scripting backend requires Visual Studio 2019 with C++ Tools component or later and Windows SDK version 10.0.19041.0 or newer</td></tr><tr class="even"><td style="text-align: left;"><strong>Universal Windows Platform</strong></td><td style="text-align: left;">Windows 10 version 21H1 (build 19043) or newer, Xbox One, Xbox Series X and Series S, HoloLens</td><td style="text-align: left;">x86, x64 architecture with SSE2 instruction set support, Arm64</td><td style="text-align: left;">DX10, DX11, DX12 capable GPUs</td><td style="text-align: left;">Hardware vendor officially supported drivers.<br />
For development: Visual Studio 2019 with C++ Tools component or later and Windows SDK version 10.0.19041.0 or newer.</td></tr><tr class="odd"><td style="text-align: left;"><strong>macOS</strong></td><td style="text-align: left;">Monterey 12 or newer</td><td style="text-align: left;">Apple Silicon, x64 architecture with SSE2</td><td style="text-align: left;">Metal capable Intel and AMD GPUs</td><td style="text-align: left;">Apple officially supported drivers.<br />
For development: IL2CPP scripting backend requires Xcode.</td></tr><tr class="even"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;">Ubuntu 22.04, Ubuntu 24.04</td><td style="text-align: left;">x64 architecture with SSE2 instruction set support<br />
<strong>Note:</strong> Desktop Linux supports only 64-bit architecture.</td><td style="text-align: left;">OpenGL 3.2+, Vulkan capable GPUs</td><td style="text-align: left;">Gnome desktop environment running on top of X11 or Wayland windowing system.<br />
Other configurations and user environments as provided with the supported distribution (such as Kernel or Compositor)<br />
Nvidia and AMD GPUs using Nvidia official proprietary graphics driver, or AMD Mesa graphics driver.<br />
<br />
<strong>Notes:</strong><ul><li><strong>Ubuntu 22.04:</strong> Wayland is supported with AMD graphics cards.</li><li><strong>Ubuntu 24.04:</strong> Wayland is supported with AMD graphics cards and Nvidia graphics cards utilizing Nvidia proprietary graphics drivers 550 and above.</li></ul></td></tr></tbody></table>

<span id="server"></span>

### Server platform

| **Operating system** | **Operating system version**                                                                                                                         | **CPU**                                                                          | **GPU**                 | **Additional requirements**                  |
|:---------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------|:------------------------|:---------------------------------------------|
| **Windows**          | Windows 10 version 21H1 (build 19043) or newer, running on workstation and rack form factors, without emulation or compatibility layer               | x86, x64 architecture with SSE2 instruction set support, Arm64                   | No explicit GPU support | Hardware vendor officially supported drivers |
| **macOS**            | Monterey 12 or newer running on workstation and rack form factors, without emulation or compatibility layer                                          | Apple Silicon, x64 architecture with SSE2 instruction set support, Apple silicon | No explicit GPU support | Hardware vendor officially supported drivers |
| **Linux**            | Ubuntu 22.04 (AMD64 or Arm64), Ubuntu 24.04 (AMD64 or Arm64), running on workstation and rack form factors, without emulation or compatibility layer | x64 architecture with SSE2 instruction set support, Arm64                        | No explicit GPU support | Hardware vendor officially supported drivers |

<span id="web"></span>

### Web platform

<table><thead><tr class="header"><th style="text-align: left;"><strong>Operating system running browsers</strong></th><th style="text-align: left;"><strong>Hardware</strong></th><th style="text-align: left;"><strong>Additional requirements</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Windows, macOS, and Linux</strong></td><td style="text-align: left;">Workstation and laptop form factors</td><td style="text-align: left;">Versions of Chrome, Firefox, Safari or Edge (Chromium-based) that are:<ul><li>WebGL 2.0 capable</li><li>HTML 5 standards compliant</li><li>64-bit</li><li>WebAssembly capable</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Android and iOS</strong></td><td style="text-align: left;">Android or iOS device</td><td style="text-align: left;">Browser requirements:<ul><li>iOS Safari 15 and newer</li><li>Chrome 58 and newer</li></ul><strong>Note</strong>: For better performance, use iOS Safari 18.2 or newer, which supports a higher memory limit.</td></tr></tbody></table>

<span id="xr"></span>

### XR platform system requirements

To enable XR and properly configure your Unity project, follow the steps outlined in the [XR plug-in architecture](https://docs.unity3d.com/6000.3/Documentation/Manual/XRPluginArchitecture.html) page.

<span id="magic"></span> <span id="standalone-xr"></span>

### Standalone XR devices

| **Device**           | **Device software**                                                                                                                                                                      |
|:---------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Magic Leap 2         | Magic Leap 2 Core OS version 1.0+                                                                                                                                                        |
| Meta Quest 1         | Quest software version 50 or earlier (Refer to [Quest 1 support](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-support-packages.html#xr-quest1-support) for more information.) |
| Meta Quest 2         | Quest software version 39+                                                                                                                                                               |
| Meta Quest Pro       | Quest software version 46+                                                                                                                                                               |
| Meta Quest 3         | Quest software version 59+                                                                                                                                                               |
| Microsoft HoloLens 1 | Windows 10 Holographic version 1809+                                                                                                                                                     |
| Microsoft HoloLens 2 | Windows Holographic version 1903+                                                                                                                                                        |

<span id="oculus"></span>

### Meta desktop XR: Rift, Rift S

| **Specification**            | **Minimum requirement**                                                                            |
|:-----------------------------|:---------------------------------------------------------------------------------------------------|
| **Operating system version** | Windows 10+                                                                                        |
| **CPU**                      | [See Oculus recommended specifications.](https://support.oculus.com/248749509016567/?locale=en_US) |
| **GPU**                      | [See Oculus recommended specifications.](https://support.oculus.com/248749509016567/?locale=en_US) |
| **Graphics API**             | DX11                                                                                               |

<span id="openxr"></span>

### OpenXR

Refer to the [OpenXR Plugin](https://docs.unity3d.com/Packages/com.unity.xr.openxr@latest/) documentation for a list of compatible runtimes.

<span id="wmr"></span>

### Windows Mixed Reality

| **Specification**            | **Minimum requirement** |
|:-----------------------------|:------------------------|
| **Operating system version** | Windows 10 RS4+         |
| **CPU**                      | Intel 64-bit            |
| **Graphics API**             | DX11                    |

<span id="arcore"></span>

### Google ARCore

| **Specification**                | **Minimum requirement**                                                           |
|:---------------------------------|:----------------------------------------------------------------------------------|
| **Operating system version**     | See list of [ARCore-supported devices](https://developers.google.com/ar/devices). |
| **CPU**                          | ARM 32-bit and 64-bit                                                             |
| **Graphics API**                 | OpenGL ES 3.0+                                                                    |
| **Latest supported SDK version** | ARCore 1.24                                                                       |

<span id="visionos"></span>

### Apple visionOS

<table><thead><tr class="header"><th style="text-align: left;"><strong>Specification</strong></th><th style="text-align: left;"><strong>visionOS 2</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Operating system version</strong></td><td style="text-align: left;">visionOS 2.0</td></tr><tr class="even"><td style="text-align: left;"><strong>Graphics API</strong></td><td style="text-align: left;">Metal or RealityKit</td></tr><tr class="odd"><td style="text-align: left;"><strong>Xcode version</strong></td><td style="text-align: left;">Xcode 16 Beta 6</td></tr><tr class="even"><td style="text-align: left;"><strong>Additional requirements</strong></td><td style="text-align: left;"><ul><li>Apple silicon macOS build of the Unity Editor. The Intel version of the Unity Editor on macOS does not support visionOS development.</li><li>Virtual reality, mixed reality, and hybrid app development requires <a href="https://docs.unity3d.com/Packages/com.unity.polyspatial.visionos@latest/">Unity PolySpatial</a>.</li></ul></td></tr></tbody></table>

**Note:** You can create or update Xcode projects using the visionOS platform module in the Unity Editor on Windows. You must use an Apple silicon computer to run Xcode itself, including to make development and release builds of your app.

<span id="embedded"></span>

### Embedded systems

Support for embedded platforms such as Embedded Linux and QNX is available on request for a wide variety of chipsets as part of Unity Industry, including Linux on ARM based chipsets and additional APIs for Android Automotive. Support for specific embedded configurations is available through Unity’s [Embedded systems support plans](https://unity.com/products/compare-plans/embedded).

The following table lists the recommended system requirements for Unity on embedded systems.

| **Operating system** | **RAM** | **CPU**             | **GPU**                           |
|:---------------------|:--------|:--------------------|:----------------------------------|
| Embedded Linux       | 1GB+    | Dualcore x64, ARM64 | OpenGL ES 3 or Vulkan 1.1 capable |
| QNX                  | 1GB+    | Dualcore x64, ARM64 | OpenGL ES 3 or Vulkan 1.1 capable |

Android (Automotive) system requirements are the same as Android under [Mobile](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html#mobile).

## Additional resources

-   [New in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew.html)
-   [Upgrade Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)

<span class="notooltips"></span>
