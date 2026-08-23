---
title: "Project manifest file"
page_title: "Unity - Manual: Project manifest file"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Project manifest file

When Unity loads a project, the Unity Package Manager reads the project manifest so that it can compute a list of which packages to retrieve and load. When a user installs or uninstalls a package through the [Package Manager window](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui.html), the Package Manager stores those changes in the project manifest file. The project manifest file manages the list of packages through the [dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html#dependencies) object.

In addition, the project manifest serves as a configuration file for the Package Manager, which uses the manifest to customize the registry URL and register custom registries.

You can find the project manifest file, called `manifest.json`, in the `Packages` folder under the root folder of your Unity project. Like the [package manifest file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html), the project manifest file uses JSON (JavaScript Object Notation) syntax.

## Properties

All properties are optional. However, if your project manifest file does not contain any values, the Package Manager window doesn’t load, and the Package Manager doesn’t load any packages.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Key</strong></th><th style="text-align: left;"><strong>JSON Type</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><span id="dependencies"></span><strong>dependencies</strong></td><td style="text-align: left;">Object</td><td style="text-align: left;">Collection of packages required for your project. This includes only direct dependencies (indirect dependencies are listed in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html">package manifests</a>). Each entry maps the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html#name">package name</a> to the minimum <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html">version</a> required for the project:<br />
<br />
<code>{</code><br />
  <code>"dependencies": {</code><br />
    <code>"com.my-package": "2.3.1",</code><br />
    <code>"com.my-other-package": "1.0.1-preview.1",</code><br />
      <code>etc.</code><br />
  <code>}</code><br />
<code>}</code><br />
<br />
Specifying a version number indicates that you want the Package Manager to download the package from the package registry (that is, the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#Sources">source</a> of the package is the registry). However, in addition to using <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html#version">versions</a>, you can also specify a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-localpath.html">path to a local folder or tarball file</a>, or a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html">Git URL</a>.<br />
<br />
<strong>Note</strong>: You do not need to specify <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html">embedded</a> packages here because the Package Manager finds them inside your project’s <code>Packages</code> folder and loads them automatically. The Package Manager ignores any entry if there is an embedded package with the same <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html#name">name</a> in its own package manifest.</td></tr><tr class="even"><td style="text-align: left;"><span id="enableLockFile"></span><strong>enableLockFile</strong></td><td style="text-align: left;">Boolean</td><td style="text-align: left;">Enables a lock file to ensure that dependencies are resolved in a deterministic manner. This is set to <code>true</code> by default. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts-auto.html">Using lock files</a>.</td></tr><tr class="odd"><td style="text-align: left;"><span id="resolutionStrategy"></span><strong>resolutionStrategy</strong></td><td style="text-align: left;">String</td><td style="text-align: left;">Upgrades <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html">indirect dependencies</a> based on Semantic Versioning rules. This is set to <code>lowest</code> by default. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html#strategize">Setting a resolution strategy</a> below.</td></tr><tr class="even"><td style="text-align: left;"><span id="scopedRegistries"></span><strong>scopedRegistries</strong></td><td style="text-align: left;">Array of Objects</td><td style="text-align: left;">Specify custom registries in addition to the default registry. This allows you to host your own packages.<br />
<br />
Refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped-use.html#scopes">Scoped Registries</a> for more details.</td></tr><tr class="odd"><td style="text-align: left;"><span id="testables"></span><strong>testables</strong></td><td style="text-align: left;">Array of Strings</td><td style="text-align: left;">Lists the names of packages whose tests you want to load in the Unity <a href="https://docs.unity3d.com/Packages/com.unity.test-framework@latest">Test Framework</a>. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html">Adding tests to a package</a>.<br />
<br />
<strong>Note</strong>: You do not need to specify <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html">embedded</a> packages here because the Unity Test Framework assumes they are testable by default.</td></tr><tr class="even"><td style="text-align: left;"><span id="pinned"></span><strong>pinnedPackages</strong></td><td style="text-align: left;">Array of Strings</td><td style="text-align: left;">Lists the names of packages that you want to lock at the version specified in the <code>dependencies</code> object. Items in this list must exist in the <code>dependencies</code> object, otherwise an error is generated.<br />
<br />
Adding package names to this list makes Package Manager use the exact package version specified in the <code>dependencies</code> object, even if a different package version is more compatible with your version of the Unity Editor.</td></tr></tbody></table>

  

## Example

``` lang-json
{
  "scopedRegistries": [{
    "name": "My internal registry",
    "url": "https://my.internal.registry.com",
    "scopes": [
      "com.company"
    ]
  }],
  "dependencies": {
    "com.unity.package-1": "1.0.0",
    "com.unity.package-2": "2.0.0",
    "com.company.my-package": "3.0.0",
    "com.unity.my-local-package": "file:<path>/my_package_folder",
    "com.unity.my-local-tarball": "file:<path>/my_package_tarball.tgz",
    "com.unity.my-git-package": "https://my.repository/my-package.git#v1.2.3"
  },
  "enableLockFile": true,
  "resolutionStrategy": "highestMinor",
  "testables": [ "com.unity.package-1", "com.unity.package-2" ],
  "pinnedPackages": ["com.unity.package-1"]
}
```

<span id="strategize"></span>

## Setting a resolution strategy

While you can force Unity’s package dependency resolution to use higher versions of indirect dependencies by adding them explicitly to the project manifest, this isn’t a good strategy, for two reasons:

-   It puts more responsibility on the project owner to maintain dependency versions.
-   Over time, you might have dependencies that are not required by the project.

A better approach is to customize how the Package Manager selects indirect dependencies based on Semantic Versioning rules by setting the **resolutionStrategy** property:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Value:</strong></th><th style="text-align: left;"><strong>Description:</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>lowest</strong></td><td style="text-align: left;">Do not upgrade indirect dependencies. Instead, it uses exactly the requested version. This is the default mode.</td></tr><tr class="even"><td style="text-align: left;"><strong>highestPatch</strong></td><td style="text-align: left;">Upgrade to the highest version with the same Major and Minor components. For example, with the requested version 1.2.3, this strategy selects the highest version in the range <code>[1.2.3, 1.3.0)</code> (that is, <code>&gt;= 1.2.3</code> and <code>&lt; 1.3.0</code>).</td></tr><tr class="odd"><td style="text-align: left;"><strong>highestMinor</strong></td><td style="text-align: left;">Upgrade to the highest version with the same Major component. For example, with the requested version 1.2.3, this strategy selects the highest version in the range <code>[1.2.3, 2.0.0)</code> (that is, <code>&gt;= 1.2.3</code> and <code>&lt; 2.0.0</code>).<br />
<br />
<strong>Note</strong>: Version <code>1.0.0</code> marks the first stable, production-ready version. Below that, versions <code>0.X.Y</code> indicate that their API is not yet stable, and successive minor versions might introduce breaking changes. This part of the SemVer specification allows releasing early versions of a package without hampering rapid development. Because of this, when the target version is <code>0.X.Y</code>, <strong>highestMinor</strong> behaves like <strong>highestPatch</strong> in order to ensure choosing a backward-compatible version. For example, with the requested version <code>0.1.3</code>, this strategy selects the highest version in the range <code>[0.1.3,0.2.0)</code>.</td></tr><tr class="even"><td style="text-align: left;"><strong>highest</strong></td><td style="text-align: left;">Upgrade to the highest version. For example, with the requested version 1.2.3, this strategy selects the highest version in the range <code>[1.2.3,)</code> (that is, <code>&gt;= 1.2.3</code> with no upper bound)</td></tr></tbody></table>

**Note**: These ranges never allow a dependency to jump from a stable release to an [experimental](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-exp.html) or [pre-release](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-preview.html) package.

## Additional resources

-   [Package manifest file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html)
