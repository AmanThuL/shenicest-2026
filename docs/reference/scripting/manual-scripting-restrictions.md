---
title: "IL2CPP limitations (scripting restrictions)"
page_title: "Unity - Manual: IL2CPP limitations"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-restrictions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-restrictions.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# IL2CPP limitations

The IL2CPP back end has some notable limitations, due partly to the inherent characteristics of ahead-of-time (AOT) compilation and partly to platform-specific restrictions.

## Threads

Managed threads aren’t supported on the Web platform. Most APIs in the [`System.Threading`](https://learn.microsoft.com/en-us/dotnet/api/system.threading?view=net-9.0) namespace either execute without effect or don’t function. Some parts of the .NET class libraries also implicitly depend on threads. A common example is the [`System.Timers.Timer`](https://learn.microsoft.com/en-us/dotnet/api/system.timers.timer?view=net-9.0) class, which depends on support for threads. For a detailed breakdown, refer to [.NET API support on the Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/web-dotnet-api-support.html).

## Reflection

Unity supports reflection on AOT platforms. However, if the compiler can’t infer that the code is used via reflection, the code might not exist at runtime. For more information, refer to [Managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping.html).

An AOT platform can’t implement any of the methods in the [`System.Reflection.Emit`](https://learn.microsoft.com/en-us/dotnet/api/system.reflection.emit?view=net-9.0) namespace.

## Exception filters

IL2CPP supports exception filters. However, the execution order of filter statements and `catch` blocks is different because IL2CPP uses C++ exceptions to implement managed exceptions. This isn’t noticeable unless a filter block writes to a field.

On Mono the field write occurs at filter evaluation time, before entering the `catch` block, and in a defined order relative to other filters. On IL2CPP the field write might occur at a different time because the filter is simulated. This can lead to observable differences, such as:

-   A field being updated earlier or later than expected relative to the `catch` or `finally` blocks.
-   Different interleavings when multiple filters exist, potentially changing which updates are visible first.
-   Rare cases where code relying on the filter’s side effects to gate behavior in the `catch` or `finally` sees stale or differently ordered values.

Best practice is to avoid side effects in filters by moving any state changes into the `catch` block (or a helper function called from `catch`) to ensure consistent behavior across IL2CPP and Mono.

## Serialization

AOT platforms might encounter issues with serialization and deserialization because of the use of reflection. If a type or method is only used via reflection as part of serialization or deserialization, the AOT compiler can’t detect that it needs to generate the code required for the type or method.

<span id="Generics"></span>

## Generic types and methods

For generic types and methods, the compiler must determine which generic instances are used because different generic instances might require different code. For example, the code for `List<int>` is different than the code for `List<double>`. However, IL2CPP shares code for usages of reference types, so the same code is used for `List<object>` and `List<string>`.

It’s possible to reference generic types and methods that IL2CPP did not find at compile time in the following cases:

1.  Creating a new generic instance at runtime: `Activator.CreateInstance(typeof(SomeGenericType<>).MakeGenericType(someType));`
2.  Invoking a static method on a generic instance: `typeof(SomeGenericType<>).MakeGenericType(someType).GetMethod("AMethod").Invoke(null, null);`
3.  Invoking a static generic method: `typeof(SomeType).GetMethod("GenericMethod").MakeGenericMethod(someType).Invoke(null, null);`
4.  Some calls to generic virtual functions that can’t be inferred at compile time.
5.  Calls with deeply nested generic value types, such as `Struct<Struct<Struct<...<Struct<int>>>>`.

To support those cases, IL2CPP generates generic code that works with any type parameter. However, this code is slower because it can’t determine a type’s size, or whether it’s a reference or value type. If you need to ensure that faster generic methods are generated, do the following:

-   If the generic argument will always be a reference type, add the `where: class` constraint. IL2CPP then generates the fallback method using reference type sharing, which causes no performance degradation.
-   If the generic argument will always be a value type, add the `where: struct` constraint. This enables some optimizations, but the code will still be slower because the value types can be different sizes.
-   Create a method named `UsedOnlyForAOTCodeGeneration` and add references to the generic types and methods you want IL2CPP to generate. This method never needs to be called. The following example ensures that a specialization for `GenericType<MyStruct>` is generated:

``` lang-cs
public void UsedOnlyForAOTCodeGeneration()
{
    // Ensure that IL2CPP will create code for MyGenericStruct
    // using MyStruct as an argument.
    new GenericType<MyStruct>();

    // Ensure that IL2CPP will create code for SomeType.GenericMethod
    // using MyStruct as an argument.
    new SomeType().GenericMethod<MyStruct>();

    public void OnMessage<T>(T value) 
    {
        Debug.LogFormat("Message value: {0}", value);
    }

    // Include an exception so we can be sure to know if this
    // method is ever called.
    throw new InvalidOperationException(
        "This method is used for AOT code generation only. " +
        "Do not call it at runtime.");
}
```

**Note**: To compile only the single, fully-sharable version of generic code, set the **IL2CPP Code Generation** [Player setting](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html) to **Optimize for code size and build time**. This reduces the number of methods generated, reducing compile time and build size, but comes at the expense of runtime performance.

<span id="Interop"></span>

## Calling managed methods from native code

Managed methods that need to be marshaled to a C function pointer so that they can be called from native code have a few restrictions on AOT platforms:

-   The managed method must be a static method.
-   The managed method must have the `[MonoPInvokeCallback]` attribute.
-   If the managed method is generic, you might need to use the `[MonoPInvokeCallback(Type)]` overload to specify the generic specializations that must be supported. If so, the type must be a generic instance with the correct number of generic arguments. It’s possible to have multiple `[MonoPInvokeCallback]` attributes on a method as follows:

``` lang-cs
// Generates reverse P/Invoke wrappers for NameOf<long> and NameOf<int>
// Note that the types are only used to indicate the generic arguments.
[MonoPInvokeCallback(typeof(Action<long>))]
[MonoPInvokeCallback(typeof(Action<int>))]
private static string NameOfT<T>(T item) 

```

## Unsupported .NET APIs

IL2CPP doesn’t support the following .NET APIs and features:

-   Reflection of the [`MarshalAs`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.marshalasattribute?view=net-9.0) and [`FieldOffset`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.fieldoffsetattribute?view=net-9.0) attributes. It does support these attributes at compile time. You should use these for proper [platform invoke marshaling](https://docs.microsoft.com/en-us/dotnet/framework/interop/marshaling-data-with-platform-invoke).
-   The C# [`dynamic`](https://learn.microsoft.com/en-us/dotnet/csharp/advanced-topics/interop/using-type-dynamic) keyword. This keyword requires JIT compilation, which is not possible with IL2CPP.
-   The [`Marshal.Prelink`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.marshal.prelink?view=net-9.0) or [`Marshal.PrelinkAll`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.marshal.prelinkall?view=net-10.0) API methods.
-   [`System.Diagnostics.Process`](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.process?view=net-9.0) API methods.

For cases where these are required on desktop platforms, use the [Mono scripting back end](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html).

## Additional resources

-   [Unity .NET features](https://docs.unity3d.com/6000.3/Documentation/Manual/overview-of-dot-net-in-unity.html)
