---
title: "Unity Learn: Working with Unity and GitHub"
page_title: "Working with Unity and GitHub"
source_url: "https://learn.unity.com/tutorial/working-with-unity-and-github"
final_url: "https://learn.unity.com/tutorial/working-with-unity-and-github"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Working with Unity and GitHub

![](https://learn.unity.com/_next/static/media/tutorial-coverImage-bg.8fcd34a7.jpeg)

# Working with Unity and GitHub

Tutorial

Beginner

+5XP

15m

24

\(325\)

Unity Technologies

![Working with Unity and GitHub](https://connect-mediagw.unity.com/h1/20201112/learn/images/c18d26f3-3905-4de6-b285-948fcded0790_83.png)

Summary

Skills

In this tutorial, we will demonstrate how to get set up with GitHub. While <a href="https://git-scm.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Git</span></a> is an open-source distributed version control system for tracking changes in files for software development, <a href="https://github.com/" class="link-primary text-inherit"><span style="text-decoration:underline">GitHub</span></a> is a cloud hosting platform that hosts and manages Git functionality.

Languages available:

EnglishEnglish

<span id="react-aria-«R1ahmpmH7»">English</span><span class="pl-2"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Getting Set up with GitHub

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

There are many options for working with Git, ranging from working entirely within the command-line, to using desktop clients such as <a href="https://www.sourcetreeapp.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Sourcetree</span></a> or <a href="https://www.gitkraken.com/" class="link-primary text-inherit"><span style="text-decoration:underline">GitKraken</span></a>. Additionally, there are many cloud-hosting platform options that incorporate Git, including <a href="https://bitbucket.org/product/" class="link-primary text-inherit"><span style="text-decoration:underline">Bitbucket</span></a>, <a href="https://www.digitalocean.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Digital Ocean</span></a>, and <a href="https://visualstudio.microsoft.com/services/visual-studio-codespaces/" class="link-primary text-inherit"><span style="text-decoration:underline">Visual Studio Codespaces</span></a>. Unity developers and teams can also seamlessly incorporate GitHub into their workflows using a Unity Asset.

For this tutorial, we will use the Sourcetree application, the GitHub cloud service, and the <a href="https://assetstore.unity.com/packages/tools/version-control/github-for-unity-118069" class="link-primary text-inherit"><span style="text-decoration:underline">GitHub Unity Asset</span></a>.

**1**. Install <a href="https://git-scm.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Git</span></a> on your computer.

**2**. Register an account with <a href="https://github.com/" class="link-primary text-inherit"><span style="text-decoration:underline">GitHub</span></a>, and login.

**3**. Create a repository by selecting the **Create repository** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/c459f2db-9c57-4a75-93e1-3cd1be452b06_83.png)

**4**. Enter a Repository name, and write a short description. Set the repository settings to either Public or Private. Select the checkbox next to the Add .gitignore option, and then select Unity from the .gitignore template dropdown menu. Optionally, select to add a README file, and to choose a license for your code. Then, select the **Create repository** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/2c7382c4-6161-401b-8495-3cc9a4a0f1ad_76.png)

**5**. Your GitHub repository is now created.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Download Sourcetree and access your repository

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

You will later have to add team members to your repository using their GitHub account name, so that they can upload content. But for now, let’s access the publicly available URL address of your repository. First select the **Code** button, and then copy your repository address by selecting the clipboard icon to the right of the address field. We will paste this URL address in an upcoming step.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/b2bc3644-6d04-4dd3-bea4-e3ace6ffd804_75.png)

**1**. Download and install <a href="https://www.sourcetreeapp.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Sourcetree</span></a>, and then open up the Sourcetree application.

**2**. Connect to your GitHub cloud repository with Sourcetree. First select the **Remote** tab, and then select the **Connect** button. Alternatively, Select from the top menu dropdown: **Sourcetree** \> **Preferences**, and then select the Accounts tab to open up the account options.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/b091aa95-663d-4fbb-a742-b276675db80b_74.png)

**3**. Select the **Add** button to add an account

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/312b7793-ff83-4d4a-a778-e1a392eb91c7_73.png)

**4**. Select GitHub from the Host dropdown menu, and then select the Connect Account button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/b0066413-ebe0-4d97-aa63-e7e852c576e7_72.png)

**5**. The Github authorize page will open in a web browser. Sign into GitHub using your registered username and password, and then select the **Authorize atlassian** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/bba93214-b786-489d-9183-7252ee762447_71.png)

**6**. For our example, ensure that the **HTTPS** Protocol is selected from the dropdown menu. If your project requires the SSH protocol, you will need to additionally link a key. Select the **Save** button to complete your account setup.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/6b0283d1-a315-48be-8729-517efbbd32d9_70.png)

