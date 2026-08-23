---
title: "Unity 6.3 Manual: Technical limitations (Web)"
page_title: "Unity - Manual: Technical limitations"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-technical-overview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-technical-overview.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Technical limitations

Web technology imposes restrictions on Unity web applications designed to run in web browsers. Make sure you’re aware of the following technical limitations before you build your application for the Web platform.

## Platform support

Most popular desktop browser versions support Unity Web content, but do note that different browsers offer [different levels of support](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-browsercompatibility.html).

The following features in Web builds are either not available or limited due to constraints of the platform itself:

### Lack of Web build debug support in Visual Studio

Debugging Web builds isn’t supported in Visual Studio. For more information, refer to [Debug and troubleshoot Web builds](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-debugging.html).

### Lack of Unity cache and caching script support

Web builds don’t support the Unity Cache and Caching Scripting API due to restricted access to the filesystem in browsers. Network requests to asset data and AssetBundles are instead cached in the browser cache. Refer to [Cache behavior in Web](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-caching.html).

### Lack of Input System keyboard layout mapping

The Web platform doesn’t support physical-to-active keyboard mapping, a feature of Unity’s [Input System](https://docs.unity3d.com/Packages/com.unity.inputsystem@latest?subfolder=/manual/index.html). This limitation means that certain [InputControl properties](https://docs.unity3d.com/Packages/com.unity.inputsystem@latest?subfolder=/api/UnityEngine.InputSystem.InputControl.html#properties) that rely on translating physical key codes to a virtual keyboard layout don’t function as expected with non-English keyboards.

### Lack of managed threading support

Managed (C#) threads aren’t supported due to the lack of a multithreaded garbage collection feature in WebAssembly. You can enable partial support for threading in the form of native C/C++ threads with the experimental **Player** setting **Native C/C++ Multithreading**. Refer to [Multithreading support](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-technical-overview.html#multithreading-support).

Due to this limitation, anything in the C# `System.Threading` namespace isn’t supported. For example, use of the `System.Threading.Timer` class doesn’t trigger in Web builds. As well, any timeouts specified in `System.Threading.CancellationTokenSource` don’t actually time out, because the cancellation mechanism is based on `System.Threading.Timer`.

The following code highlights these behavioral differences:

``` lang-cs
using System.Threading;
using UnityEngine;

public class NoMultithreadedTimers : MonoBehaviour

    private void Awake()
    
}

public class NoCancellationTokenSourceTimeouts : MonoBehaviour

    private void Update()
    
} 
```

### Networking limitations

There are a few networking features that Web platform doesn’t support:

-   Browsers don’t allow direct access to IP sockets for networking due to security concerns. For more information, refer to [Web networking](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-networking.html).

-   .NET networking classes within the `System.Net` namespace aren’t supported. For more information, refer to [.NET API support on the Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/web-dotnet-api-support.html).

-   Web platform doesn’t support native socket access because of security limitations within browsers. Therefore, Web also doesn’t support features like ICMP ping or [UnityEngine.Ping](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ping.html).

### .NET API limitations

Some .NET APIs aren’t supported on the Web platform, mainly due to the lack of managed threading and browser networking restrictions. For more information, refer to [.NET API support on the Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/web-dotnet-api-support.html).

### Graphics limitations

There are some limitations in Web platform with the WebGL graphics API, which is based on the functionality of the OpenGL ES graphics library. For more information, refer to [Web graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-graphics.html).

### Audio limitations

Web builds use a custom back end for audio based on the **Web Audio** API, but it only supports the basic audio functionality. For more information, refer to [Audio in Web](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-audio.html).

### Physics limitations

Physics simulations in Web aren’t guaranteed to produce the exact same results as in the Unity Editor or on other platforms. This is because WebAssembly always runs floating-point computations with full precision, while other Unity platforms run physics simulations with a setting enabled (FTZ/DAZ) that flushes extremely small, near-zero numbers (denormals) to zero. The WebAssembly standard doesn’t provide access to the hardware floating point control flags needed to do this.

Because each step in a physics simulation builds on the result of the previous one, small deviations can accumulate over time and lead to noticeable variations in behaviors like collision detection.

### Dynamic generation of code

Web is an AOT platform, so it doesn’t allow dynamic generation of code using `System.Reflection.Emit`. This is the same on all other IL2CPP platforms, iOS, and most consoles.

## Multithreading support <span id="multithreading-support"></span>

Although Unity provides multithreading support for native C/C++ code, the Web platform doesn’t yet support C# multithreading due to limitations of WebAssembly. This means that applications built using the Web platform must run on a single C# thread.

**Notes**:

-   The Web platform supports C/C++ multithreading only if you enable [Native C/C++ support](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html#multithreading) in the Web Player settings.

-   The Web platform supports multithreading, when your document is within a secure context.

    The following HTTP response headers must be set by the server.

    -   [Cross-Origin-Opener-Policy: same-origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy)
    -   [Cross-Origin-Embedder-Policy: require-corp](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)
    -   [Cross-Origin-Resource-Policy: cross-origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Resource-Policy)

The recommended way to perform complex asynchronous tasks on the Web platform is to use [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.Awaitable.html), which can replace `System.Threading.Tasks.Task` in most cases. For details, refer to [Introduction to asynchronous programming with Awaitable](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html).

You can also use [coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html) for asynchronous workflows. But note that `Awaitable` can return values directly and automatically throws errors, while coroutines require additional logic for both of these tasks.

The following factors limit the multithreading support:

### Constraints on native stack scanning

The Web platform uses WebAssembly, which is a bytecode format for secure and efficient execution of Unity code in web browsers. Web browsers are designed to run the code in a secure and isolated environment which blocks direct access to the native WebAssembly stack. This affects multithreaded garbage collection as the Web garbage collector runs only once at the end of every frame unlike incrementally over multiple frames on other platforms.

### No pre-emptive thread signaling support

Background Workers on the web execute code in parallel independently from each other. On native platforms, the main thread can synchronously send signals to the other threads to pause for garbage collection. This synchronous signaling isn’t supported on the web, which prevents WebAssembly compiled C# code from running in multiple threads.

## Build and run limitations

Unity uses a web server with only basic functionality to host web builds created with **Build and Run** (menu: **Edit** \> **Build Profiles** \> **Build and Run**).

The server doesn’t support data caching, which affects:

-   The `.data` file, which includes all scenes and assets of a build that don’t use [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html) or [Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@latest?subfolder=/manual/index.html).
-   Addressables and AssetBundle files.

## Additional resources

-   [Secure context](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts)
-   [Garbage collection](https://docs.unity3d.com/2023.3/Documentation/Manual/webgl-memory.html#garbagecollection)
