---
title: "Project Auditor: run from command line"
page_title: "Run Project Auditor from the command line | Project Auditor | 3.0.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/run-from-command-line.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/run-from-command-line.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

##### Note

This documentation is for the Project Auditor package, compatible with Unity 6.3 and earlier. Unity versions 6.4 and later include Project Auditor built-in by default. You can open it from **Window** \> **Analysis** \> **Project Auditor**. For the documentation on the built-in Project Auditor included in Unity 6.4 and later, refer to the Unity User Manual documentation [Analyze your project with Project Auditor](https://docs.unity3d.com/6000.4/Documentation/Manual/project-auditor/analyze-project.html).

# Run Project Auditor from the command line

You can execute Project Auditor's analysis from command line by launching the Unity Editor <a href="https://docs.unity3d.com/Manual/CLIBatchmodeCoroutines.html" class="xref">in batch mode</a>. This requires an Editor script that creates a `ProjectAuditor` instance and runs the analysis. The following is an example of such a script:

``` lang-c#
using Unity.ProjectAuditor.Editor;
using UnityEngine;

public static class ProjectAuditorCI
{
    public static void AuditAndExport()
    {
        string reportPath = "C:/Dev/MyProject/my-report.projectauditor";
        var projectAuditor = new ProjectAuditor();
        var report = projectAuditor.Audit();
        report.Save(reportPath);

        var codeIssues = report.FindByCategory(IssueCategory.Code);
        Debug.Log($"Project Auditor found {codeIssues.Count} code issues");
    }
}
```

This can be useful for performing automated analysis in a CI/CD environment. You can use the following command line call to launch Unity, run the script, and then exit:

    path/to/unity/executable -batchmode -quit -projectPath path/to/your/project -executeMethod ProjectAuditorCI.AuditAndExport

For more information on how to run the Unity Editor via command line, refer to <a href="https://docs.unity3d.com/Manual/EditorCommandLineArguments.html" class="xref">Unity Editor command line arguments</a>.

## Configure Project Auditor

The <a href="https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/api/Unity.ProjectAuditor.Editor.ProjectAuditor.html" class="xref"><code>ProjectAuditor</code></a> class provides the interface for running project analysis, via its `Audit` and `AuditAsync` methods, which return a `Report` object. In the previous code example, `Audit` doesn't take any configuration parameters, which means it creates and uses an `AnalysisParams` object with default values. This results in a full analysis of the project, targeting the currently-selected build platform and performing a Player code build.

To configure analysis differently, or to specify callbacks for some stages in the analysis process, create an`AnalysisParams` object and configure it as required, then pass it as a parameter into a `ProjectAuditor` Audit method.

For example, the following code performs asynchronous analysis of a project's code (ignoring other areas such as Assets and Project Settings) on the default player assembly, compiled in debug mode for Android devices. Callbacks are declared to count and log the number of issues.

``` lang-c#
int foundIssues = 0;
var analysisParams = new AnalysisParams
{
  Categories = new[] { IssueCategory.Code },
  AssemblyNames = new[] { "Assembly-CSharp" },
  Platform = BuildTarget.Android,
  CodeOptimization = CodeOptimization.Debug,
  OnIncomingIssues = issues => { foundIssues += issues.Count(); },
  OnCompleted = (report) =>
  {
    Debug.Log($"Found {foundIssues} code issues");
    report.Save(reportPath);
  }
};

projectAuditor.AuditAsync(analysisParams);
```

## Additional resources

-   [Compare issues and insights](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/compare-issues.html)
-   [Create custom analyzers](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/custom-analyzers.html)
-   <a href="https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/api/Unity.ProjectAuditor.Editor.ProjectAuditor.html" class="xref"><code>ProjectAuditor</code> API documentation</a>
