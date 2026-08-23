---
title: "Using Code Coverage with Test Runner"
page_title: "Using Code Coverage with Test Runner | Code Coverage | 1.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageTestRunner.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageTestRunner.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Using Code Coverage with Test Runner

When running your tests in the [Test Runner](https://docs.unity3d.com/Manual/test-framework/test-framework-introduction.html) you can generate an [HTML report](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html) which shows which lines of your code the tests cover. This includes both `EditMode` and `PlayMode` tests.

If **Auto Generate Report** is checked, then an [HTML report](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html) is generated and a file viewer window opens (if **Auto Open Report** is checked too). It contains the coverage results and the report. Otherwise, select **Generate Report** to generate the report. The results are based on the assemblies specified in **Included Assemblies**.

## Steps

1.  Open the [Code Coverage window](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CodeCoverageWindow.html) (go to **Window** > **Analysis** > **Code Coverage**).  
      
    ![Code Coverage Window](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/using_coverage/open_coverage_window.png)

2.  Select **Enable Code Coverage** if not already selected, to be able to generate Coverage data and reports.  
    ![Enable Code Coverage](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/using_coverage/enable_code_coverage.png)  
    **Note:** Enabling Code Coverage adds some overhead to the Editor and can affect the performance.

3.  Select the [Assembly Definitions](https://docs.unity3d.com/Manual/ScriptCompilationAssemblyDefinitionFiles.html) you would like to see the coverage for. In this example we selected `Assembly-CSharp` and `Assembly-CSharp-Editor`. By default, Unity compiles almost all project scripts into the `Assembly-CSharp.dll` managed assembly and all Editor scripts into the `Assembly-CSharp-Editor.dll` managed assembly.  
      
    ![Select Assemblies](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/using_coverage/select_assemblies.png)

4.  Switch to the [Test Runner](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/manual/workflow-run-test.html) and run your `EditMode` and/or `PlayMode` test(s).  
      
    ![Run Tests in Test Runner](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/coverage_testrunner/test_runner.png)

Example test:

    using NUnit.Framework;
    using Assert = UnityEngine.Assertions.Assert;

    public class EditorTests
    
    }

5.  When the test(s) finish running, a file viewer window opens containing the coverage report. Alternatively, select the **Results Location** dropdown to open it in the file viewer.  
      
    **Note:** To generate the report automatically after the Test Runner has finished running the tests, select **Auto Generate Report** in the [Code Coverage window](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CodeCoverageWindow.html). Alternatively, you can select **Generate Report**.  

6.  Select `index.htm`.  
      
    ![Report File Viewer](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/using_coverage/index_folder.png)  
      
    This opens the [HTML coverage report](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html).  
      
    ![HTML Coverage Report](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/images/coverage_testrunner/report_html.png)  

## Get results for EditMode and PlayMode tests

Coverage data are generated from the last set of tests that were run in the [Test Runner](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/manual/workflow-run-test.html).  
  
**Note:** Currently the [Test Runner](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/manual/workflow-run-test.html) does not support `EditMode` and `PlayMode` tests running at the same time. In [version 2.0](https://docs.unity3d.com/Packages/com.unity.test-framework@2.0/manual/whats-new.html#added) of the Test Framework this will be possible. In the meantime, to include coverage for both `EditMode` and `PlayMode` tests, you must run these separately. In this case, the last Coverage Report generated will include the combined coverage of `EditMode` and `PlayMode` tests.

If a fresh start is required, select **Clear Results** to clear the Coverage data from all previous test runs for both `EditMode` and `PlayMode` tests.

## Get coverage by test methods

To see how each test contributes to the overall coverage check **Test Runner References**. For more details see [Coverage by test methods](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html#coverage-by-test-methods).
