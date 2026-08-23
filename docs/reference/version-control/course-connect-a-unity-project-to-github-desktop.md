---
title: "Unity Learn: Connect a Unity project to GitHub Desktop"
page_title: "Connect a Unity project to GitHub Desktop"
source_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/connect-a-unity-project-to-github-desktop"
final_url: "https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/connect-a-unity-project-to-github-desktop"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Connect a Unity project to GitHub Desktop

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Connect a Unity project to GitHub Desktop

Tutorial

Beginner

+0XP

9m

10

\(49\)

Unity Technologies

![Connect a Unity project to GitHub Desktop](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d1890abf-37af-43b5-8e3b-53cad350918e/thumbnail/2_20251210_145954.png)

Summary

In this tutorial, you’ll connect your Unity project to GitHub Desktop, set up version control to track changes, commit progress, and learn how to collaborate with your team.

Resources

-   

    <a href="https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d1890abf-37af-43b5-8e3b-53cad350918e/versions%5B_key==%22ccf4471e9e94%22%5D.materials%5B_key==%22ce652403d022%22%5D.file/Collaborate%20with%20Github_20251210_183846.zip" class="link-primary link-primary bodyS no-underline">Collaborate with Github.zip</a>

    

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this tutorial, you’ll download a sample Unity project, explore its folder structure, and set it up with GitHub version control. By the end, you’ll have a properly configured local repository and an understanding of how to commit, push, and optionally collaborate with others.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Open the sample Unity project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before setting up version control, you'll explore a sample Unity project. This step also familiarizes you with a well-structured project, which is important for efficient collaboration.

**Instructions**

**1. Download and unzip the sample Unity project folder**

-   Download this <a href="https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d1890abf-37af-43b5-8e3b-53cad350918e/versions%5B_key==%22ccf4471e9e94%22%5D.materials%5B_key==%22ce652403d022%22%5D.file/Collaborate%20with%20Github_20251210_183846.zip" class="link-primary text-inherit inline-flex items-center gap-1">sample Unity project folder</a>.
-   Unzip the folder in a convenient location on your computer.

**2. Add the project to the Unity Hub**

-   Open the **Unity Hub**.
-   Select **Add** > **Add project from disk**.
-   Go to the folder you just extracted and select **Open** to add it to the **Unity Hub**.

**Note:** The project folder must be unzipped for **Unity Hub** to add it successfully. The actual Unity project folder is the one containing the Assets/, Packages/, and ProjectSettings/ folders.

**3. Open and explore the project**

-   In the project list, select the project to open it in the **Unity Editor**.
-   Open the **Main Scene** from the **Assets** > **Scenes** folder.
-   Take a moment to explore the scene. You'll see two capsules: one named **Player**, and one named **BossCharacter** — but no functionality is implemented yet.
-   Observe the folder structure in the **Project** window. A clean and logical structure, such as **Art**, **Audio**, **Scripts**, **Prefabs**, **Scenes**, **UI**, and **ThirdParty**, supports collaboration and reduces merge conflicts by making it easier to locate files, understand project organization, and minimize overlapping changes in the same areas.

**4. Close the Unity Editor**

-   Close the **Unity Editor** before moving to the next step.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Move the Unity project into the repository folder

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Git only tracks files that are inside its repository folder. To enable version control for your Unity project, you'll now move all its files and folders into the Git repository folder you created in the previous tutorial. This action will allow GitHub Desktop to detect and track all project asset changes.

**Instructions**

**1. Locate your Git repository and Unity project folders**

-   In GitHub Desktop, select **Repository** > **Show in Explorer** (macOS: **Repository** > **Show in Finder**) to open your Git repository folder.
-   Navigate to your Unity project folder. If you can’t remember where you created it, open the **Unity Hub**, select the **More** () menu next to the project name, then select **Show in Explorer** (Windows) (macOS: **Show in Finder**).

**2. Move Unity project files into the repository folder**

-   Select and cut or copy all the files and folders inside the Unity project folder.
-   Paste your Unity project files into the Git repository folder.

**3. Return to GitHub Desktop**

