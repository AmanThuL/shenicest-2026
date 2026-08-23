---
title: "Asynchronous tests"
page_title: "Unity - Manual: Asynchronous tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-async-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-async-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Asynchronous tests

You can use the .NET Task asynchronous programming model to write asynchronous tests. If you’re new to asynchronous programming and its applications, refer to the [Microsoft documentation](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/) for a comprehensive guide. The documentation for [NUnit Test](https://docs.nunit.org/articles/nunit/writing-tests/attributes/test.html), also explains the requirements for an asynchronous test. Async code is run on the main thread and Unity Test Framework will `await` it by checking if the task is done on each [update](https://docs.unity3d.com/ScriptReference/PlayerLoop.Update.html) for Play mode or on each [EditorApplication.update](https://docs.unity3d.com/ScriptReference/EditorApplication-update.html) outside Play mode.

Note that any failing log messages will first be evaluated after the async test has completed. This means that if you have a failing log message in an async test, it will not be reported until the test has completed.

The following code snippet demonstrates an async test based on Microsoft’s making breakfast example. Note that the test method is marked with the `async` keyword and has return type `Task`. We set up a list of Tasks corresponding to asynchronous methods representing parts of the breakfast making process. We use `await` to start these tasks in a non-blocking way, write to the log when each one completes, and write again to the log when all are completed.

``` lang-cs
using System.Collections.Generic;
using System.Threading.Tasks;
using NUnit.Framework;
using UnityEngine;

public class AsyncExample
{
    [Test]
    public async Task MakeBreakfast_InTheMorning_IsEdible()
    {
        var eggsTask = FryEggsAsync(2);
        var baconTask = FryBaconAsync(3);
        var toastTask = MakeToastWithButterAndJamAsync(2);

        var breakfastTasks = new List<Task> { eggsTask, baconTask, toastTask };
        while (breakfastTasks.Count > 0)
        
            else if (finishedTask == baconTask)
            
            else if (finishedTask == toastTask)
            
            breakfastTasks.Remove(finishedTask);
        }

        Debug.Log("Breakfast is ready!");
    }

    static async Task<Toast> MakeToastWithButterAndJamAsync(int number)
    
    private static Juice PourOJ()
    
    private static void ApplyJam(Toast toast) =>
        Debug.Log("Putting jam on the toast");

    private static void ApplyButter(Toast toast) =>
        Debug.Log("Putting butter on the toast");

    private static async Task<Toast> ToastBreadAsync(int slices)
    
        Debug.Log("Start toasting...");
        await Task.Delay(3000);
        Debug.Log("Remove toast from toaster");

        return new Toast();
    }

    private static async Task<Bacon> FryBaconAsync(int slices)
    {
        Debug.Log($"putting {slices} slices of bacon in the pan");
        Debug.Log("cooking first side of bacon...");
        await Task.Delay(3000);
        for (int slice = 0; slice < slices; slice++)
        
        Debug.Log("cooking the second side of bacon...");
        await Task.Delay(3000);
        Debug.Log("Put bacon on plate");

        return new Bacon();
    }

    private static async Task<Egg> FryEggsAsync(int howMany)
    {
        Debug.Log("Warming the egg pan...");
        await Task.Delay(3000);
        Debug.Log($"cracking {howMany} eggs");
        Debug.Log("cooking the eggs ...");
        await Task.Delay(3000);
        Debug.Log("Put eggs on plate");

        return new Egg();
    }

    private static Coffee PourCoffee()
    
    public struct Toast
    
    public struct Juice
    
    public struct Bacon
    
    public struct Egg
    
    public struct Coffee
    
}
```

The following shows the result of running this example in the **Test Runner** window:

![The Test Runner window and console displaying the output of the previous async test code example.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/async.png)

## Editor freezing on `Assert.ThrowsAsync` and workaround

NUnit’s assertion for asynchronous code, [Assert.ThrowsAsync](https://docs.nunit.org/articles/nunit/writing-tests/assertions/classic-assertions/Assert.ThrowsAsync.html), blocks the calling thread until the async function you pass in completes. By default Unity runs asynchronous functions on the main thread in case they need to call the Editor API, which means `Assert.ThrowsAsync` can lock up the main thread and cause the Editor to freeze.

To workaround this problem, you can unwrap the `Assert.ThrowsAsync` logic into your own `try`/`catch` blocks and assert that you caught something. For example, **do** this:

``` lang-cs
[Test]
public async Task ThisDoesNotLockTheMainThread()
 
    catch (System.Exception x)
   
   Assert.That(caught);
}
```

**Instead of** this:

``` lang-cs
[Test]
public void ThisLocksTheMainThread()
 
  );
}
```

## Additional resources

-   [Asynchronous programming with the Awaitable class](https://docs.unity3d.com/6000.3/Documentation/Manual/async-await-support.html)
-   [Asserting and comparing](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/asserting-and-comparing.html)
