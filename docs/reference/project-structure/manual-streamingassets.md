---
title: "Include additional files in a build"
page_title: "Unity - Manual: Include additional files in a build"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Include additional files in a build

`StreamingAssets` is a [reserved folder](https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html) that you can use to make files available to a Player build directly and bypass the standard project build process. The standard build process serializes scenes and assets into binary files inside the generated Player. `StreamingAssets` allows you to add files that are already in the correct format for the target platform and that your application can load directly.

Example usages include:

-   Configuration files in JSON, XML, SQLite, or other formats.
-   Video files, for example movie files on iOS devices.
-   Files required by plug-ins.
-   AssetBundles (described below).

The `StreamingAssets` folder must be in the root of the `Assets` folder at `Assets/StreamingAssets`. The name is case sensitive and must be `StreamingAssets` exactly. Any files in this directory are copied without modification into the Player output. When deployed to a target device the files are copied to a location appropriate for the platform.

**Tip**: To avoid the overhead of Unity automatically importing every file from `StreamingAssets`, you can add content from other directories during the build process by calling [`AddAdditionalPathToStreamingAssets`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerContext.AddAdditionalPathToStreamingAssets.html) from a callback that implements [`BuildPlayerProcessor.PrepareForBuild`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.PrepareForBuild.html). This is useful if, for example, your content is large and generated.

## Accessing streaming assets

The location of the `StreamingAssets` folder in your deployed application varies between platforms. To retrieve the path to the `StreamingAssets` folder reliably, use the [`Application.streamingAssetsPath`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-streamingAssetsPath.html) property because it always points to the correct location on the current host platform.

On most platforms [`Application.streamingAssetsPath`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-streamingAssetsPath.html) is a directory accessible using regular file system APIs.

On Android and the Web platform, it’s impossible to access the streaming asset files directly via file system APIs because these platforms return a URL. Use the [`UnityWebRequest`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Networking.UnityWebRequest.html) class to access the content instead.

The following example loads a file from the `StreamingAssets` folder:

``` lang-cs
using UnityEngine;
using UnityEngine.Networking;
using System.Collections;
using System;

public class LoadStreamingAssets : MonoBehaviour

    // This callback receives the raw string data once the coroutine finishes
    void OnFileLoaded(string loadedText)
    
        // The data is now safely out of the coroutine.
        // You can parse it here (e.g., JsonUtility, XML, custom parsing)
        Debug.Log("File loaded successfully: " + loadedText);
    }

    IEnumerator LoadFile(string fileName, Action<string> callback)
    
            else
            {
                Debug.LogError($"Failed to load StreamingAsset: {request.error}");
            }
        }
        else
        
            else
            {
                Debug.LogError($"File not found at: {filePath}");
            }
        }

        // Send the loaded content back to the caller
        callback?.Invoke(fileContent);
    }
}
```

**Note:** If you want to load the data from a JSON file, use the methods in the [`JsonUtility` class](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/JsonUtility.html).

### StreamingAssets folder limitations

-   At runtime the `StreamingAssets` location is read-only and you can’t modify or write new files to it. To write files, you can use [`Application.persistentDataPath`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.persistentDataPath.html) instead.
-   Don’t put Unity files (such as `.unity`, `.prefab`, and `.asset`) into the `StreamingAssets` folder. These file types must be processed by a Player or [AssetBundle](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Building.html) build to be loadable at runtime.
-   `.dll` and script files located in the `StreamingAssets` folder aren’t included during script compilation.

## AssetBundles and the StreamingAssets folder

The `StreamingAssets` folder is useful if you intend to distribute AssetBundles directly in the Player installation, rather than downloading them on-demand.

To do this:

1.  Build the [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Building.html) to an output path inside `Assets/StreamingAssets`. **Note**: The `.manifest` files generated alongside the AssetBundle files aren’t required in the runtime and can be removed. For more information, refer to [AssetBundles file format](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-file-format.html).
2.  [Build the Player](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html). The AssetBundles are included in the platform-specific output.
3.  Write loading code that uses the `Application.streamingAssetsPath` to determine the path to the AssetBundles. Depending on the platform, you can load them as a local file path, or with [`UnityWebRequestAssetBundle`](ScriptingRef:Networking.UnityWebRequestAssetBundle.GetAssetBundle). **Note**: On Android it’s not necessary to cache the AssetBundle or to perform CRC checks, because the file is already present on local storage.

The [Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@latest) package uses this mechanism automatically for local content.

Alternatively, you can host AssetBundles and Addressables on a remote server and downloaded them on-demand rather than using the `StreamingAssets` folder. This is preferred for situations where the content is large, or frequently updated, or where you want to avoid the overhead of releasing new Player builds when you want to change or add new content.

## Additional resources

-   [Loading resources at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html)
-   [Modifying source assets from code](https://docs.unity3d.com/6000.3/Documentation/Manual/ModifyingSourceAssetsThroughScripting.html)
