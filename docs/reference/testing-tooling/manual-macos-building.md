---
title: "Unity 6.3 Manual: Build a macOS application"
page_title: "Unity - Manual: Build a macOS application"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/macos-building.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/macos-building.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Build a macOS application

Refer to the following instructions and considerations on building your Unity application for macOS.

## Target architecture

Before you build an application for macOS, be aware of the chipset differences between Apple devices. Some Apple devices use Intel chipsets and others use Apple silicon. You can use Unity to create both architecture-specific builds and builds that target both Intel and Apple silicon. The available target architectures are:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Architecture</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Intel 64-bit</strong></td><td style="text-align: left;">Use Intel 64-bit to build for Apple devices with Intel chipsets.</td></tr><tr class="even"><td style="text-align: left;"><strong>Apple silicon</strong></td><td style="text-align: left;">Select Apple silicon to build for Apple devices that use the silicon architecture.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Intel 64-bit + Apple silicon</strong></td><td style="text-align: left;">Use Intel 64-bit + Apple silicon to generate a macOS build that works on both Intel chipsets and Apple silicon.<br />
<br />
<strong>Note</strong>: This results in a build that’s larger than the individual architecture-specific builds, impacting the application size.</td></tr></tbody></table>

You can set the target architecture for your application from the [macOS build settings](https://docs.unity3d.com/6000.3/Documentation/Manual/macosbuildsettings.html) in the **Build Profiles** window.

**Note**: Apple is deprecating Rosetta, the translation layer that runs Intel (x64) applications on Apple silicon. To keep your application compatible with future versions of macOS, build for Apple silicon or create a Universal binary instead of an Intel 64-bit build. For more information, refer to [Apple Rosetta deprecation and your Mac Intel-based games](https://discussions.unity.com/t/apple-rosetta-deprecation-and-your-mac-intel-based-games-what-to-do-and-when/1724774).

<span id="building"></span>

## Build the application

To build your Unity application, use the following steps:

1.  Open the [Build Profiles window](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html) from **File** > **Build Profiles**.
2.  Select **Add Build Profile** to open the **Platform Browser** window. The Platform Browser window presents a list of supported platforms that include desktop, mobile, web, and closed platforms.
3.  Select **macOS** from the list of available platforms. If **macOS** isn’t an option, select **Install with Unity Hub** and follow the installation instructions. For information on how to install modules, refer to [Add modules](https://docs.unity.com/hub/add-modules).
4.  Set **Architecture** to the architecture type you want Unity to build your application for.
5.  If you want to create an [Xcode project](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Projects.html) for your application, enable **Create Xcode Project**.
6.  Select **Switch Profile** to set the new build profile as the active profile.
7.  Click **Build**.

**Note**: If building a macOS application on Windows, you must set the executable flag for the binary before opening the application on macOS.

<span id="duplicate-native-source-files"></span>

### Duplicate native source files

When building for macOS, using multiple native source files as plug-ins with the same name that target the same build will cause a build failure.

For example, if two or more files with the same name target different architectures, such as macOS ARM64 and macOS x64, and you build a Universal app that includes both architectures, the build will fail. This is because both files are included in the build, causing build conflicts.

As Xcode doesn’t support the use of files targeting different architectures, you need to merge your files into one or rename them to ensure they’re compatible with both architectures.

<span id="information-property-list-file"></span>

## Information property list file

macOS applications require an information property list file called `Info.plist` that has metadata and configuration information for the application. The file holds a list of key-value pairs.

When Unity builds your application, it creates an `Info.plist` file. Unity stores this file at **ApplicationName.app** \> **Contents** \> **Info.plist**. You can set the required `Info.plist` configuration properties in the [Player](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html) window before building the application. Find these properties in the **Other Settings** \> **Identification** section.

There are additional keys that you can add to your `Info.plist` file. To add them, build the application and use a text editor to edit the file. For information about the available keys, refer to [About Info.plist Keys and Values](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html).

<span id="entitlements"></span>

## Entitlements

macOS applications require [entitlements](https://developer.apple.com/documentation/bundleresources/entitlements) to specify permissions and restrictions that control specific actions of your application. Your application must include entitlements that result in a [Hardened Runtime](https://developer.apple.com/documentation/security/hardened_runtime). These entitlements protect your application from code injection, hijacking of dynamically linked libraries, and memory tampering.

To define entitlements, macOS applications use an XML file with the `.entitlements` file extension. macOS applications then use a process called [code signing](https://docs.unity3d.com/6000.3/Documentation/Manual/macos-building.html#code-signing) to bind the entitlements to an application.

If your application uses plug-ins that perform macOS platform-specific actions, you might need to add entitlements to enable those actions. For more information on what actions require entitlements, refer to [Apple Developer Entitlements](https://developer.apple.com/documentation/bundleresources/entitlements).

<span id="code-signing"></span> <span id="notarization"></span>

## Code signing & notarization

Code signing is the process of creating a code signature for an application. This signature guarantees the integrity of applications and safeguards from any tampering. Apple devices use an application’s code signature to detect changes made after the developer created the code signature. If an application doesn’t have a code signature, the device warns the end user before they open the application.

Notarization is the process Apple uses to check that Developer ID-signed applications don’t contain malicious content. Digital distribution services often require you to notarize your application before you can share it on their platform. The Mac App Store has a content validation system that’s similar to notarization, which means that applications distributed through the store don’t require prior notarization.

For more information on code signing and notarization, refer to [Code sign and notarize your macOS application](https://docs.unity3d.com/6000.3/Documentation/Manual/macos-building-notarization.html).

## Additional resources

-   [macOS build settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/macosbuildsettings.html)
-   [Code sign and notarize your macOS application](https://docs.unity3d.com/6000.3/Documentation/Manual/macos-building-notarization.html)
-   [BuildOptions API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html)
