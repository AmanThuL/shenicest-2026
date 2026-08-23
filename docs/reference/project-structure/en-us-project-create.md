---
title: "Create a new project (Unity Hub)"
page_title: "Create a new project • Unity Hub • Unity Docs"
source_url: "https://docs.unity.com/en-us/hub/project-create"
final_url: "https://docs.unity.com/en-us/hub/project-create"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a new project

Use Unity Hub to set up a new project from templates and manage template options.

<span class="MuiTypography-root MuiTypography-caption mui-1vxjoe2" sentry-element="Typography" sentry-source-file="content-renderer.tsx">Read time 4 minutes</span>

<span class="MuiTypography-root MuiTypography-caption mui-1vxjoe2">Last updated 5 days ago</span>

------------------------------------------------------------------------

To create a project in the Unity Hub, you need an active Unity license associated with your account.

Note

<span class="MuiTypography-root MuiTypography-body1 mui-wdm2sh" sentry-element="Typography" sentry-source-file="admonition.tsx"></span>

Select **Use Unity CLI** checkbox to control a new project from the command line. For more information, refer to <a href="https://docs.unity.com/en-us/unity-cli/use-unity-cli" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Use the Unity command-line interface (CLI)</a>.

![The Projects section of the Hub.](https://docs.unity.com/api/media?file=hub/media/images/hub-projects.png)

## <a href="https://docs.unity.com/en-us/hub/project-create#create-a-project-from-a-template" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Create a project from a template

To create a new project select **Projects**. The New project window appears:

![The New project section of the Hub.](https://docs.unity.com/api/media?file=hub/media/images/hub-new-project.png)

1.  Select **New project**.
2.  Select the **Editor version** you want to use . For information on installing a Unity Editor version, refer to <a href="https://docs.unity.com/en-us/hub/add-editor" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Download and install the Unity Editor</a>.
3.  Choose a project template. Templates are organized into three categories: **Core**, **Sample**, and **Learning**. For more information about each category, refer to <a href="https://docs.unity.com/en-us/hub/project-create#template-categories" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Template categories</a>. To learn more about a template, select it and select **Read more** to display more information, including the platforms that the template supports and the Unity packages it installs.
4.  If a template that you want to use isn't downloaded, select **Download template** and wait for the download to complete.
5.  Enter a **Project name**. The Hub uses this name for the project folder that stores your assets, scenes, and other project files.
6.  Choose a **Location** on your device to store the project. By default, projects are stored in your user home directory. To choose a different location, select the **Location** field and navigate to your preferred folder.
7.  Optionally select **Use the Unity CLI** to control this project from the command line. For more information, refer to <a href="https://docs.unity.com/en-us/unity-cli/use-unity-cli" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Use the Unity command-line interface (CLI)</a>.
8.  You can optionally **Select source control provider** to create a remote repository for a new project. To learn more, refer to <a href="https://docs.unity.com/en-us/hub/project-create#create-a-source-control-repository-for-a-project" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Create a source control repository for a project</a>
9.  Select **Create project**. The Hub creates the project, adds it to your Projects list, and opens it in the Unity Editor.

For more information about the properties in the Projects window, refer to <a href="https://docs.unity.com/en-us/hub/projects-window-reference" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Projects window reference</a>.

Note

<span class="MuiTypography-root MuiTypography-body1 mui-wdm2sh" sentry-element="Typography" sentry-source-file="admonition.tsx"></span>

On Windows, if you encounter an error while creating a project, close the Hub and run it as an administrator.

## <a href="https://docs.unity.com/en-us/hub/project-create#create-a-source-control-repository-for-a-project" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Create a source control repository for a project

When you create a new project, you can also create a new repository to connect the project to through Unity Version Control, GitHub or GitLab. To learn how to set up Unity Version Control in the Hub, refer to <a href="https://docs.unity.com/en-us/unity-version-control/get-started-vcs-hub" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Get started with Unity Version Control via the Unity Hub</a>.

### <a href="https://docs.unity.com/en-us/hub/project-create#create-and-add-to-a-github-repository-in-the-unity-hub" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Create and add to a GitHub repository in the Unity Hub

To set up a GitHub repository for a Unity project:

1.  Select **Generate** to <a href="https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">create a personal access token (PAT)</a>.
2.  Configure the personal access token so that Unity can make changes to the repository:
    -   For fine-grained personal access tokens, add the **Administration** and **Contents** permissions, and set each to **Read and Write**. For more information, refer to <a href="https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Creating a fine-grained personal access token</a>.
    -   For classic personal access tokens, select the **repo** scope. For more information, refer to <a href="https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Creating a personal access token (classic)</a>.

To add a new project to a GitHub repository:

1.  Expand the **Select a source control provider** dropdown and select GitHub.
2.  Enter your **Personal Access Token** and select **Authenticate**.
3.  Enter a name in the **Project name** field.
4.  Optionally, expand **Additional configuration** to set the owner, visibility status, description, and a default branch name for your repository.
5.  Select **Create project**.

The Hub creates a repository at the location you selected, adds the project to your list, and opens it in the Unity Editor.

### <a href="https://docs.unity.com/en-us/hub/project-create#create-a-gitlab-repository-in-the-unity-hub" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Create a GitLab repository in the Unity Hub

To set up a GitLab repository for a Unity project:

1.  Select **Generate** to <a href="https://docs.gitlab.com/user/profile/personal_access_tokens/#create-a-personal-access-token" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Create a Personal Access Token (PAT) in GitLab</a>
2.  Configure the token so Unity can create and push to repositories. Add the scopes
    

        api

    

    and
    

        read_user

    

    .

To add a new project to a GitLab repository:

1.  Expand the **Select a source control provider** dropdown and select GitLab.
2.  Enter your **Personal Access Token** and select **Authenticate**.
3.  Enter a name in the **Project name** field.
4.  Optionally, expand **Additional configuration** to set the User/group, visibility, description, and default branch name for your repository.
5.  Select **Create project**.

The Hub creates a repository in the selected GitLab namespace, adds the project to your list, and opens it in the Unity Editor.

## <a href="https://docs.unity.com/en-us/hub/project-create#template-categories" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Template categories

Project templates provide pre-selected settings based on common best practices for different types of projects. Templates optimize your project settings for specific use cases and platforms.

**Note**: The available templates depend on the Editor version you select. When you choose a different Editor version, the template list updates to show the templates compatible with that version.

### <a href="https://docs.unity.com/en-us/hub/project-create#core-templates" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Core templates

Core templates are general-purpose templates for common development scenarios. They include templates for 2D and 3D application development, virtual reality (VR), augmented reality (AR), mixed reality (MR), and mobile platforms. Core templates configure the appropriate render pipeline and packages for the project type you choose.

### <a href="https://docs.unity.com/en-us/hub/project-create#sample-templates" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Sample templates

Sample templates include pre-built scenes, assets, and configurations that demonstrate certain project setups and workflows.

### <a href="https://docs.unity.com/en-us/hub/project-create#learning-templates" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Learning templates

Learning templates include guided tutorials, sample scenes, and assets designed to help you learn the fundamentals of the Unity Editor. For more learning resources, visit the [Unity Learn](https://learn.unity.com/tutorials) website.

## <a href="https://docs.unity.com/en-us/hub/project-create#update-a-template" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Update a template

If an update is available for a template you've already downloaded, its tile displays an **Upgrade** button. You can download the update or continue using the current version of the template.

Check for template updates when you switch Editor versions.

------------------------------------------------------------------------
