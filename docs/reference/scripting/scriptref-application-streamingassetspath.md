---
title: "Scripting API: Application.streamingAssetsPath"
page_title: "Unity - Scripting API: Application.streamingAssetsPath"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-streamingAssetsPath.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-streamingAssetsPath.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).streamingAssetsPath

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

<span style="color:red;"> </span>public static string <span class="sig-kw">streamingAssetsPath</span>;

### Description

The path to the `StreamingAssets` folder (Read Only).

Use the `StreamingAssets` folder to store assets. Create it in your project at **Assets/StreamingAssets**. At runtime, `Application.streamingAssetsPath` provides the path to the folder. In a built Player, the StreamingAssets location can differ from the project folder, so always use `Application.streamingAssetsPath`. Add the asset name to `Application.streamingAssetsPath`. The built application can load the asset at this address. You can use the [Debug.Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html) class to print the path to the `StreamingAssets` folder to the Unity Console.  
  
You cannot use synchronous filesystem APIs, such as the C# `System.IO.File` class, to access the `StreamingAssets` folder on the WebGL and Android platforms. No file access is available on WebGL. Android uses a compressed `.apk` file. These platforms return a URL. Use the [UnityWebRequest](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Networking.UnityWebRequest.html) class to access the assets.  
  
You can add streaming assets to the Player build without placing them in the `StreamingAssets` folder by using [BuildPlayerProcessor.PrepareForBuild](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.PrepareForBuild.html). This is useful for including files located outside your Unity project.

``` codeExampleCS
using UnityEngine;
using System.IO;
using UnityEngine.Video;

// Application-streamingAssetsPath example.
//
// Play a video and let the user stop/start it.
// The video location is StreamingAssets. The video is
// played on the camera background.

public class Example : MonoBehaviour

    void OnGUI()
    
            else
            
        }
    }
}
```

The following code example demonstrates how to access a file in the `StreamingAssets` folder on Android (and similarly WebGL) platforms. On both Android and WebGL, treat `Application.streamingAssetsPath` as a URL and use [UnityWebRequest](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Networking.UnityWebRequest.html) (not synchronous filesystem APIs such as `System.IO.File`) to read StreamingAssets.

``` codeExampleCS
using UnityEngine;
using UnityEngine.Networking;
using System.Threading.Tasks;

public class LoadStreamingAsset : MonoBehaviour

        if (request.result == UnityWebRequest.Result.Success)
        
        else
        
    }
}
```