**7**. Close out of the settings window. Select the **Local** Tab, and then select the **New** button. Then, select **Clone from URL** from the dropdown menu.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/9a11db04-2833-4684-8d64-e8d24a3495d0_69.png)

**8**. Paste the GitHub repository URL copied from step 5 in the Source URL field. Establish the Destination Path, and set the Name of your repository’s file folder. In the Advanced Options, select the Checkout branch option to **master**. (Note that you may see the master branch referred to as the Main branch.) Select the **Clone** button to store this repository locally.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/ebedd2ca-6c3c-402d-b817-b065cf75e422_68.png)

The Sourcetree application’s workspace window will open. The newly created local repository folder doesn’t yet contain any files.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/e5f2a87f-6233-40d9-8605-babfaa41b0eb_67.png)

**9**. From the Unity Hub, either create a new Unity project to the local repository folder, or copy an existing project to its location, and then open up your project.

**10**. After your project has been fully loaded, switch back to the Sourcetree application’s workspace view. You will now see the Unity project files listed.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/13e84892-6087-4611-bb28-467a1051017b_66.png)

We have now successfully set up our GitHub repository. We have established our Unity project to exist in our local repository, now visible in the Sourcetree application. Finally, there is a GitHub asset for Unity that can help with version control management within the Unity Editor.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Install the GitHub asset for Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

**1**. Open the <a href="https://assetstore.unity.com/packages/tools/version-control/github-for-unity-118069" class="link-primary text-inherit"><span style="text-decoration:underline">GitHub for Unity Asset</span></a> page in a web browser, select to add the asset, and then select to open the asset in the Unity Editor. With the Unity Editor now open, the Package Manager window will appear, showing the GitHub for Unity asset. Select the **Download** button to download the asset, and then the **Import** button to add it to your Unity project.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/5bf0e64d-cd64-4f7d-8d5c-033d08b33877_65.png)

**2**. The Import Unity Package pop window will open. Again, select the Import button to install the GitHub for Unity asset.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/e7529acb-03a6-4bdd-8695-a91779e21e29_64.png)

**3**. The GitHub Unity Asset is now installed. To open up the GitHub window, select from the top menu dropdown: **Window** \> **GitHub**. Select the button to: **Initialize a git repository for this project**.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/9cf9bbbb-1e42-41ea-b09d-84a5f50868f3_63.png)

**4**. Select the **Sign in** button at the top-right of the GitHub window. Sign in using your GitHub credentials in the Authenticate window, and then again select the **Sign in** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/71cf308b-f4e6-409b-a481-2499947fa466_62.png)

**5**. Confirm your GitHub Unity Asset settings by selecting the Settings tab in the GitHub window.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/b9d901ae-a7fe-48ec-9368-9e415a3c1900_61.png)

You have now successfully set up the GitHub asset for Unity, and have logged in with your GitHub account credentials.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Save and track changes with GitHub and Sourcetree

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We will now explore the procedures for saving and tracking any Unity project changes. Let’s take a look at our Sourcetree workspace.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/d847509b-7599-4e21-87ef-609d05aa2422_60.png)

In this example workspace, note that an entire Unity project has been added inside the local repository, containing a large number of files. There will be some files which are unnecessary or redundant to include in a version control system, such as library items or other files within the project settings. To address this, a *.gitignore* file has been placed in the root repository folder. GitHub helpfully provided this .gitignore template for Unity when we originally created our repository.

Additionally, since GitHub wasn’t originally designed to handle large-sized files such as videos or 3D models, it is a good practice to also keep them out of version control. When large files are included, repository sizes can quickly grow quite large for each participant, and push / pull speeds can become slower.

Fortunately, GitHub now offers capabilities for LFS (Large File Support.) To enable LFS on your machine, refer to the <a href="https://git-lfs.github.com/" class="link-primary text-inherit"><span style="text-decoration:underline">Git LFS page</span></a>, download the package, and install.

Aside from large file sizes, you will likely encounter a need to exclude certain files in your repository. You can accomplish this by editing the .gitignore text file itself, or by using Sourcetree. We will practice both techniques to work with .gitignore, starting with Sourcetree. Let’s first practice using Sourcetree to ignore files, by excluding the Standard Assets folder within our repository.

**1**. Select any Standard Assets file in the Sourcetree workspace by right-clicking on the file, and then selecting **Ignore** from the dropdown menu. Alternately select from the top menu dropdown: **Actions** \> **Ignore**.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/e76dabf5-b390-43f4-8d20-a99aebda0240_59.png)

**2**. You are able to ignore an individual file, all file types with a certain extension, or an entire folder. To exclude everything within the Standard Assets folder, select the option to **Ignore everything beneath Standard Assets**, and then select **OK**.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/9970d0dd-e138-4c40-9cf3-a8ff55f265ed_58.png)

