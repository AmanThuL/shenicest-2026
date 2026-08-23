---
title: "Unity 6.3 Manual: C# compiler and language version reference"
page_title: "Unity - Manual: C# compiler and language version reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# C# compiler and language version reference

This version of the Unity Editor uses the following C# compiler and language version:

-   **C# compiler**: [Roslyn](https://github.com/dotnet/roslyn)
-   **C# language version**: [C# 9.0](https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-9)

The Editor passes a default set of options to the C# compiler. To pass additional options in your project, refer to [Conditional compilation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html).

## Garbage collection

Unity uses the [Boehm-Demers-Weiser garbage collector](https://www.hboehm.info/gc/) for both the Mono and IL2CPP [scripting backends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html) and incremental mode by default. For more information on the available garbage collection modes, their meaning, and how to switch between them, refer to [Garbage collection modes](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html).

## Unsupported features

### C# 9.0

-   Suppress emitting localsinit flag
-   Covariant return types
-   Module Initializers
-   Extensible calling conventions for unmanaged function pointers
-   Init only setters

If you try to use unsupported features in your project, compilation generates errors.

### Record support

C# 9 init and record support comes with a few caveats.

-   The type `System.Runtime.CompilerServices.IsExternalInit` is required for full record support as it uses init only setters, but is only available in .NET 5 and later (which Unity doesn’t support). Users can work around this issue by declaring the `System.Runtime.CompilerServices.IsExternalInit` type in their own projects.
-   You shouldn’t use C# records in serialized types because Unity’s serialization system doesn’t support C# records.

### Unmanaged function pointer support

Unity supports unmanaged functions pointers as introduced in C# 9, but it doesn’t support extensible calling conventions. The following example code provides more detailed information about how to correctly use unmanaged function pointers.

The following example targets Windows platforms and requires **Allow ‘unsafe’ Code** to be enabled in the [Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html). To enable it, go to: **Project Settings** \> **Player**. Expand the **Other Settings** panel, navigate to the **Script Compilation** section. For more information on C#’s `unsafe` context, refer to [Microsoft’s unsafe (C# Reference) documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/unsafe) or [Microsoft’s Unsafe code, pointer types, and function pointers documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/unsafe-code).

``` lang-cs
using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class UnmanagedFunctionPointers : MonoBehaviour

}
```

## Additional resources

-   [API compatibility levels for .NET](https://docs.unity3d.com/6000.3/Documentation/Manual/dotnet-profile-support.html).
-   [Platform dependent compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html).
