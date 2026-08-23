---
title: "Reference type management"
page_title: "Unity - Manual: Reference type management"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reference type management

Because all non-null [reference-type objects](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/reference-types) and all [boxed value-typed objects](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/types/boxing-and-unboxing) in managed code must be allocated on the managed heap, these objects might be the cause of performance issues in your application. The following sections outline approaches you can take to improve the performance of your code.

## Avoid repeated string concatenation

Strings in C# are [immutable reference types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/reference-types). Unity allocates reference types on the managed heap and they are subject to garbage collection. Because strings are immutable and can’t change once created, avoid creating temporary strings wherever possible.

The following example code combines an array of strings into a single string. Every time a new string is added inside the loop, the previous contents of the result variable become redundant, and the code allocates a whole new string.

``` lang-cs
// Bad C# script example: repeated string concatenations creates lots of
// temporary strings.
using UnityEngine;

public class ExampleScript : MonoBehaviour 
        return result;
    }

}
```

If the input `stringArray` contains `{ “A”, “B”, “C”, “D”, “E” }`, this method generates storage on the heap for the following strings:

-   `“A”`
-   `“AB”`
-   `“ABC”`
-   `“ABCD”`
-   `“ABCDE”`

In this example, you only need the final string, and the others are redundant allocations. The more items that there are in the input array, the more strings this method generates, each longer than the last.

If you need to concatenate a lot of strings together then use Mono library’s [`System.Text.StringBuilder`](http://msdn.microsoft.com/en-gb/library/system.text.stringbuilder.aspx) class. An improved version of the previous script looks like this:

``` lang-cs
// Good C# script example: StringBuilder avoids creating temporary strings,
// and only allocates heap memory for the final result string.
using UnityEngine;
using System.Text;

public class ExampleScript : MonoBehaviour 
        return _sb.ToString();
    }
}
```

A repeated concatenation doesn’t decrease performance too much unless it’s called frequently, like on every frame update. The following example allocates new strings each time `Update` is called, and generates a continuous stream of objects that garbage collector must handle:

``` lang-cs
// Bad C# script example: Converting the score value to a string every frame
// and concatenating it with “Score: “ generates strings every frame.
using UnityEngine;
using UnityEngine.UI;

public class ExampleScript : MonoBehaviour 
}
```

To prevent this continuous requirement for garbage collection, you can configure the code so that the text only updates when the score changes:

``` lang-cs
// Better C# script example: the score conversion is only performed when the
// score has changed
using UnityEngine;
using UnityEngine.UI;

public class ExampleScript : MonoBehaviour 
    }
}
```

To improve this further, you can store the score title (the part that says `“Score: ”`) and the score display in two different `UI.Text` objects, which means that there’s no need for string concatenation. The code must still convert the score value into a string, but this is an improvement on the previous versions:

``` lang-cs
// Best C# script example: the score conversion is only performed when the
// score has changed, and the string concatenation has been removed
using UnityEngine;
using UnityEngine.UI;

public class ExampleScript : MonoBehaviour 
   void Update() 
   }
}
```

For a more optimized version of this, you could use the [`SetText(Char [])` method](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/TMPro.TMP_Text.html#TMPro_TMP_Text_SetText_System_Char___) in the `TMPro.TMP_Text` class of the [UGUI package](https://docs.unity3d.com/Packages/com.unity.ugui@latest). The `SetText` method allows you to use and reuse a `char` array to build the score digit by digit and update the values in the `char` array without needing to use a string.

For further information on the best practices with working with strings in C#, refer to Microsoft’s documentation on [Best practices for comparing strings in .NET](https://learn.microsoft.com/en-us/dotnet/standard/base-types/best-practices-strings).

## Avoid closures and anonymous methods

In general, avoid closures in C# whenever possible. You should minimize the use of [anonymous methods](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/anonymous-types) and [method references](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/method-parameters#reference-parameters) in performance-sensitive code, especially in code that executes on a per-frame basis.

Method references in C# are reference types, so they’re allocated on the managed heap. This means that if you pass a method reference as an argument, you might create temporary allocations. This allocation happens regardless of whether the method you pass is an anonymous method or a predefined one.

Also, when you convert an anonymous method to a closure, the amount of memory required to pass the closure to a method increases a lot.

Here’s a code sample in which a list of randomized numbers need to be sorted in a particular order. This uses an anonymous method to control the sorting order of the list, and the sorting doesn’t create any allocations.

``` lang-cs
// Good C# script example: using an anonymous method to sort a list. 
// This sorting method doesn’t create garbage

List<float> listOfNumbers = getListOfRandomNumbers();

listOfNumbers.Sort( (x, y) =>

(int)x.CompareTo((int)(y/2)) 

);
```

To make this snippet reusable, you might substitute the constant 2 for a variable in local scope:

``` lang-cs
// Bad C# script example: the anonymous method has become a closure,
// and now allocates memory to store the value of desiredDivisor
// every time it is called.

List<float> listOfNumbers = getListOfRandomNumbers();

int desiredDivisor = getDesiredDivisor();

listOfNumbers.Sort( (x, y) =>

(int)x.CompareTo((int)(y/desiredDivisor))

);
```

The anonymous method now needs to access the state of a variable which is outside of its scope, and so the method has become a closure. The `desiredDivisor` variable must be passed into the closure so that the closure’s code can use it.

To ensure that the correct values are passed in to the closure, C# generates an anonymous class that can keep the externally scoped variables that the closure needs. A copy of this class is instantiated when the closure is passed to the `Sort` method, and the copy is initialized with the value of the `desiredDivisor` integer.

Executing the closure requires instantiating a copy of its generated class, and all classes are reference types in C#. For this reason, executing the closure requires allocation of an object on the managed heap.

## Avoid converting value types to reference types

When a value-typed variable gets automatically converted to a reference type this is called [boxing](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/types/boxing-and-unboxing). Boxing is one of the most common sources of unintended temporary memory allocations found in Unity projects. This most often happens when passing primitive value-typed variables (such as `int` and `float`) to object-typed methods.

In this example, the integer in `x` is boxed so that it can be passed to the `object.Equals` method, because the `Equals` method on an object requires that an object is passed to it.

``` lang-cs
int x = 1;

object y = new object();

y.Equals(x);
```

C# IDEs and compilers don’t issue warnings about boxing, even though boxing leads to unintended memory allocations. This is because C# assumes that small temporary allocations are efficiently handled by generational garbage collectors and allocation-size-sensitive memory pools.

While Unity’s managed memory allocator does use different memory pools for small and large allocations, Unity’s [garbage collector](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html) isn’t generational, so it can’t efficiently sweep out the small, frequent temporary allocations that boxing generates.

### Identifying boxing

Boxing appears in CPU traces as calls to one of a few methods, depending on the scripting back end in use. These take one of the following forms, where `<example class>` is the name of a class or struct, and `…` is a number of arguments:

``` lang-cs
<example class>::Box(…)
Box(…)
<example class>_Box(…)
```

To find boxing, you can also search the output of a decompiler or IL viewer, such as the [IL viewer tool built into ReSharper](https://www.jetbrains.com/help/resharper/Viewing_Intermediate_Language.html) or the [dotPeek decompiler](https://www.jetbrains.com/decompiler/). The IL instruction is `box`.

## Avoid the params modifier

Methods that list their optional parameters as with a [`params` modifier](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/method-parameters#params-modifier) allocate an array for the parameters you pass into them. If available, use overrides of these methods that don’t rely on that modifier.

## Additional resources

-   [Managed memory introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html)
-   [Creating reusable code](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html)
-   [Optimizing arrays](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-arrays.html)
