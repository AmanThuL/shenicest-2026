---
title: "Unity 6.3 Manual: Memory in Unity Web"
page_title: "Unity - Manual: Memory in Unity Web"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Memory in Unity Web

Memory constraints in Unity Web can restrict the complexity of the content you run.

Web content runs in the browser. The browser allocates the memory in its memory space that your application needs to run your content. The amount of available memory varies depending on:

-   The device you use
-   The operating system you use
-   The browser you use, and whether it runs on a 32 or 64 processor
-   How much memory the browser’s JavaScript engine requires to parse your code
-   Whether the browser uses separate processes for each tab, or your content needs to share a memory space with all other open tabs.

**Note:** For information on security risks related to Web memory, refer to [Security and Memory Resources](https://www.w3.org/TR/webgpu/#security-memory-resources).

## Memory usage in Unity Web

The following areas of Unity Web content require the browser to allocate significant amounts of memory.

-   [The Unity heap](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html#unityheap)
-   [Asset data](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html#assetdata)
-   [Garbage collection](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html#garbagecollection)

<span id="unityheap"></span>

## Unity heap

Unity uses a memory heap to store all Unity engine runtime objects. These include managed and native objects, loaded Assets, Scenes, and shaders. This is like the memory that Unity Players use on any other platform.

The Unity heap is a contiguous block of allocated memory. Unity supports automatic resizing for the heap to suit the needs of the application. The heap size expands as an application runs, and can expand up to 4 GB depending on the [**Maximum Memory Size** set in Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html#wasm-language-features). Unity creates this memory heap as a [Memory object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory). The Memory object’s buffer property is a re-sizable ArrayBuffer that holds the raw bytes of memory accessed by WebAssembly code.

Automatic resizing of the heap can cause your application to crash if the browser fails to allocate a contiguous memory block in the address space. For this reason, it’s important to keep the Unity heap size as small as possible. Therefore, be mindful when you are planning the memory usage of your application. If you want to test the size of your Unity heap, you can use the [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) to profile the contents of the memory block.

You can control the initial size and growth of the heap by using the **Memory Growth Mode** options in the [Web Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html). The default options are configured to work well for all desktop use cases. However, for mobile browsers you need to use the advanced tuning options. For mobile browsers, it’s recommended to configure the **Initial Memory Size** to the typical heap usage of the application.

<span id="assetdata"></span>

## Asset data

When you create a Unity Web build, Unity generates a `.data` file. This contains all the Scenes and Assets the application needs to launch. Because Unity Web doesn’t have access to the real file system, it creates a virtual memory file system, and the browser unpacks the `.data` file here. The Emscripten framework (JavaScript) allocates this memory file system in the browser memory space. While your content runs, the browser memory keeps the uncompressed data. To keep both download times and memory usage low, try to keep this uncompressed data as small as possible.

To reduce memory use, you can pack your Asset data into AssetBundles. AssetBundles offer full control over your asset downloads. You can control when your application downloads an asset, and when the runtime unloads it. You can unload unused assets to free up memory.

`AssetBundles` are downloaded directly into the Unity heap, so these don’t result in extra allocation by the browser.

Enable **Data Caching** to automatically cache the Asset data in your content on the user’s machine. This means you don’t need to re-download that data during later runs. The Unity Web loader implements Data Caching with the IndexedDB API and the Caching API. This option allows you to cache files which are usually too large for the browser cache.

To enable the Data Caching option go to **File** \> **Build Profiles** \> **Player Settings** \> **Publishing Settings**.

<span id="garbagecollection"></span>

## Garbage collection

Garbage collection is the process of locating and freeing up unused memory. For an overview on how Unity garbage collection works, refer to [Automatic Memory Management](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory.html). To debug the garbage collection process, use the Unity [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html).

Due to a security limitation of WebAssembly, user programs aren’t allowed to examine the native execution stack to prevent possible exploits. This means that on the Web platform, the garbage collector can only run when no managed code is executing (which can potentially reference live C# objects) and only runs at the end of each program frame. This discrepancy causes differences in garbage collection behavior on Web compared to other platforms.

Because of these differences, code that performs a lot of temporary allocations per-frame, especially if these allocations might exhibit a sequence of linear size growth, might cause a temporary quadratic memory growth pressure for the garbage collector.

For example, if you have a long-running loop, the following code might fail when you run it on Web because the garbage collector doesn’t run between iterations of the for loop. In this case, the garbage collector can’t free up memory that the intermediate string objects use and will run out of memory in the Unity heap.

``` lang-cs
string hugeString = "";

for (int i = 0; i < 100000; i++)

```

In this example, the length of `hugeString` at the end of the loop is 3 \* 100000 = 300000 characters. The code, however, generates a hundred thousand temporary strings before producing the final string. The total allocated memory throughout the loop is 3 \* (1 + 2 + 3 + … + 100000) = 3 \* (100000 \* 100001 / 2) = 15 gigabytes.

To avoid this issue, use [`StringBuilder`](https://learn.microsoft.com/en-us/dotnet/api/system.text.stringbuilder?view=net-9.0) to construct large strings. On native platforms, the garbage collector continuously cleans up previous temporary copies of the string while the loop executes. So this code doesn’t require 15 GB of RAM in total to run:

``` cs
using System.Text;

var stringBuilder = new StringBuilder();
for (int i = 0; i < 10000; i++)

string hugeString = stringBuilder.ToString();
```

If you know the maximum length of the string, it’s best practice to set the [`Capacity`](https://learn.microsoft.com/en-us/dotnet/api/system.text.stringbuilder.capacity?view=net-9.0#system-text-stringbuilder-capacity) of the `StringBuilder` on initialization.

On the Web platform, the garbage collector doesn’t reclaim the temporary string copies until the end of the frame. As a result, the code runs out of memory attempting to allocate 15 GB of RAM.

The following code shows a second example where this type of temporary quadratic memory pressure can occur:

``` lang-cs
byte[] data;

for (int i = 0; i < 100000; i++)

```

Here the code allocates 1 + 2 + 3 + … + 100000 bytes = 5 GB worth of bytes temporarily, even though only the last 100 KB array is preserved. This causes the program to seemingly run out of memory on the Web platform even though only 100 KB are necessary in the final output.

To limit these types of issues, avoid code constructs that perform quadratically increasing amounts of temporary memory allocations. Instead, either pre-allocate the final needed data size, or use a `List<T>` or similar data structure that performs geometrically increasing capacity reservations that mitigate the temporary memory pressure.

For example, with the `List<T>` container, consider using the `List<T>.ReserveCapacity()` function that enables pre-allocating the needed capacity, if you know the final size of the data structure. Likewise, consider using the `List<T>.TrimExcess()` function when shrinking the size of a container that previously held several megabytes of memory.

**Note:** When you use C# delegates or events such as `Delegate`, `Action`, `Func`, these classes internally use similar linear growth allocations as above. Avoid excessive amounts of per-frame delegate registrations and unregistrations with these classes to minimize the temporary memory pressure for the garbage collector on the Web platform.

### NativeArray for temporary allocations

Address some of Unity Web’s garbage collection limitations using [`NativeArray<T>`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Collections.NativeArray_1.html) for temporary allocations. `NativeArray<T>` bypasses the garbage collector and reduces memory pressure on the Unity heap. For more information about `NativeArray<T>`, refer to [Thread safe types](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system-native-container.html).

`NativeArray<T>` has the following limitations compared to memory management with the garbage collector:

-   It supports only base types (for example: byte, int, long, float) and structs as data.
-   It requires manual disposal with `Dispose()` to avoid memory leaks or utilizing the using statement.
-   It doesn’t implement ref return, which means when modifying data, the values need to be copied into a temporary variable and assigned back. For example:

``` cs
   // Updating an element in NativeArray<MyStruct> requires a temporary
   // copy
   MyStruct temp = myNativeArray[i];
   temp.memberVariable = 0;
   myNativeArray[i] = temp;

   // Incrementing an element in NativeArray<int> needs to use explicit
   // assignment since intNativeArrayInt[0]++ won't work
   intNativeArrayInt[0] = intNativeArrayInt[0]++;
```

The following example demonstrates how to use `NativeArray<T>` for temporary allocations on Web:

``` cs
using Unity.Collections;

for (int = 0; i < 10000; i++)

}
```

## Additional resources

-   [Automatic Memory Management](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory.html)
-   [Garbage Collector](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html)
