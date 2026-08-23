---
title: "Setting up and tearing down tests (UnitySetUp / UnityTearDown)"
page_title: "Unity - Manual: Setting up and tearing down tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-unitysetup-and-unityteardown.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-unitysetup-and-unityteardown.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Setting up and tearing down tests

The [`[UnitySetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnitySetUpAttribute.html) and [`[UnityTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTearDownAttribute.html) attributes are equivalent to the NUnit [`[SetUp]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/setup.html) and [`[TearDown]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/teardown.html) attributes, with the exception that they allow for [yielding instructions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html) for the Unity Editor. The `[UnitySetUp]` and `[UnityTearDown]` attributes expect a return type of [IEnumerator](https://docs.microsoft.com/en-us/dotnet/api/system.collections.ienumerator?view=netframework-4.8).

The [`[UnityOneTimeSetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeSetUpAttribute.html) and [`[UnityOneTimeTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeTearDownAttribute.html) attributes are equivalent to the NUnit [`[OneTimeSetUp]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/onetimesetup.html) and [`[OneTimeTearDown]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/onetimeteardown.html) attributes, with the exception that they allow for [yielding instructions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html) for the Unity Editor. The `[UnityOneTimeSetUp]` and `[UnityOneTimeTearDown]` attributes expect a return type of [IEnumerator](https://docs.microsoft.com/en-us/dotnet/api/system.collections.ienumerator?view=netframework-4.8).

For more information and usage examples, refer to the respective API references for [`[UnitySetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnitySetUpAttribute.html), [`[UnityTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTearDownAttribute.html), [`[UnityOneTimeSetUp]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeSetUpAttribute.html), and [`[UnityOneTimeTearDown]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityOneTimeTearDownAttribute.html).

## Execution order

`[UnitySetUp]` and `[UnityTearDown]` can be used with either the `[Test]` or `[UnityTest]` test attributes. In both cases the relative execution order of Unity and non-Unity `[SetUp]` and `[TearDown]` attributes is the same. The only difference is that a `[UnityTest]` allows for yielding instructions during the test that can result in a domain reload, in which case the non-Unity `[SetUp]` methods are re-run before proceeding to the second part of the test.

![The order of execution for setup and teardown event callbacks, with those that re-run on domain reload differentiated from those that don’t.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/execution-order-unitysetup-teardown.png)

## Base and derived classes

The term **base** in the execution order denotes a base class from which a test class inherits. `UnitySetUp` and `UnityTearDown` follow the same pattern as NUnit `SetUp` and `TearDown` attributes in determining execution order between base classes and their derivatives. `SetUp` methods are called on base classes first, and then on derived classes. `TearDown` methods are called on derived classes first, and then on the base class. For more information, refer to the [NUnit Documentation](https://docs.nunit.org/articles/nunit/technical-notes/usage/SetUp-and-TearDown.html).

The following example demonstrates a base and derived class. You can verify the execution order through the order of messages printed in the console:

``` lang-cs
    public class BaseClass
    
        [SetUp]
        public void SetUp()
        
        [UnitySetUp]
        public IEnumerator UnitySetUp()
        
        [TearDown]
        public void TearDown()
        
        [UnityTearDown]
        public IEnumerator UnityTearDown()
        
    }

    public class DerivedClass: BaseClass
    
        [SetUp]
        public new void SetUp()
        
        [UnitySetUp]
        public new IEnumerator UnitySetUp()
        
        [Test]
        public void UnitTest()
        
        [UnityTest]
        public IEnumerator UnityTest()
        
        [TearDown]
        public new void TearDown()
        
        [UnityTearDown]
        public new IEnumerator UnityTearDown()
        
        [OneTimeTearDown]
        public void OneTimeTearDown()
        
    }
```

## Domain reload

Edit mode tests can [yield instructions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html) that result in a domain reload. On domain reload, all non-Unity actions (such as `OneTimeSetup` and `Setup`) are rerun before the code that initiated the domain reload continues. Unity actions (such as `UnitySetup`) are not rerun. If the Unity action is the code that initiated the domain reload, then the rest of the code in the `UnitySetup` method runs after the domain reload.

The following example demonstrates base and derived classes with a domain reload:

``` lang-cs
    public class BaseClass
    
        [SetUp]
        public void SetUp()
        
        [UnitySetUp]
        public IEnumerator UnitySetUp()
        
        [TearDown]
        public void TearDown()
        
        [UnityTearDown]
        public IEnumerator UnityTearDown()
        
    }

    public class DerivedClass: BaseClass
    
        [SetUp]
        public new void SetUp()
        
        [UnitySetUp]
        public new IEnumerator UnitySetUp()
        
        [Test]
        public void UnitTest()
        
        [UnityTest]
        public IEnumerator UnityTest()
        
        [TearDown]
        public new void TearDown()
        
        [UnityTearDown]
        public new IEnumerator UnityTearDown()
        
        [OneTimeTearDown]
        public void OneTimeTearDown()
        
    }
```

## Additional resources

-   [Setup and teardown](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/setup-teardown.html)
-   [Execution order of test actions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-actions-outside-tests.html)