It is a good file-management practice to ensure that unnecessary files and folders have been carefully excluded. Let’s go ahead and further utilize the .gitignore file by editing the text file itself. Because the .gitignore file is a hidden file within your repository folder, you will first need to enable your file browser to show hidden files.

**3.** Navigate to your local repository folder on your file browser, and open up the .gitignore file in a text editor. The GitHub Unity template .gitignore file appears as:

```
# This .gitignore file should be placed at the root of your Unity project directory
#
# Get latest from https://github.com/github/gitignore/blob/master/Unity.gitignore
```

**4.** Scroll down, and you will see that entire folders or file types can be excluded. In the example below, the entire contents within the Library and Temp folders are excluded, as well as any file with a .tmp or .userprefs file extension.

```
/[Ll]ibrary/ 
/[Tt]emp/
*.tmp
*.userprefs
```

We can prepare our custom .gitignore file by specifying which folders to exclude. To see custom examples of .gitignore files shared from GitHub community members, refer to <a href="https://gist.github.com/FullStackForger/20bbf62861394b1a3de0" class="link-primary text-inherit"><span style="text-decoration:underline">this example</span></a>, or <a href="https://gist.github.com/demonixis/6774458" class="link-primary text-inherit"><span style="text-decoration:underline">this example</span></a> as well. Additionally, refer to the official GitHub <a href="https://github.com/github/gitignore/blob/master/Unity.gitignore" class="link-primary text-inherit"><span style="text-decoration:underline">Unity.gitignore page</span></a>.

**5.** Make any custom changes to your .gitignore file, and then save your file.

**6.** To update your existing repository to the new changes that are now in your .gitignore file, run the following git commands in your command line interface. Make sure you enter the command from within your local repository folder location. The following command removes any of the changed files from our local repository cache. Enter this command into the Terminal as:

```
git rm -r --cached .
```

Next, commit the change, by entering:

```
git add .
```

Lastly, commit with the comment, by entering:

```
git commit -m ".gitignore file is now working"
```

You will be able to continue with Unity and Sourcetree, with the repository updated to reflect the .gitignore changes.

We will now proceed to save our project into both our local and hosted repositories, by performing the sequence to *Commit*, and then *Push* our files.

**7**. To add our files to our local repository, first ensure that the files are selected in the Sourcetree workspace. Next, select the **Commit** button at the top-left of the workspace. Type in a comment in the description field, and then again select the **Commit** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/52542714-eb9b-42c7-a4d7-2eed63c71afb_57.png)

**8**. To upload to our GitHub cloud hosted repository, select the **Push** button. Press OK on the popup that appears to complete the Push.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/ba81ecfd-b2a7-4173-b1ad-f7021dc5f615_56.png)

You have now successfully saved your project files to both your local and cloud repositories.

Let’s next add some changes to our Unity Scene.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Save and track changes with GitHub and Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In the example project, recent changes have been made, and a series of pushes have been made as well. With the Scenes folder selected in the Project window, you can see a newly saved Scene named “v14” with a green + icon next to it. Any newly added or changed file will have this marker visible next to it. In the Unity Editor’s GitHub window, you are able to track the sequence of changes in the History tab.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/5c413975-8a5f-458c-8e78-97a4f6b5afa1_55.png)

**1.** In order to continue synchronizing changes to our repository from within the Unity Editor, select the **Push** button at the top of the GitHub window, and then again select **Push** from the popup window.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/fb38c4ef-cd55-443b-ad6d-5a7d7177fc34_54.png)

**2.** Confirm the Push confirmation by selecting the **OK** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/12b3a855-becc-4160-87f2-b3c60e1663ca_53.png)

Let’s now switch to the perspective of another team member’s view. In order to collaborate with other team members, they must also have Git installed. Additionally, they must clone the specific GitHub repository using the same public (or private) URL address. Finally, the teammate’s GitHub user name must be added as a contributor to the owner’s repository. They will receive an email invite to join the repository, and must select the GitHub link to accept the invitation.

Here is the view of our team member’s Unity Editor. Their GitHub asset is successfully installed, and everything is set up and synced.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/7eb57e3a-c954-46ae-b220-8130128952ca_52.png)

**3.** To update our recent changes, select the **Pull** button at the top of the GitHub asset window, and confirm by again selecting the **Pull** button.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/878a8e19-ae7a-4b55-860b-c11380e2330a_51.png)

Our team member’s Unity project folder has successfully updated the recent Scene “v14” file addition.

![](https://connect-mediagw.unity.com/h1/20201112/learn/images/fde5e9b5-31df-427b-a1c9-f66a3985fe5d_50.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Next steps

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that you have successfully set up the GitHub version control system, you and your teammates will have the freedom to work both collaboratively and autonomously with your Unity projects. You will have the flexibility and control over managing complex projects, as well as having the additional tools to collaborate with your team.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
