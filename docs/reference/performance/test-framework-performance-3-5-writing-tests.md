---
title: "Writing performance tests"
page_title: "Writing a simple test | Performance testing API | 3.5.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.test-framework.performance@3.5/manual/writing-tests.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.test-framework.performance@3.5/manual/writing-tests.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Writing a simple test

This example uses `Measure.Method` to measure the performance of Vector2 operations. This executes the provided method and samples performance. Increasing `MeasurementCount` from the default of 7 to 20 improves performance test stability. You can execute a `Vector2.MoveTowards` test in Edit Mode or Play Mode.

``` lang-csharp
[Test, Performance]
public void Vector2_operations()
{
    var a = Vector2.one;
    var b = Vector2.zero;

    Measure.Method(() =>
    {
            Vector2.MoveTowards(a, b, 0.5f);
            Vector2.ClampMagnitude(a, 0.5f);
            Vector2.Reflect(a, b);
            Vector2.SignedAngle(a, b);
    })
        .MeasurementCount(20)
        .Run();
}
```

To view the results, go to **Window \> General \> Performance Test Report**.

![Performance test example01](https://docs.unity3d.com/Packages/com.unity.test-framework.performance@3.5/manual/images/example01.png)

In this example, the results show that the first method execution took five times longer than the subsequent methods, and those subsequent method executions were unstable. Also, you can't tell from these test results how long it took for each Vector2 operation to execute.

## Improving test stability

Now we'll look at how to improve the stability of our test. Instability can occur at the beginning of a test for several reasons, such as entering Play Mode or method initialization, because the tested method is quite fast and more sensitive to other running background processes.

To improve stability, use `WarmupCount(n)`. This allows you to execute methods before recording data, so Unity doesn't record method initialization. The simplest way to increase test execution time is to repeat the method in a loop. Avoid having measurements that are less than 1ms because they are usually more sensitive to unstable environments.

To help you track the execution time for each operation, split the Vector2 operations into several tests. Often, when writing tests, we use setup and clean up methods to isolate the test environment. However, in this case, methods are isolated and do not affect other methods, so we don't need a cleanup or setup. The following code example shows a performance test for the `Vector2.MoveTowards` operation. Other Vector2 performance tests are identical.

``` lang-csharp
[Test, Performance]
public void Vector2_MoveTowards()
{

    Measure.Method(() =>
    {
        Vector2.MoveTowards(Vector2.one, Vector2.zero, 0.5f);
    })
        .WarmupCount(5)
        .IterationsPerMeasurement(10000)
        .MeasurementCount(20)
        .Run();
}
```

With 100000 iterations in this test, we see a small fluctuation in method execution time but the standard deviation is low, which means the test is reasonably stable.

![Performance test example02](https://docs.unity3d.com/Packages/com.unity.test-framework.performance@3.5/manual/images/example02.png)

## Measure a Play Mode only method

To measure a method that only runs in Play Mode (for example `Physics.Raycast`), you can use `Measure.Frames()`, which records time per frame by default. To only measure `Physics.Raycast` time, you can disable frame time measurements with `DontRecordFrametime` and just measure the `Physics.Raycast` profiler marker. This test creates objects that you need to dispose of at the end of each test, because multiple unnecessary objects can affect the next test results. Use the SetUp method to create GameObjects, and the TearDown method to destroy the created GameObjects after each test.

``` lang-csharp
[SetUp]
public void SetUp()

}

[UnityTest, Performance]
public IEnumerator Physics_RaycastTests()

public class Raycast : MonoBehaviour

}

[TearDown]
public void TearDown()

```

To record your own measurements, create a new sample group and record a custom metric. The following example measures `Allocated` and `Reserved` memory.

``` lang-csharp
[Test, Performance]
public void Empty()

}
```

Before you start to collect package performance data, make sure the tests you run locally are stable (the data set deviation is \<5%). In the **Performance Test Report** window, ensure the test isn't fluctuating and that the results between runs are similar.

Results of performance tests run on a local machine can be significantly different to previous test runs because of other applications running in the background, CPU overheating, or CPU boosting. Make sure that CPU intensive applications are turned off where possible. You can disable CPU boost in the BIOS or with third-party software such as Real Temp.

For comparing performance data between runs, use the [Unity Performance Benchmark Reporter](https://github.com/Unity-Technologies/PerformanceBenchmarkReporter/wiki), which provides a graphical HTML report that enables you to compare performance metric baselines and subsequent performance metrics.

## Further examples

#### Example 1: Measure Frame Time For Scene

``` lang-csharp
    [UnityTest, Performance, Version("4")]
    public IEnumerator MainSceneFrameTime_StartPosition()
    
        }

        // Measure frame times for ten seconds during rest of the "Demo" scene
        using (Measure.Frames().Scope("FrameTime.Main"))
        
    }
```

#### Example 2: Measure execution time to serialize simple object to JSON

``` lang-csharp
    [Test, Performance, Version("2")]
    public void Serialize_SimpleObject()
    
    [Serializable]
    public class SimpleObject
    
        public NestedStruct Str;

        public Vector3 Position;

        public void Init()
        
    }
```

#### Example 3: Measure execution time to create 5000 simple cubes

``` lang-csharp
    string[] markers =
    {
        "Instantiate",
        "Instantiate.Copy",
        "Instantiate.Produce",
        "Instantiate.Awake"
    };

    [Test, Performance]
    public void Instantiate_CreateCubes()
    
            }
        }
    }
```

#### Example 4: Custom measurement to capture total allocated and reserved memory

``` lang-csharp
    [Test, Performance, Version("1")]
    public void Measure_Empty()
    
```
