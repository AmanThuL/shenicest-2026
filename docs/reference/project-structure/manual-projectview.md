---
title: "Project window reference"
page_title: "Unity - Manual: Project window reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Project window reference

The Project window displays all the files related to your Project and is the main way you can navigate and find assets and other project files in your application. When you start a new project, by default this window is open. However, if you can’t find it, or it’s closed, you can open it from the main menu \> **Window** \> **General** \> **Project** or press Ctrl+5 (macOS: Cmd+5).

![The Project window in the Tall layout](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/project-window-context.png)

You can move the Project window by clicking dragging the top of the window. You can either dock it into place in the Editor, or drag it out of the Editor window to use it as a free-floating window. You can also change the layout of the window itself. To do this, select the **More** menu (⋮) in the top right of the window and choose from either **One Column Layout** or **Two Column Layout**. The **Two Column Layout** has an extra pane which shows a visual preview of each file.

![The Project window in the Two Column Layout](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/project-window-wide-layout.png)

The left panel of the browser shows the folder structure of the Project as a hierarchical list. When you select a folder from the list, Unity shows its contents in the pane to the right. You can click the small triangle to expand or collapse the folder, displaying any nested folders it contains. Hold down **Alt** while you click to expand or collapse any nested folders recursively.

Individual Assets are shown in the right hand panel as icons that indicate their type (for example, script, material, sub-folder). To resize the icons, use the slider at the bottom of the panel; they will be replaced by a hierarchical list view if the slider is moved to the extreme left. The space to the left of the slider shows the currently selected item, including a full path to the item if a search is being performed.

Above the Project structure list is a **Favorites** section where you can keep frequently-used items for easy access. You can drag items from the Project structure list to the Favorites and also save search queries there.

## Project window toolbar

Along the top edge of the window is the browser’s toolbar.

![The Project window toolbar](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/project-window-toolbar.png)

| **Property**              | **Description**                                                                                                                                                                                                                                                  |
|:--------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Create menu**           | Displays a list of Assets and other sub-folders you can add to the folder currently selected.                                                                                                                                                                    |
| **Search bar**            | Use the search bar to search for a file within your Project. You can choose to search within the entire Project (**All**), in the top level folders of your Project (listed individually), in the folder you currently have selected, or within the Asset Store. |
| **Open in Search**        | Opens the [Unity Search](https://docs.unity3d.com/6000.3/Documentation/Manual/search-overview.html) tool to refine your search.                                                                                                                                  |
| **Search by Type**        | Select this property to confine your search to a specific type, for example Mesh, Prefab, Scene.                                                                                                                                                                 |
| **Search by Label**       | Select this property to choose a tag to search within.                                                                                                                                                                                                           |
| **Save Search**           | Saves your search under **Favorites** in the left panel.                                                                                                                                                                                                         |
| **Hidden packages count** | Select this property to toggle the visibility of the packages in the Project window.                                                                                                                                                                             |

## Search filters

Search filters work by adding an extra term in the search text. A term beginning with `t:` filters by the specified asset type, while `l:` filters by label. You can type these terms directly into the search box rather than use the menu if you know what you are looking for. You can search for more than one type or label at once. Adding multiple types expands the search to include all specified types (that is, types are ORed together). Adding multiple labels also expands the search to include all specified types (that is, labels are ORed together). If you search for a type and a label, the search returns assets that match both the type and the label (that is, the labels and types are ANDed together).

## Shortcuts

The following keyboard shortcuts are available when the browser view has focus. Note that some of them only work when the view is using the two-column layout (you can switch between the one- and two-column layouts using the panel menu in the very top right corner).

| **Shortcut**          | **Function**                                                                                                                  |
|:----------------------|:------------------------------------------------------------------------------------------------------------------------------|
| **F**                 | Frame selected (ie, show the selected asset in its containing folder)                                                         |
| **Tab**               | Shift focus between first column and second column (Two columns)                                                              |
| **Ctrl/Cmd + F**      | Focus search field                                                                                                            |
| **Ctrl/Cmd + A**      | Select all visible items in list                                                                                              |
| **Ctrl/Cmd + D**      | Duplicate selected assets                                                                                                     |
| **Delete**            | Delete with dialog (Win)                                                                                                      |
| **Delete + Shift**    | Delete without dialog (Win)                                                                                                   |
| **Delete + Cmd**      | Delete without dialog (OSX)                                                                                                   |
| **Enter**             | Begin rename selected (OSX)                                                                                                   |
| **Cmd + down arrow**  | Open selected assets (OSX)                                                                                                    |
| **Cmd + up arrow**    | Jump to parent folder (OSX, Two columns)                                                                                      |
| **F2**                | Begin rename selected (Win)                                                                                                   |
| **Enter**             | Open selected assets (Win)                                                                                                    |
| **Backspace**         | Jump to parent folder (Win, Two columns)                                                                                      |
| **Right arrow**       | Expand selected item (tree views and search results). If the item is already expanded, this will select its first child item. |
| **Left arrow**        | Collapse selected item (tree views and search results). If the item is already collapsed, this will select its parent item.   |
| **Alt + right arrow** | Expand item when showing assets as previews                                                                                   |
| **Alt + left arrow**  | Collapse item when showing assets as previews                                                                                 |