-   You should now see a list of files under the Changes tab. Since you selected the Unity **.gitignore** template when creating the repository, the number of tracked changes is already manageable; you should see a reasonable count, such as **67 changed files**. This is because Git is already ignoring unnecessary files specific to Unity (like **Library/** and **Temp/**).

**Note:** The next section demonstrates exactly how the **.gitignore** file achieves this cleanup by showing the effect of removing it.

**4. Delete the original Unity project folder**

-   Now that you have your Unity project files safely in the repo folder, you can safely delete the Unity project folder to avoid confusion.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Demonstrate the power of the .gitignore file

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Unity generates many files specific to your local computer (like cache files or temporary data). A **.gitignore file** tells Git to skip these files and keep your repository clean and lightweight, ensuring only essential project files are tracked. Because you selected the Unity template earlier, this file is already active, keeping your repository fast. This step demonstrates what happens when that file is missing.

![A GitHub Desktop window showing 67 changed files selected for commit, with a diff preview on the right.](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d1890abf-37af-43b5-8e3b-53cad350918e/versions%5B_key==%22ccf4471e9e94%22%5D.sections%5B_key==%22d25201e54e56%22%5D.body%5B_key==%22141aaa48bfbd%22%5D.image/GitignoreCleanup_20251210_170947.png)

**Instructions**

**1. Temporarily remove the .gitignore file**

-   Using your file explorer (Finder/Explorer), navigate to the root of your local repository folder.
-   Locate the **hidden .gitignore file**. On macOS, you may need to press **Cmd + Shift + .** (period) to toggle the visibility of hidden files.
-   Drag the **.gitignore** file out of the repository root folder onto your Desktop (or another temporary location).

**2. Observe the resulting file count change**

-   Return to GitHub Desktop.
-   Git immediately begins tracking all the files that were previously ignored. You should now see the number of tracked changes skyrocket, potentially showing more than 32,000 files. This massive number of files is too much to upload and would make managing the project difficult and slow.

**3. Restore the .gitignore file**

-   Move the **.gitignore** file back into the root folder of your repository.

**4. Confirm cleanup in GitHub Desktop**

-   Return to GitHub Desktop. The list of tracked files should immediately reduce back down to the manageable number (e.g., **67 changed files** or something similar).
-   The **.gitignore** file makes files like the **Library/**, **Temp/**, and **.vs/** invisible to Git, preventing them from being committed, pushed, or causing conflicts, keeping your repository clean and focused.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Create your first commit

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A **commit** records a snapshot of your project at a specific point in time. It’s essentially your first official save into Git, marking the initial state of your project under version control. This step saves all the files you’ve moved into your repository and configured with the **.gitignore** file.  

**Instructions**

**1. Go to the Changes tab in GitHub Desktop**

-   In GitHub Desktop, select the **Changes** tab.

**2. Enter a commit summary**

-   In the **Summary** box, enter “Initial commit”. This message clearly indicates that this is the very first save of your project into version control.
-   Add a short description for more context, for example, “Set up project files with .gitignore and basic Unity structure”.

**3. Commit the changes**

-   Select **Commit x files to main**.

**Note:** The main branch is the primary, default branch in your Git repository. It’s typically where the stable and production-ready version of your project resides. Right now, these changes are recorded only in your local repository on the main branch.

**4. Publish your repository**

-   Select **Publish repository** (or **Publish branch**) to upload your files to the online repository on GitHub.com.
-   You can add a **Description** to your repository, and enable **Keep this code private** if you don’t want other users to see your repository. You can change these configurations later.
-   Select **Publish repository.**

**5. View your files online**

-   To see your files online, go to **Repository** > **View on GitHub.**
-   Once on **GitHub.com**, explore your repository:
    -   Browse the **Code** tab to see your Assets/ folder and other project files.
    -   Select individual files or folders to view their contents.
    -   Select the **Commits** tab to see your **Initial commit** listed, which represents the first snapshot of your project.

Your first commit is now created, and your project files are tracked by Git both locally and on <a href="http://github.com" class="link-primary text-inherit inline-flex items-center gap-1">GitHub.com</a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Make and commit a change in your project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that your project is under version control, you'll make a simple change to the project and observe how Git tracks these updates. This demonstrates the core process of saving and synchronizing your work as you develop.  

**Instructions**

**1. Create a new script in Unity**

-   Open the Unity Hub and add the **tutorial-repo** project.
-   In the Unity Editor, go to the **Project** window.
-   Right-click and select **Create** > **Monobehaviour Script**.
-   Name the new script “MyScript”.

**2. Observe changes in GitHub Desktop**

-   Open GitHub Desktop.
-   The **Changes** tab will show that you have a new file added since your last commit.

**3. Commit your changes**

-   In the **Summary** box, enter “Added new script”.
-   Select **Commit to main**.

**4. Push your changes to GitHub**

-   Select **Push origin** to upload your changes to <a href="http://github.com" class="link-primary text-inherit inline-flex items-center gap-1">GitHub.com</a>.

**Note:** **Commit** saves changes to your local repository, which solely lives on your current machine. **Push** sends those changes to GitHub.com so that you or other team members can later access the project's history and files.

Commit often and push when you’ve completed a working task or feature. Commit after completing small, meaningful tasks (for example, implementing a new feature or fixing a bug). Push your commits as soon as they’re tested or reviewed. Avoid waiting until the end of a game jam or project, as this increases the risk of merge conflicts.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

<span class="small">Optional step</span>

## 7. Invite a collaborator and share your repository

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Once your project is pushed to GitHub, you can invite others to work on it. This step explains how to add collaborators to your repository, allowing them to contribute to the project. Even if you don’t plan on inviting someone now, you should follow these steps to understand the process for future collaborations.

**Instructions**

**1. Navigate to collaborators settings**

-   From your repository on <a href="http://github.com" class="link-primary text-inherit inline-flex items-center gap-1">Github.com</a>, select the **Settings** tab in the top menu.
-   In the left menu, select **Collaborators** (or **Manage access**).

**2. Invite a collaborator**

-   Select **Add people**.
-   Enter your teammate’s GitHub username or email.
-   Select their profile from the dropdown and select **Add**.

![A GitHub repository’s Settings page showing the Collaborators section and an option to add people.](https://storage.googleapis.com/learn-platform-bucket-production/tutorial/d1890abf-37af-43b5-8e3b-53cad350918e/versions%5B_key==%22ccf4471e9e94%22%5D.sections%5B_key==%22d8ec3764e2da%22%5D.body%5B_key==%2250b9a8988dc6%22%5D.image/addCollaborator_20251210_173403.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Next steps

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this tutorial, you learned how to put a Unity project in a Github repository, configure a **.gitignore** file, and perform your first commits and pushes. You now have a foundational understanding of how to manage your Unity project with version control.

In the next tutorial, you’ll learn how to configure Git Large File Storage (Git LFS) to efficiently handle large assets often found in Unity projects, ensuring your repository remains lightweight and performant.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
