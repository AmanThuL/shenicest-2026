---
title: "Unity 6.3 Manual: .NET API support on the Web platform"
page_title: "Unity - Manual: .NET API support on the Web platform"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/web-dotnet-api-support.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/web-dotnet-api-support.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# .NET API support on the Web platform

The Web platform supports most of the [.NET API](https://learn.microsoft.com/en-us/dotnet/api/?view=netframework-4.8.1), but some APIs have limitations due to browser security restrictions, the absence of managed threading, and the lack of raw network socket access.

## System.Collections.Concurrent

All containers in `System.Collections.Concurrent` compile on the Web platform, but they lack real thread safety. Unity replaces the synchronization primitives in these containers with empty functions. Use the [Collections package](https://docs.unity3d.com/Packages/com.unity.collections@6.6/manual/index.html) as an alternative for Burst-compiled jobs.

## System.IO

Most file I/O works through Emscripten’s in-memory virtual file system (MEMFS). Asynchronous I/O APIs don’t work because they are backed by the `ThreadPool`. The following table lists the APIs with limitations.

| **Class**                   | **Status**          | **Notes**                                                                           |
|:----------------------------|:--------------------|:------------------------------------------------------------------------------------|
| **DriveInfo**               | Not supported       | All methods throw `NotSupportedException`.                                          |
| **FileStream**              | Partially supported | All synchronous operations work. Async methods cause an unrecoverable browser hang. |
| **FileSystemAclExtensions** | Not supported       | Windows-only. All methods throw `NotSupportedException`.                            |

## System.Threading

Because the Web platform doesn’t support managed threading, most APIs in this namespace have limited functionality. Synchronization primitives compile and execute without throwing, but their threading behavior has no effect. The only exceptions are `Interlocked`, `Thread.MemoryBarrier` and `Volatile`, which provide real hardware semantics inside Burst-compiled jobs.

The following table lists the APIs with limitations.

| **Class**                       | **Status**          | **Notes**                                                                                                                                           |
|:--------------------------------|:--------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------|
| **CancellationTokenSource**     | Partially supported | The timeout mechanism doesn’t work because it relies on `Timer`.                                                                                    |
| **CompressedStack**             | Not supported       | All methods throw `NotSupportedException`.                                                                                                          |
| **EventWaitHandle**             | Not supported       | Named event handles throw `NotSupportedException`. Other methods execute but have no effect.                                                        |
| **HostExecutionContextManager** | Not supported       | All methods throw `NotImplementedException`.                                                                                                        |
| **Interlocked**                 | Partially supported | The method executes without effect in managed code, but provides real hardware semantics inside Burst-compiled jobs.                                |
| **Monitor**                     | Not supported       | Other methods execute but have no effect.                                                                                                           |
| **Mutex**                       | Not supported       | Named mutexes throw `NotSupportedException`. Other methods execute but have no effect.                                                              |
| **Semaphore**                   | Not supported       | Named semaphores throw `NotSupportedException`. Other methods execute but have no effect.                                                           |
| **Thread**                      | Not supported       | Can be constructed. `Start()` doesn’t throw, but thread delegates don’t execute. `Join`, `Priority` (set), and `DisableComObjectEagerCleanup` fail. |
| **Thread.MemoryBarrier**        | Partially supported | The method executes without effect in managed code, but provides real hardware semantics inside Burst-compiled jobs.                                |
| **ThreadPool**                  | Not supported       | `QueueUserWorkItem` and `UnsafeQueueUserWorkItem` accept calls but callbacks never execute.                                                         |
| **Timer**                       | Not supported       | Doesn’t work because it relies on `ThreadPool`.                                                                                                     |
| **Volatile**                    | Partially supported | The method executes without effect in managed code, but provides real hardware semantics inside Burst-compiled jobs.                                |

## System.Threading.Tasks

The following types and methods in the `System.Threading.Tasks` namespace function correctly:

-   `ValueTask`
-   `ValueTask<T>`
-   `TaskCompletionSource<T>`
-   Synchronous factory methods such as `Task.FromResult` and `Task.CompletedTask`.

All APIs that schedule work through the `ThreadPool` cause an unrecoverable browser hang. Use [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html) for asynchronous programming because it has lower memory overhead than `Task`.

The following table lists the APIs with limitations.

| **Class**                         | **Status**    | **Notes**                                                                                     |
|:----------------------------------|:--------------|:----------------------------------------------------------------------------------------------|
| **Parallel**                      | Not supported | All methods (`For`, `ForEach`, `Invoke`) cause an unrecoverable browser hang.                 |
| **Task.Delay**                    | Not supported | Causes an unrecoverable browser hang. The internal timer doesn’t fire.                        |
| **Task.Run**                      | Not supported | Causes an unrecoverable browser hang. Schedules work through `ThreadPool`.                    |
| **TaskFactory / TaskFactory\<T>** | Not supported | `StartNew`, `ContinueWhenAll`, and `ContinueWhenAny` all cause an unrecoverable browser hang. |

## System.Timers

`System.Timers.Timer` doesn’t work on the Web platform because the `Elapsed` event relies on the thread pool mechanism, which doesn’t function.

## System.Net and System.Net.Http

The following data classes in the `System.Net` and `System.Net.Http` namespaces function correctly:

-   `Cookie`
-   `WebHeaderCollection`
-   `SocketAddress`
-   `HttpRequestMessage`
-   `StringContent`
-   `MultipartContent`

`HttpListener` isn’t supported because it isn’t possible to run a web server inside a browser.

The following classes aren’t implemented and cause an unrecoverable browser hang:

-   `HttpClient`
-   `WebClient`
-   `HttpWebRequest`
-   `FileWebRequest`

Use [UnityWebRequest](https://docs.unity3d.com/ScriptReference/Networking.UnityWebRequest.html) as an alternative for HTTP requests.

## System.Net.Security

`SslStream` and `NegotiateStream` aren’t supported. Configuration option classes work.

## System.Net.Sockets

The browser sandbox doesn’t expose POSIX sockets. Only pure data types such as `LingerOption` and `SocketException` work.

As an alternative, use the browser’s [WebSocket](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket) or [WebRTC](https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API) APIs through a JavaScript plug-in. Another option is the [Emscripten POSIX socket implementation](https://emscripten.org/docs/porting/networking.html), which proxies socket operations through a WebSocket-based relay server to connect to real socket ports on non-web clients or servers.

## System.Net.WebSockets

`ClientWebSocket` isn’t supported. Use the browser’s [WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket) directly through a JavaScript plug-in or a third-party plug-in.

## Additional resources

-   [Introduction to Web multithreading](https://docs.unity3d.com/6000.3/Documentation/Manual/web-multithreading-intro)
-   [UnityWebRequest](https://docs.unity3d.com/ScriptReference/Networking.UnityWebRequest.html)
-   [Introduction to asynchronous programming with Awaitable](https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html)
-   [Emscripten networking](https://emscripten.org/docs/porting/networking.html)
