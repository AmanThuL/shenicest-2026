---
title: "Using Code Coverage in batchmode"
page_title: "Using Code Coverage in batchmode | Code Coverage | 1.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Using Code Coverage in batchmode

You can pass the following arguments in batchmode:

**-enableCodeCoverage**, to enable code coverage.  
**-coverageResultsPath** (optional), to set the location where the coverage results and report are saved to. The default location is the project's path.  
**-coverageHistoryPath** (optional), to set the location where the coverage report history is saved to. The default location is the project's path.  
**-coverageOptions** (optional), to pass extra options. Options are separated by semicolon. Some shells use semicolons to separate commands. Therefore, to ensure that coverage options are parsed correctly, enclose them in quotation marks.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th style="text-align: left;">Coverage Option</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><code>generateHtmlReport</code></td><td style="text-align: left;">Add this to generate a coverage <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html">HTML report</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>generateHtmlReportHistory</code></td><td style="text-align: left;">Add this to generate and include the coverage history in the HTML report.</td></tr><tr class="odd"><td style="text-align: left;"><code>generateAdditionalReports</code></td><td style="text-align: left;">Add this to generate <a href="https://docs.sonarqube.org/latest/analysis/generic-test">SonarQube</a>, <a href="https://cobertura.github.io/cobertura">Cobertura</a> and <a href="https://github.com/linux-test-project/lcov">LCOV</a> reports.</td></tr><tr class="even"><td style="text-align: left;"><code>generateBadgeReport</code></td><td style="text-align: left;">Add this to generate coverage summary badges in SVG and PNG format.</td></tr><tr class="odd"><td style="text-align: left;"><code>generateAdditionalMetrics</code></td><td style="text-align: left;">Add this to generate and include additional metrics in the HTML report. These currently include Cyclomatic Complexity and Crap Score calculations for each method. See the <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html#risk-hotspots">Risk Hotspots</a> section for more information.</td></tr><tr class="even"><td style="text-align: left;"><code>generateTestReferences</code></td><td style="text-align: left;">Add this to include test references to the generated coverage results and enable the <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/HowToInterpretResults.html#coverage-by-test-methods">Coverage by test methods</a> section in the HTML report. This shows how each test contributes to the overall coverage.</td></tr><tr class="odd"><td style="text-align: left;"><code>verbosity</code></td><td style="text-align: left;">Add this to set the verbosity level for the editor and console logs. The default value is <code>info</code>.<br />
<strong>Values:</strong> <code>verbose</code>, <code>info</code>, <code>warning</code>, <code>error</code>, <code>off</code></td></tr><tr class="even"><td style="text-align: left;"><code>useProjectSettings</code></td><td style="text-align: left;">Add this to use the settings specified in <code>ProjectSettings/Packages/com.unity.testtools.codecoverage/</code> <code>Settings.json</code> instead. Any options passed in the command line will override this. This option can only be used in batchmode and it does not take effect when running the editor from the command line in non-batchmode.</td></tr><tr class="odd"><td style="text-align: left;"><code>dontClear</code></td><td style="text-align: left;">Add this to allow coverage results to be accumulated after every code coverage session. If not passed the results are cleared before a new session. For more information see <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#generate-combined-report-from-editmode-and-playmode-tests">Generate combined report from EditMode and PlayMode tests</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>sourcePaths</code></td><td style="text-align: left;">Add this to specify the source directories which contain the corresponding source code. The source directories are used by the report generator when the path information of classes cannot be determined. This is a comma separated string. Globbing is not supported.<br />
<br />
<strong>Example:</strong> See <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#generate-combined-report-from-separate-projects">Generate combined report from separate projects</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>assemblyFilters</code></td><td style="text-align: left;">Add this to specify the assemblies to include or exclude in the coverage calculation and/or report. This is a comma-separated string. Prefix assemblies with <code>+</code> to include them or with <code>-</code> to exclude them. Globbing can be used to filter the assemblies.<br />
<br />
<strong>Available aliases:</strong><br />
<br />
<code>&lt;all&gt;</code> maps to all the assemblies in the project.<br />
<code>&lt;assets&gt;</code> maps to the assemblies under the <code>Assets</code> folder.<br />
<code>&lt;packages&gt;</code> maps to the Packages' assemblies in the project, including the built-in packages.<br />
<br />
<strong>By default, if there are no included assemblies specified, only the assemblies under the <code>Assets</code> folder will be included.</strong><br />
<br />
<strong>Examples:</strong><br />
<br />
<code>assemblyFilters:+&lt;all&gt;</code> will include code from all the assemblies in the project.<br />
<br />
<code>assemblyFilters:+my.assembly</code> will only include code from the assembly called <code>my.assembly</code>.<br />
<br />
<code>assemblyFilters:+unity.*</code> will include code from any assembly whose name starts with <code>unity.</code><br />
<br />
<code>assemblyFilters:-*unity*</code> will exclude code from all assemblies that contain the word <code>unity</code> in their names.<br />
<br />
<code>assemblyFilters:+my.assembly.*,-my.assembly.tests</code> will include code from any assembly whose name starts with <code>my.assembly.</code>, but will explicitly exclude code from the assembly called <code>my.assembly.tests</code>.<br />
<br />
<code>assemblyFilters:+my.locale.??</code> will only include code from assemblies whose names match this format, e.g. <code>my.locale.en</code>, <code>my.locale.99</code>, etc.<br />
<br />
<code>assemblyFilters:+my.assembly.[a-z][0-9]</code> will only include code from assemblies whose names match this format, e.g. <code>my.assembly.a1</code>, <code>my.assembly.q7</code>, etc.</td></tr><tr class="even"><td style="text-align: left;"><code>pathFilters</code></td><td style="text-align: left;">Add this to specify the paths that should be included or excluded in the coverage calculation and/or report. This is a comma-separated string. Prefix paths with <code>+</code> to include them and with <code>-</code> to exclude them. Globbing can be used to filter the paths. Entries are processed in order so a subset path can be included even if the parent path is excluded.<br />
<br />
Both absolute and relative paths are supported. Absolute paths can be shortened using globbing e.g. <code>**/Assets/Scripts/</code>. Relative paths require the <code>sourcePaths</code> option to be set. See <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#using-relative-paths-in-path-filters">Using relative paths in path filters</a>.<br />
<br />
<strong>Note:</strong> If <code>pathFilters</code> are specified and there are no included assemblies specified in <code>assemblyFilters</code>, then all the assemblies in the project are included in order for <code>path filtering</code> to take precedence over <code>assembly filtering</code>.<br />
<br />
<br />
<strong>Examples:</strong><br />
<br />
<code>pathFilters:+C:/MyProject/Assets/MyClass.cs</code> will only include the <code>MyClass.cs</code> file.<br />
<br />
<code>pathFilters:+C:/MyProject/Assets/Scripts/*</code> will include all files in the <code>C:/MyProject/Assets/Scripts</code> folder. Files in subfolders will not be included.<br />
<br />
<code>pathFilters:-C:/MyProject/Assets/AutoGenerated/**</code> will exclude all files under the <code>C:/MyProject/Assets/AutoGenerated</code> folder and any of its subfolders.<br />
<br />
<code>pathFilters:+**/Assets/Editor/**</code> will include just the files that have <code>/Assets/Editor/</code> in their path.<br />
<br />
<code>pathFilters:+C:/MyProject/Assets/**/MyClass.cs</code> will include any file named <code>MyClass.cs</code> that is under the <code>C:/MyProject/Assets</code> folder and any of its subfolders.<br />
<br />
<code>pathFilters:+C:/MyProject/**,-**/Packages/**</code> will only include files under <code>C:/MyProject/</code> folder and exclude all files under any <code>Packages</code> folder.<br />
<br />
<code>pathFilters:+**/Packages/myPackage/**,-**/Packages/**</code> will include just the files that have <code>/Packages/myPackage/</code> in their path and exclude all other files that have <code>/Packages/</code> in their path.<br />
<br />
<code>pathFilters:+**/MyGeneratedClass_??.cs</code> will include only files with filenames that match this format, i.e. <code>MyGeneratedClass_01.cs</code>, <code>MyGeneratedClass_AB.cs</code>, etc.<br />
<br />
<code>pathFilters:+**/MyClass_[A-Z][0-9].cs</code> will include only files with filenames that match this format, i.e. <code>MyClass_A1.cs</code>, <code>MyClass_Q7.cs</code>, etc.</td></tr><tr class="odd"><td style="text-align: left;"><code>pathFiltersFromFile</code></td><td style="text-align: left;">Add this to specify the file to read path filtering rules from. Instead of defining all path filtering rules directly in the command line, as you would with the <code>pathFilters</code> option, this allows you to store them in a separate file, making your commands clearer and easier to manage.<br />
<br />
Like with the <code>pathFilters</code> option, <code>pathFiltersFromFile</code> also supports relative paths. See <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#using-relative-paths-in-path-filters">Using relative paths in path filters</a>.<br />
<br />
<strong>Examples:</strong><br />
<br />
<code>pathFiltersFromFile:C:/MyProject/FilteringRules.txt</code> will read rules from a file located in <code>C:/MyProject/FilteringRules.txt</code><br />
<br />
<code>pathFiltersFromFile:FilteringRules.txt</code> will read rules from <code>FilteringRules.txt</code> located in the root of your project.<br />
<br />
Syntax of the rules is the same as with the <code>pathFilters</code> option, however, rules should be listed in separate lines in the file.<br />
<br />
<strong>File example:</strong><br />
<br />
This will include all the files in the <code>Scripts</code> folder and exclude all the files in the <code>Scripts/Generated</code> folder<br />
<br />
<pre><code>+**/Scripts/**
-**/Scripts/Generated/**</code></pre><br />
<strong>Note:</strong> The <code>pathFiltersFromFile</code> option will be deprecated in the next package major release. Please use the <code>filtersFromFile</code> option instead.</td></tr><tr class="even"><td style="text-align: left;"><code>filtersFromFile</code></td><td style="text-align: left;">Add this to specify the json file to read path and assembly filtering rules from. Instead of defining all filtering rules directly in the command line, as you would with <code>pathFilters</code> and <code>assemblyFilters</code> options, this allows you to store them in a separate file, making your commands clearer and easier to manage.<br />
<br />
Like with the <code>pathFilters</code> option, <code>filtersFromFile</code> also supports relative paths. See <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#using-relative-paths-in-path-filters">Using relative paths in path filters</a>.<br />
<br />
<strong>Examples:</strong><br />
<br />
<code>filtersFromfile:C:/MyProject/FilteringRules.json</code> will read rules from a file located in <code>C:/MyProject/FilteringRules.json</code>.<br />
<br />
<code>filtersFromFile:FilteringRules.json</code> will read rules from <code>FilteringRules.json</code> located in the root of your project.<br />
<br />
<strong>File example:</strong><br />
<br />
This will include the <code>my.included.assembly</code>, exclude <code>my.excluded.assembly</code> and all assemblies with <code>unity</code> in their name. It will also include all files in the <code>Scripts</code> folder, and exclude all files in the <code>Scripts/Generated</code> folder<pre><code>{
   &quot;assembliesInclude&quot;: [ &quot;my.included.assembly&quot; ],
   &quot;assembliesExclude&quot;: [ &quot;my.excluded.assembly&quot;, &quot;*unity*&quot; ],
   &quot;pathsInclude&quot;: [ &quot;**/Scripts/**&quot; ],
   &quot;pathsExclude&quot;:[ &quot;**/Scripts/Generated/**&quot; ]
}</code></pre><strong>Note:</strong> The <code>pathFiltersFromFile</code> option will be deprecated in the next package major release. Please use the <code>filtersFromFile</code> option instead.</td></tr><tr class="odd"><td style="text-align: left;"><code>pathReplacePatterns</code></td><td style="text-align: left;">Add this to replace specific sections from the paths that are stored in the coverage results xml files. This is a comma separated string and requires elements to be passed in pairs i.e. <code>pathReplacePatterns:from,to,from,to</code>. Globbing is supported.<br />
<br />
You can change the file paths in the coverage results xml to relative paths so that coverage data generated on different machines can be merged into a single report. Use the <code>pathReplacePatterns</code> option in conjunction with the <code>sourcePaths</code> option to specify the source directories which contain the corresponding source code. For more information see <a href="https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html#generate-combined-report-from-separate-projects">Generate combined report from separate projects</a>.<br />
<br />
<strong>Note:</strong> The <a href="https://github.com/OpenCover/opencover">OpenCover</a> results xml format specifies file paths as absolute paths (<code>fullPath</code>). Changing these paths to relative paths will invalidate the OpenCover standard format. When the results xml files are fed into other tools, these may not work as expected if the paths are relative.<br />
<br />
<strong>Examples:</strong><br />
<br />
<code>pathReplacePatterns:C:/MyProject,C:/MyOtherProject</code> will store the path as <code>C:/MyOtherProject/Assets/Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProject/Assets/Scripts/MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:@*,,**/PackageCache/,Packages/</code> will store the path as <code>Packages/com.unity.my.package/Editor/MyScript.cs</code>, when the original path is <code>C:/Project/Library/PackageCache/com.unity.my.package@12345/Editor/</code> <code>MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:C:/MyProject/,</code> will store the path as <code>Assets/Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProject/Assets/Scripts/MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:**Assets/,</code> will store the path as <code>Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProject/Assets/Scripts/MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:C:/*/Assets/,</code> will store the path as <code>Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProject/Assets/Scripts/MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:C:/MyProject??/,</code> will store the path as <code>Assets/Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProject01/Assets/Scripts/MyScript.cs</code><br />
<br />
<code>pathReplacePatterns:**/MyProject[A-Z][0-9]/,</code> will store the path as <code>Assets/Scripts/MyScript.cs</code>, when the original path is <code>C:/MyProjectA1/Assets/Scripts/MyScript.cs</code></td></tr></tbody></table>

