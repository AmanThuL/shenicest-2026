---
title: "Scripting API: Application.persistentDataPath"
page_title: "Unity - Scripting API: Application.persistentDataPath"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).persistentDataPath

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>public static string <span class="sig-kw">persistentDataPath</span>;

### Description

Contains the path to a persistent data directory (Read-only).

This value is a directory path where you can store data that you want to retain between runs. When you publish on iOS and Android, `persistentDataPath` points to a public directory on the device. The files can only be erased by users directly and not by any app updates. **Note:** The difference slashes indicate the different operating systems according to Path.DirectorySeparatorChar.  
  
When you build the Unity application, a GUID is generated that is based on the Bundle Identifier. This GUID is part of `persistentDataPath`. If you keep the same Bundle Identifier in future versions, the application keeps accessing the same location on every update.  
  
**UWP Apps**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `C:\Users\<user>\AppData\LocalLow\<company name>`.  
  
**Windows Editor and Windows Player**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) usually points to `%userprofile%\AppData\LocalLow\<companyname>\<productname>`. It is resolved by [SHGetKnownFolderPath](https://docs.microsoft.com/en-us/windows/win32/api/shlobj_core/nf-shlobj_core-shgetknownfolderpath) with FOLDERID_LocalAppDataLow, or [SHGetFolderPathW](https://docs.microsoft.com/en-us/windows/win32/api/shlobj_core/nf-shlobj_core-shgetfolderpathw) with CSIDL_LOCAL_APPDATA if the former is not available.  
  
**Web**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to a location in the browser's IndexedDB file system. The path is formed as `/idbfs/<hash>`, where `<hash>` is an MD5 hash generated from the URL of the directory containing the application's web page. The specific filename (for example: `index.html`) and any URL query parameters don't alter the persistent data path.  
  
**Linux**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `$XDG_CONFIG_HOME/unity3d/Company/ProjectName`, where `$XDG_CONFIG_HOME` defaults to `~/.config`. For example: `~/.config/unity3d/CompanyName/ProductName`.  
  
**iOS**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `/var/mobile/Containers/Data/Application/<guid>/Documents`.  
  
**tvOS**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) is not supported and returns an empty string.  
  
**Android**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `/storage/emulated/<userid>/Android/data/<packagename>/files` on most devices (some older phones might point to location on SD card if present), the path is resolved using [android.content.Context.getExternalFilesDir](https://developer.android.com/reference/android/content/Context#getExternalFilesDir(java.lang.String)).  
  
**macOS Editor**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `~/Library/Application Support/company name/product name`.  
  
**macOS Player**: [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) points to `~/Library/Application Support/unity.company name.product name`, but uses the Editor path if that directory already exists.  
  
**Saving files to this path:** Some Unity APIs (for example, [ScreenCapture.CaptureScreenshot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScreenCapture.CaptureScreenshot.html)) interpret relative paths as relative to the project directory on Windows Editor and other non-mobile platforms, not relative to `persistentDataPath`. Therefore, screenshots or other files saved with a relative path end up in the project folder, not in `AppData/LocalLow` on Windows. To save files to the persistent data path, pass a full path: `System.IO.Path.Combine(Application.persistentDataPath, "filename.png")`.

``` codeExampleCS
using UnityEngine;

public class Info : MonoBehaviour

}
```
