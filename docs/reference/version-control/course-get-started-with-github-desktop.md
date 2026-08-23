---
title: "Unity Learn: Get started with GitHub Desktop"
page_title: "Get started with GitHub Desktop"
source_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/get-started-with-github-desktop"
final_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/get-started-with-github-desktop"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with GitHub Desktop

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Get started with GitHub Desktop

Tutorial

Beginner

+0XP

5m

11

\(87\)

Unity Technologies

![Get started with GitHub Desktop](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d6452fd4-987b-435c-9e8a-f7d533f7bcb7/thumbnail/1_20251210_144104.png)

Summary

In this tutorial, you’ll learn how to set up GitHub Desktop to enable version control for Unity project collaboration.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before you can collaborate on Unity projects with GitHub, you need to install and set up **GitHub Desktop** — a free, beginner-friendly application that handles version control tasks without requiring command-line knowledge.

With GitHub Desktop, you’ll be able to do the following:

-   Track changes to your project files over time.
-   Collaborate with others by sharing and synchronizing your work.
-   Manage different versions of your project, such as features or bug fixes, in isolation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Install GitHub Desktop

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this step, you’ll download and install GitHub Desktop on your computer.

**Instructions**

**1. Go to the GitHub Desktop website and download the installer**

-   Navigate to <a href="https://desktop.github.com/" class="link-primary text-inherit inline-flex items-center gap-1">https://desktop.github.com</a> in your web browser.
-   Select **Download now**, then **Download for Windows** or **Download for macOS**, depending on your operating system.
-   Wait for the download to complete.

![Download page for GitHub Desktop](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d6452fd4-987b-435c-9e8a-f7d533f7bcb7/versions%5B_key==%229a71dc4232ed%22%5D.sections%5B_key==%22e3f76c7cc047%22%5D.body%5B_key==%2275bd323eeebd%22%5D.image/GithubDesktopDownload_20251210_144814.png)

**2. Run the installer**

-   Once the download is complete, run the installer file (the downloaded **.exe** or **.dmg** file).
-   Follow the on-screen instructions to complete the installation process.

You’ve successfully downloaded and installed the GitHub Desktop application, preparing your system for version control.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Sign in to GitHub

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Connecting your GitHub account to GitHub Desktop is a crucial step that allows you to perform essential version control actions. This ensures your work is synchronized with the online platform and your collaborators.

**Instructions**

**1. Open GitHub Desktop**

-   If GitHub Desktop isn’t already open, open it now from the **Start Menu** (Windows) or **Applications** folder (macOS).

**2. Sign in and authorize your account**

-   Select **File** > **Options** > **Sign in to GitHub.com**.
-   Select **Continue with browser** to complete the authorization there. If you don’t have a GitHub account, you can create one by following <a href="https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github" class="link-primary text-inherit inline-flex items-center gap-1">these steps</a>.
-   Authorize GitHub Desktop to access your account if prompted.

Your GitHub account is now successfully connected to GitHub Desktop, enabling you to manage your repositories and collaborate with your team.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Create a new repository

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A **repository**, often shortened to "repo", is the central place where Git tracks all changes to your project files over time. Git is a version-control system that tracks changes to files, allowing you to manage, compare, and revert your work over time without losing anything. It stores every version of your code, assets, and documentation, allowing you to revert to previous states, compare changes, and collaborate efficiently. You’ll now create your first local repository using GitHub Desktop.

**Instructions**

**1. Start a new repository**

-   Go to **File** > **New Repository**.

**2. Name your repository**

-   In the **Name** box, enter a name, such as “tutorial-repo”.

**Note:** GitHub Desktop automatically replaces spaces with dashes (-) in repository names. When working with repositories, it’s good practice to use dashes instead of spaces.

**3. Configure .gitignore**

-   Open the **Git ignore** dropdown and select **Unity**.

**Note:** A **.gitignore** file tells Git which files it should explicitly ignore and not track. You would typically select **Unity** here for a Unity project. However, for the purposes of learning, you’ll manually add the **.gitignore** file later to help you understand how it actually works.

**4. Choose a license (optional)**

-   Open the **License** dropdown and select a license (for example, **MIT** or **None**).

**Note:** Selecting a license now isn’t critical, and you’ll retain all rights to your project regardless of your choice. You can always change this later. For more information, GitHub has <a href="https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository#choosing-the-right-license" class="link-primary text-inherit inline-flex items-center gap-1">documentation on the different license options</a> or you can use <a href="https://choosealicense.com/" class="link-primary text-inherit inline-flex items-center gap-1">this helpful guide</a> to select the right option.

**5. Create the repository**

-   Select **Create Repository**.

**6. Open the local repository folder**

-   Select **Show in Explorer** (Windows) or **Show in Finder** (macOS) to open the newly created local repository folder.

**Note:** At the moment, this folder is empty. In the next tutorial, you’ll add a Unity project to this folder.  

![Screenshot of the new folder for the repo with only the hidden files showing](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d6452fd4-987b-435c-9e8a-f7d533f7bcb7/versions%5B_key==%229a71dc4232ed%22%5D.sections%5B_key==%22029cfe735b59%22%5D.body%5B_key==%22d0084dc890c7%22%5D.image/1.4%20-%20newTutorialRepoFolder_20251210_145651.png)

You’ve now initialized a Git repository on your local machine, configured with a name and optional license. This repository is ready to track changes for your upcoming Unity project.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Next steps

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In the next tutorial, you'll download a sample Unity project and move it into this repository, setting up your first project for version control.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