## Example

    Unity.exe -projectPath <path-to-project> -batchmode -testPlatform editmode -runTests -testResults
    <path-to-results-xml> -debugCodeOptimization
    -enableCodeCoverage
    -coverageResultsPath <path-to-coverage-results>
    -coverageHistoryPath <path-to-coverage-history>
    -coverageOptions "generateAdditionalMetrics;generateHtmlReport;generateHtmlReportHistory;generateBadgeReport;
    assemblyFilters:+my.assembly.*,+<packages>;
    pathFilters:-**/Tests/**,-**/BuiltInPackages/**"

The example above opens the project at `<path-to-project>`, runs the `EditMode` tests and produces an HTML coverage report and coverage summary badges in `<path-to-coverage-results>`. The report includes the coverage history, Cyclomatic Complexity and Crap Score calculations. The coverage history files are saved in `<path-to-coverage-history>`.

Additionally, the report includes code from any assembly whose name starts with `my.assembly.`, and includes code from all the Packages' assemblies. It excludes files that have `/Tests/` in their path (i.e. all the files under the Tests folder) and also excludes files that have `/BuiltInPackages/` in their path (i.e. all the built-in packages).

**Note:** `-debugCodeOptimization` is passed above to ensure Code optimization is set to Debug mode. See [Using Code Coverage with Code Optimization](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/UsingCodeCoverage.html#using-code-coverage-with-code-optimization).

## Generate combined report from EditMode and PlayMode tests

To get coverage information for both EditMode and PlayMode tests, run the editor three times as shown in the example below:

    Unity.exe -projectPath <path-to-project> -batchmode -testPlatform editmode -runTests -debugCodeOptimization -enableCodeCoverage -coverageResultsPath <path-to-coverage-results>
    -coverageOptions "generateAdditionalMetrics;assemblyFilters:+my.assembly.*;dontClear"

    Unity.exe -projectPath <path-to-project> -batchmode -testPlatform playmode -runTests -debugCodeOptimization -enableCodeCoverage -coverageResultsPath <path-to-coverage-results>
    -coverageOptions "generateAdditionalMetrics;assemblyFilters:+my.assembly.*;dontClear"

    Unity.exe -projectPath <path-to-project> -batchmode -debugCodeOptimization -enableCodeCoverage -coverageResultsPath <path-to-coverage-results>
    -coverageOptions "generateHtmlReport;generateBadgeReport;assemblyFilters:+my.assembly.*" -quit

The first generates the coverage results for the EditMode tests, the second generates the coverage results for the PlayMode tests and the third generates the coverage report and summary badges based on both coverage results.  
  
**Note:** In [Unity Test Framework 2.0](https://docs.unity3d.com/Packages/com.unity.test-framework@2.0) and above the coverage results from both the EditMode and PlayMode test runs are stored in the `Automated` folder. In this example, passing the `dontClear` coverage option ensures that the results from the EditMode test run are not cleared during the PlayMode test run.

## Generate combined report from separate projects

To get a coverage report for your shared code which is used on separate projects, run the tests for each project making sure the `-coverageResultsPath` points to a separate location inside a shared root folder as shown in the example below:

    Unity.exe -projectPath C:/MyProject -batchmode -testPlatform playmode -runTests -debugCodeOptimization -enableCodeCoverage -coverageResultsPath C:/CoverageResults/MyProject
    -coverageOptions "generateAdditionalMetrics;assemblyFilters:+my.assembly.*;pathReplacePatterns:C:/MyProject/,"

    Unity.exe -projectPath C:/MyOtherProject -batchmode -testPlatform playmode -runTests -debugCodeOptimization -enableCodeCoverage -coverageResultsPath C:/CoverageResults/MyOtherProject
    -coverageOptions "generateAdditionalMetrics;assemblyFilters:+my.assembly.*;pathReplacePatterns:C:/MyOtherProject/,"

    Unity.exe -projectPath C:/MyProject -batchmode -debugCodeOptimization -enableCodeCoverage -coverageResultsPath C:/CoverageResults
    -coverageOptions "generateHtmlReport;generateBadgeReport;assemblyFilters:+my.assembly.*;sourcePaths:C:/MyProject" -quit

The first run generates the coverage results for the PlayMode tests for `MyProject` and stores these in `C:/CoverageResults/MyProject`. The second run generates the coverage results for the PlayMode tests for `MyOtherProject` and stores these in `C:/CoverageResults/MyOtherProject`. The third run generates the coverage report and summary badges based on the results found under the common `C:/CoverageResults` folder.

## Using relative paths in path filters

When the `sourcePaths` option is specified, the path filtering rules set by the `pathFilters`, `pathFiltersFromFile` and `filtersFromFile` options can be defined as relative paths.

**Example:**

    Unity.exe -projectPath C:/MyProject -batchmode -testPlatform playmode -runTests -debugCodeOptimization -enableCodeCoverage -coverageResultsPath C:/CoverageResults/MyProject
    -coverageOptions "generateHtmlReport;generateAdditionalMetrics;assemblyFilters:+<all>;pathFiltersFromFile:FilteringRules.txt;sourcePaths:C:/MyProject/Assets"

`FilteringRules.txt`

    +Scripts/Animation/**
    -**/Generated/**
    +C:/MyPackages/com.my.company.mypackage/**

This example contains three rules:

-   `+Scripts/Animation/**` - because the `sourcePaths` option was set and this is a relative path, this rule will include all the scripts in the `C:/MyProject/Assets/Scripts/Animation` folder and its subfolders.
-   `-**/Generated/**` - excludes all the files that have `/Generated/` in their path. This is not a relative path so the `sourcePaths` option has no effect.
-   `+C:/MyPackages/com.my.company.mypackage/**` - includes all the scripts located in the package outside of the project. This is an absolute path so the `sourcePaths` option has no effect.
