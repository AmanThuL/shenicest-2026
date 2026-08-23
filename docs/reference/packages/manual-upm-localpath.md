---
title: "Local folder or tarball paths"
page_title: "Unity - Manual: Local folder or tarball paths"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-localpath.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-localpath.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Local folder or tarball paths

You can specify a dependency as any local folder or tarball that contains a package. This feature is helpful for local offline development and testing.

**Note**: If you want to reference a package on the local file system as a Git dependency, use the `file://<url>` format instead. Unity doesn’t support directly referencing a locally accessible Git repository with a file path. For more information on the `file://<url>` format, refer to [Git dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html).

This section describes how to use the project manifest to set up a local dependency. If you want to use the Package Manager window instead, follow the instructions on these pages:

-   [Installing a package from a local folder](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-local.html)
-   [Installing a package from a local tarball file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-tarball.html)

The path reference always begins with the `file:` prefix, and uses forward slashes (`/`) for path separators.

**Note**: On Windows, you can also use backslashes (`\`), but only if you escape each one (for example, `"file:..\\github\\my_package_folder"` or `"file:C:\\Users\\my_username\\github\\my_package_folder"`). These paths aren’t as easy to read as the forward slashes, they’re prone to typing errors, and you can’t use them anywhere but on a Windows machine. For these reasons, using forward slashes is preferable.

You can use either absolute paths, or paths that are relative to the project’s `Packages` folder (that is, the root folder of the project manifest). In other words, a path preceded with two dots (`..`) refers to the root of the project path, so that `../another_folder` is a sibling of the `Packages` folder.

**Tip**: Relative paths with forward-slashes offer better portability across different machines and operating systems when tracking a project and packages in the same repository.

For Windows absolute paths, the drive letter and its colon (usually `C:`) follows the `file:` prefix but is otherwise the same as Linux or macOS paths.

## Example of a relative path

After the `file:` prefix, the path is a standard relative path. In the following example:

-   The project’s `Packages` folder is `C:\Users\my_username\Projects\my_project\Packages`.
-   The `Projects`, `github`, and `Downloads` folders are peer folders.
-   `my_package_c` is an embedded package (a package whose folder was copied into the `Packages` folder, to make it mutable).

``` lang-json

}
```

## Example of an absolute path in Linux or macOS

After the `file:` prefix, the path is a standard Portable Operating System Interface (POSIX) path, starting with a forward slash `/`:

``` lang-json

}
```

## Example of an absolute path in Windows

Notice that the drive letter immediately follows the `file:` prefix:

``` lang-json

}
```
