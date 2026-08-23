---
title: "Best practices for organizing your Unity project"
page_title: "Best practices for organizing your Unity project"
source_url: "https://unity.com/how-to/organizing-your-project"
final_url: "https://unity.com/how-to/organizing-your-project"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Best practices for organizing your Unity project

Position your team for effective game development with these useful tips on setting standards for your Unity projects.

These best practices come from our free e-book, [*Version control and project organization best practices for game developer*s](https://resources.unity.com/games/version-control-project-organization-best-practices-ebook), created to help teams with both technical and non-technical members make smart decisions about how to set up a [version control system](https://unity.com/solutions/version-control-systems) and plan for smooth collaboration.

Folder structure

Folder structure – example 1

Subfolders split up by asset type

Create the same folder structure for all projects

Empty folders

The .meta file

Naming standards

Split up your assets

Presets

Code standards

Code standards continued

ONE-COLUMN AND TWO-COLUMN PROJECT WINDOW VIEWS

## Folder structure

Although there is no single way to organize a Unity project, here are some key recommendations:

-   **Document your naming conventions and folder structure**. A style guide and/or project template makes files easier to locate and organize. Pick what works for your team, and make sure that everyone is on board with it.
-   **Be consistent with your naming conventions**. Don’t deviate from your chosen style guide or template. If you do need to amend your naming rules, parse and rename your affected assets all at once. If ever the changes affect a large number of files, consider automating the update using a script.
-   **Don’t use spaces in file and folder names**. Unity’s command line tools have issues with path names that include spaces. Use CamelCase as an alternative for spaces.
-   **Separate testing or sandbox areas**. Create a separate folder for nonproduction scenes and experimentation. Subfolders with usernames can divide your work area by team member.
-   **Avoid extra folders at the root level**. In general, store your content files within the Assets folder. Don’t create additional folders at the project’s root level unless it’s absolutely necessary.
-   **Keep your internal assets separate from third-party ones**. If you’re using assets from the Asset Store or other plug-ins, odds are that they have their own project structure. Keep your own assets separate.

**Note**: If you find yourself modifying a third-party asset or plug-in for your project, then version control can help you get the latest update for the plug-in. Once the update is imported, you can look through the diff to see where your modifications might have been overwritten, and reimplement them.

While there is no set folder structure, the following two sections show examples of how you might set up your Unity project. These structures are both based on splitting up your project by asset type.

The [Asset Types manual page](https://docs.unity3d.com/Manual/AssetTypes.html?utm_source=demand-gen&utm_medium=PDF&utm_campaign=asset-links-gmg-achieve-quality&utm_content=version-control-and-project-organization-ebook) describes the most common assets in greater detail. You can use the Template or Learn projects for further inspiration when organizing your folder structure. While you’re not limited to these folder names, they can provide you with a good starting point.

## Folder structure – example 1

## Subfolders split up by asset type

If you download one of the Template or Starter projects from the Unity Hub, you’ll notice that the subfolders are split up by asset type. Depending on the chosen template, you should see subfolders that represent several common assets.

Defining a strong project structure from the beginning can help you avoid version control issues later on. If you move assets from one folder to another, many VCS will perceive this as just deleting one file and adding another, rather than the file being moved. This loses the history of the original file.

Plastic SCM can handle file moves within Unity and preserve the history of any file that has moved. However, it’s essential that you move files in-Editor so that the .meta file moves along with the asset file.

## Create the same folder structure for all projects

Once you’ve decided on a folder structure for your projects, use an Editor script to reuse the template and create the same folder structure for all projects moving forward. When it’s placed in an Editor folder, the script below will create a root folder in assets matching the "PROJECT_NAME" variable. Doing this keeps your own work separate from third-party packages.

## Empty folders

Empty folders risk creating issues in version control, so try to only create folders for what you truly need. With Git and Perforce, empty folders are ignored by default. If such project folders are set up and someone attempts to commit them, it won’t actually work until something is placed into the folder.

**Note**: A common workaround is to place a “.keep” file inside of an empty folder. This is enough for the folder to then be committed to the repository.

Plastic SCM can handle empty folders. Directories are treated as entities by Plastic SCM, each with their own version history attached.

This is a point to keep in mind when working in Unity. Unity generates a .meta file for every file in the project, including folders. With Git and Perforce, a user can easily commit the .meta file for an empty folder, but the folder itself won’t end up under version control. When another user gets the latest changes, there will be a .meta file for a folder that doesn’t exist on their machine, and Unity will then delete the .meta file. Plastic SCM avoids this issue altogether by including empty folders under version control.

CHANGES TO A .META FILE WHEN IMPORT SETTINGS WERE ADJUSTED ON A FILE

## The .meta file

Unity generates a .meta file for every other file inside the project, and while it’s typically inadvisable to include auto-generated files in version control, the .meta file is a little bit different. Visible Meta Files mode should be turned on in the Version Control window (unless you’re using the built-in Plastic SCM or Perforce modes).

While the .meta file is auto-generated, it holds a lot of information about the file that it’s associated with. This is common for assets that have import settings, such as textures, meshes, audio clips, etc. When you change the import settings on those files, the changes are written into the .meta file (rather than the asset file). That’s why you commit the .meta files to your repository – so that everyone works with the same file settings.

## Naming standards

Agreeing on standards doesn’t stop at the project folder structure. Setting a specific naming standard for all of your game assets can make things easier for your team when working in one another’s files.

Though there is no definitive naming standard for GameObjects, consider the table above.

## Split up your assets

Single, large Unity scenes do not lend themselves well to collaboration. Divide your levels into several, smaller scenes so that artists and designers can collaborate smoothly on a single level while minimizing the risk of conflicts.  
  
At runtime, your project can load scenes additively using SceneManager with LoadSceneAsync passing the LoadSceneMode.Additive parameter mode.  
  
It’s best practice to break work up into Prefabs whenever possible and leverage the power of Nested Prefabs. If you need to make changes later, you can change the Prefab rather than the scene that it’s in, to avoid conflicts with anyone else working on the scene. Prefab changes are often easier to read when doing a diff under version control.  
  
In the case that you end up with a scene conflict, Unity also has a built-in YAML (a human readable, data-serialization language) tool used for merging scenes and Prefabs. For more information, see [Smart merge](https://docs.unity3d.com/Manual/SmartMerge.html) in the Unity documentation.

## Presets

Presets allow you to customize the default state of just about anything in your Inspector. Creating [Presets](https://docs.unity3d.com/2020.3/Documentation/Manual/Presets.html) lets you copy the settings of selected components or assets, save them as their own assets, then apply those same settings to other items later on.

Use Presets to enforce standards or apply reasonable defaults to new assets. They can help ensure consistent standards across your team, so that commonly overlooked settings don’t impact your project’s performance.

Click the **Preset icon** to the top-right of the component. To save the Preset as an asset, click **Save current to…** then select one of the available Presets to load a set of values.

Here are some other handy ways to use Presets:

-   **Create a GameObject with defaults**: Drag and drop a **Preset asset** into the **Hierarchy** to create a new **GameObject** with a corresponding component that includes Preset values.
-   **Associate a specific type with a Preset**: In the **Preset Manager** (**Project Settings > Preset Manager**), specify one or more Presets per type. Creating a new component will then default to the specified Preset values.
    -   Pro tip: Create multiple Presets per type, and rely on the filter to associate the correct Preset by name.
-   **Save and load Manager settings**: Use Presets for a **Manager window** so that the settings can be reused. For example, if you plan to reapply the same tags and layers or physics settings, Presets can reduce setup time for your next project.

## Code standards

Coding standards similarly keep your team’s work consistent, which makes it easier for developers to swap between different areas of your project. Again, there are no rules set in stone here. You need to decide what’s best for your team – but once you’ve decided, make sure to stick with it.

As an example, namespaces can organize your code more precisely. They allow you to separate modules inside your project and avoid conflicts with third-party assets where class names might end up repeating.

**Note**: When using namespaces in your code, break up your folder structure by namespace for better organization.

A standard header is also recommended. Including a standard header in your code template helps you document the purpose of a class, the date it was created, and even who created it; essentially, all of the information that could easily get lost in the long history of a project, even when using version control.

Unity employs a script template to read from whenever you create a new MonoBehaviour in the project. Every time you create a new script or shader, Unity uses a template stored in %EDITOR_PATH%\\Data\\Resources\\ScriptTemplates:

-   **Windows:** C:\\Program Files\\Unity\\Editor\\Data\\Resources\\ScriptTemplates
-   **Mac:** /Applications/Hub/Editor/\[version\]/Unity/Unity.app/Contents/ Resources/ScriptTemplates

The **default MonoBehaviour template** is this one: **81-C# Script-NewBehaviourScript.cs.txt**

There are also templates for shaders, other behavior scripts, and assembly definitions.

For **project-specific script templates**, create an **Assets/ScriptTemplates folder**, and copy the script templates into this folder to override the defaults.

You can also modify the default script templates directly for all projects, but make sure to back up the originals before making any changes. Each version of Unity has its own template folder, so when you update to a new version, you need to replace the templates again. The code example below shows what the original 81-C# Script-NewBehaviourScript.cs.txt file looks like.

In the example below, there are two keywords that might be helpful:

-   **#SCRIPTNAME#** indicates the filename entered, or the default filename (for example, NewBehaviourScript).
-   **#NOTRIM#** ensures that the brackets contain a line of whitespace.

## Code standards continued

You can use your own keywords and replace them with an Editor script to implement the **OnWillCreateAsset** **method**.

Use the header in the following script example inside your script template. This way, any new script will be created with a header that shows its date, the user who created it, and the project to which it originally belonged. This is useful for reusing the code in future projects.

## Want to learn more?

If you found this helpful, check out another [resource on best practices](https://unity.com/how-to/version-control-systems) for organizing your projects or our [free e-book](https://resources.unity.com/games/version-control-project-organization-best-practices-ebook) on version control.

<a href="https://resources.unity.com/games/version-control-project-organization-best-practices-ebook" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Read the e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a><a href="https://unity.com/how-to/version-control-systems" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border border-transparent bg-transparent text-mango-black data-[hovered]:border-mango-black data-[pressed]:border-mango-gray-300 dark:text-mango-white dark:data-[hovered]:border-mango-white dark:data-[pressed]:border-mango-gray-600 h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Learn more<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
