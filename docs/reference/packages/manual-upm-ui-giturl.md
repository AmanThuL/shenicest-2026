---
title: "Install a UPM package from a Git URL"
page_title: "Unity - Manual: Install a UPM package from a Git URL"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-giturl.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-giturl.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install a UPM package from a Git URL

The Package Manager can load a UPM package from a Git repository on a remote server.

**Note**: If the package is in a private repository, you must configure your environment before continuing. Refer to **Prerequisites** for HTTPS and SSH setup.

## Prerequisites

-   Install the [Git client](https://git-scm.com/) (minimum version 2.14.0) on your computer.
-   On Windows, add the Git executable path to the `PATH` system environment variable.
-   If the target repository tracks files with Git LFS, install the [Git LFS client](https://git-lfs.com/) on your computer.
-   If the UPM package is in a private repository:
    -   For HTTPS Git URLs, configure your environment for private repositories. Refer to [Use private repositories with HTTPS Git URLs](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-config-https-git.html).
    -   For SSH Git URLs, configure your SSH keys and access. Refer to [Use passphrase-protected SSH keys with SSH Git URLs](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-config-ssh-git.html).
-   Read the information about using [Git dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html) in your project.

## Procedure

To install a UPM package from a Git URL:

1.  Open the [Package Manager window](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-access.html), if it’s not already open.

2.  Open the **Add** (**+**) menu in the Package Manager’s toolbar.

3.  The options for installing packages appear.

    ![Install package from git URL button](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/upm-ui-giturl.png)

4.  Select **Install package from git URL** from the install menu. A text box and an **Install** button appear.

5.  Enter a valid Git URL in the text box. **Note**: If the Git repository uses Git LFS, the imported package might contain pointer files instead of the actual content. Refer to [Git LFS errors](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html#lfs-errors). For information about how to construct a valid Git URL, refer to [Git URLs and extended syntax](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html#syntax). Examples of valid Git URLs include:
    -   `https://github.example.com/myuser/myrepo.git` (if your package is in the root of the repository).
    -   `https://github.example.com/myuser/myrepo.git?path=/subfolder` (if your package is in a [subfolder](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html#subfolder) within the repository).

6.  Select **Install**.

If Unity was able to install the package successfully, the package now appears in the [package list](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html) with the **git** label. If Unity wasn’t able to install the package, the [Unity Console](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html) displays an error message, such as:

-   [No ‘Git’ executable was found](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html#git-not-found)
-   [Git-lfs: command not found](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html#git-lfs)
-   [Repository not found](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html#bad-url)
-   [Couldn’t read Username: terminal prompts disabled](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html#prompts-disabled)

Click an error message link to get some help for it on the [Package Manager troubleshooting](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-errors.html) page.

**Tip**: If you want to check for updates and update your Git dependency to the latest version from the repository, click **Update**. You can also use the [Install package from git URL](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-giturl.html) menu item to update your Git dependency. For information on Git dependencies, refer to [Locked Git dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html#git-locks).

## Additional resources

-   [Package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html)
-   [Add and remove UPM packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html)
-   [Add and remove asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions-ap.html)
