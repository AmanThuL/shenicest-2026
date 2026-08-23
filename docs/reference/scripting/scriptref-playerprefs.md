---
title: "Scripting API: PlayerPrefs"
page_title: "Unity - Scripting API: PlayerPrefs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# PlayerPrefs

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

<span style="color:red;"> </span>

### Description

`PlayerPrefs` is a class that stores Player preferences between game sessions. It can store string, float and integer values into the user's platform registry.

Unity stores PlayerPrefs in a local registry, without encryption. Don't use PlayerPrefs data to store sensitive data.  
  
Unity stores `PlayerPrefs` data differently based on which operating system the application runs on. In the file paths given on this page, the `ExampleCompanyName`, `ExampleProductName`, and `ExampleBundleIdentifier` are the names you set in Unity's [Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html).  
  
**Standalone Player storage location**  
  
- **Android**: `/data/data/pkg-name/shared_prefs/pkg-name.v2.playerprefs.xml`.  
  
**Notes**:

-   Unity uses [SharedPreferences](https://developer.android.com/reference/android/content/SharedPreferences) API to access the `PlayerPrefs` data and [SharedPreferences.Editor](https://developer.android.com/reference/android/content/SharedPreferences.Editor) API to modify it.
-   C#, Android Java, and native code can all access the `PlayerPrefs` data.

\- **iOS**: Uses the `[NSUserDefaults standardUserDefaults]` API to store PlayerPrefs data.  
  
- **Linux**: `~/.config/unity3d/ExampleCompanyName/ExampleProductName`  
  
- **macOS**: `~/Library/Preferences/ExampleBundleIdentifier.plist`. The default value of **ExampleBundleIdentifier** is **com.ExampleCompanyName.ExampleProductName**. Override this value from the [macOS Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/PlayerSettings-macOS.html).  
  
- **Web**: Unity stores up to 1MB of PlayerPrefs data using the browser's IndexedDB API. For more information, see [IndexedDB](https://developers.google.com/web/ilt/pwa/lab-indexeddb#overview).  
  
- **Windows**: `Computer\HKEY_CURRENT_USER\Software\ExampleCompanyName\ExampleProductName` in the Registry Editor.  
  
- **Windows Universal Platform**: `%userprofile%\AppData\Local\Packages\[ProductPackageId]\LocalState\playerprefs.dat`  
  
**In-Editor Play mode storage location**  
  
- **macOS**: `~/Library/Preferences/com.ExampleCompanyName.ExampleProductName.plist`  
  
- **Windows**: `Computer\HKEY_CURRENT_USER\Software\Unity\UnityEditor\ExampleCompanyName\ExampleProductName` key. Note that Windows uses the key names from the application's PlayerPrefs as a hashed identifier. For example, Unity adds a `DeckBase` string to the hashed key name (for example `h3232628825`) to create `DeckBase_h3232628825`. Unity hashes the names because it:

-   Allows Unity to store case-sensitive key names.
-   Prevents naming conflicts with data the application stores outside of PlayerPrefs.
-   Ensures that you use the PlayerPrefs API to access and modify the values.

The application ignores the extension.

### Static Methods

| Method                                                                                                | Description                                                                                                                          |
|-------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| [DeleteAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.DeleteAll.html) | Removes all keys and values from the preferences. Use with caution.                                                                  |
| [DeleteKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.DeleteKey.html) | Removes the given key from the PlayerPrefs. If the key does not exist, DeleteKey has no impact.                                      |
| [GetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.GetFloat.html)   | Returns the float value that corresponds to key in the player preferences.                                                           |
| [GetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.GetInt.html)       | Gets the int value that corresponds to key in the player preferences.                                                                |
| [GetString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.GetString.html) | Gets the string that corresponds to key in the player preferences.                                                                   |
| [HasKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.HasKey.html)       | Returns true if the given key exists in PlayerPrefs, otherwise returns false.                                                        |
| [Save](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.Save.html)           | Saves all modified preferences.                                                                                                      |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.SetFloat.html)   | Sets the float value of the preference identified by the given key. You can use PlayerPrefs.GetFloat to retrieve this value.         |
| [SetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.SetInt.html)       | Sets a single integer value for the preference identified by the given key. You can use PlayerPrefs.GetInt to retrieve this value.   |
| [SetString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.SetString.html) | Sets a single string value for the preference identified by the given key. You can use PlayerPrefs.GetString to retrieve this value. |
