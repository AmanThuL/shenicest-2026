---
title: "Odin Inspector 4.0.2.3: editor API (Sirenix.OdinInspector.Editor) — selected types"
source_files: ["Assets/Plugins/Sirenix/Assemblies/Sirenix.OdinInspector.Editor.xml"]
odin_version: "4.0.2.3"
publisher: "Sirenix (Odin Inspector XML documentation shipped with the DLLs)"
generated: "2026-08-24"
generator: "docs/reference/_tools/build_odin_reference.py"
topic: "third-party/odin-inspector"
---

> Generated file — do not edit by hand. Re-run the generator after an Odin upgrade.


# Odin Inspector 4.0.2.3 — selected editor API

Types from `Sirenix.OdinInspector.Editor.dll` that project editor tooling may use (only from the `SheNicest.Editor` assembly, per guideline 12). This is a curated subset; the full list is in the XML file named in the front matter.

### `OdinEditorWindow`

*Full name:* `Sirenix.OdinInspector.Editor.OdinEditorWindow`

Base class for creating editor windows using Odin.

**Examples**

```csharp
public class SomeWindow : OdinEditorWindow
{
    [MenuItem("My Game/Some Window")]
    private static void OpenWindow()
    {
        GetWindow<SomeWindow>().Show();
    }

    [Button(ButtonSizes.Large)]
    public void SomeButton() { }

    [TableList]
    public SomeType[] SomeTableData;
}
```

```csharp
public class DrawSomeSingletonInAnEditorWindow : OdinEditorWindow
{
    [MenuItem("My Game/Some Window")]
    private static void OpenWindow()
    {
        GetWindow<DrawSomeSingletonInAnEditorWindow>().Show();
    }

    protected override object GetTarget()
    {
        return MySingleton.Instance;
    }
}
```

```csharp
private void InspectObjectInWindow()
{
    OdinEditorWindow.InspectObject(someObject);
}

private void InspectObjectInDropDownWithAutoHeight()
{
    var btnRect = GUIHelper.GetCurrentLayoutRect();
    OdinEditorWindow.InspectObjectInDropDown(someObject, btnRect, btnRect.width);
}

private void InspectObjectInDropDown()
{
    var btnRect = GUIHelper.GetCurrentLayoutRect();
    OdinEditorWindow.InspectObjectInDropDown(someObject, btnRect, new Vector2(btnRect.width, 100));
}

private void InspectObjectInACenteredWindow()
{
    var window = OdinEditorWindow.InspectObject(someObject);
    window.position = GUIHelper.GetEditorWindowRect().AlignCenter(270, 200);
}

private void OtherStuffYouCanDo()
{
    var window = OdinEditorWindow.InspectObject(this.someObject);

    window.position = GUIHelper.GetEditorWindowRect().AlignCenter(270, 200);
    window.titleContent = new GUIContent("Custom title", EditorIcons.RulerRect.Active);
    window.OnClose += () => Debug.Log("Window Closed");
    window.OnBeginGUI += () => GUILayout.Label("-----------");
    window.OnEndGUI += () => GUILayout.Label("-----------");
}
```

**Fields / properties**

- `DefaultLabelWidth` — Gets the label width to be used. Values between 0 and 1 are treated as percentages, and values above as pixels.
- `WindowPadding` — Gets or sets the window padding. x = left, y = right, z = top, w = bottom.
- `UseScrollView` — Gets a value indicating whether the window should draw a scroll view.
- `DrawUnityEditorPreview` — Gets a value indicating whether the window should draw a Unity editor preview, if possible.
- `DefaultEditorPreviewHeight` — Gets the default preview height for Unity editors.
- `CurrentDrawingTargets` — At the start of each OnGUI event when in the Layout event, the GetTargets() method is called and cached into a list which you can access from here.
- `PropertyTree` — The Odin property tree drawn.

**Methods**

- `GetTarget()` — Gets the target which which the window is supposed to draw. By default it simply returns the editor window instance itself. By default, this method is called by `GetTargets`().
- `GetTargets()` — Gets the targets to be drawn by the editor window. By default this simply yield returns the `GetTarget` method.
- `InspectObjectInDropDown(object, Rect, float)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus. This particular overload uses a few frames to calculate the height of the content before showing the window with a height that matches its content.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `EnableAutomaticHeightAdjustment(int, bool)` — Measures the GUILayout content height and adjusts the window height accordingly. Note that this feature becomes pointless if any layout group expands vertically.
- `InspectObjectInDropDown(object, Rect, Vector2)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObjectInDropDown(object, Vector2)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObjectInDropDown(object, float)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObjectInDropDown(object, Vector2, float)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObjectInDropDown(object, float, float)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObjectInDropDown(object)` — Pops up an editor window for the given object in a drop-down window which closes when it loses its focus.

Protip: You can subscribe to OnClose if you want to know when that occurs.
- `InspectObject(object)` — Pops up an editor window for the given object.
- `InspectObject(OdinEditorWindow, object)` — Inspects the object using an existing OdinEditorWindow.
- `CreateOdinEditorWindowInstanceForObject(object)` — Creates an editor window instance for the specified object, without opening the window.
- `CreateOdinEditorWindowInstanceForObject(object, bool)` — Creates an editor window instance for the specified object, without opening the window.
- `OnGUI()` — Draws the Odin Editor Window.
- `DrawEditors()` — Calls DrawEditor(index) for each of the currently drawing targets.
- `Initialize()` — Initialize get called by OnEnable and by OnGUI after assembly reloads which often happens when you recompile or enter and exit play mode.
- `OnEnable()` — Called when the window is enabled. Remember to call base.OnEnable();
- `DrawEditor(int)` — Draws the editor for the this.CurrentDrawingTargets[index].
- `DrawEditorPreview(int, float)` — Uses the `Rect)` method to draw a preview for the this.CurrentDrawingTargets[index].
- `OnDestroy()` — Called when the window is destroyed. Remember to call base.OnDestroy();
- `OnEndDrawEditors()` — Called before starting to draw all editors for the `CurrentDrawingTargets`.
- `OnBeginDrawEditors()` — Called after all editors for the `CurrentDrawingTargets` has been drawn.
- `OnAfterDeserialize()` — See ISerializationCallbackReceiver.OnBeforeSerialize for documentation on how to use this method.
- `OnBeforeSerialize()` — Implement this method to receive a callback after unity serialized your object.

### `OdinMenuEditorWindow`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuEditorWindow`

Draws an editor window with a menu tree.

**Examples**

```csharp
public class OdinMenuEditorWindowExample : OdinMenuEditorWindow
{
    [SerializeField, HideLabel]
    private SomeData someData = new SomeData();

    protected override OdinMenuTree BuildMenuTree()
    {
        OdinMenuTree tree = new OdinMenuTree(supportsMultiSelect: true)
        {
            { "Home",                           this,                           EditorIcons.House       }, // draws the someDataField in this case.
            { "Odin Settings",                  null,                           SdfIconType.GearFill    },
            { "Odin Settings/Color Palettes",   ColorPaletteManager.Instance,   EditorIcons.EyeDropper  },
            { "Odin Settings/AOT Generation",   AOTGenerationConfig.Instance,   EditorIcons.SmartPhone  },
            { "Camera current",                 Camera.current                                          },
            { "Some Class",                     this.someData                                           }
        };

        tree.AddAllAssetsAtPath("More Odin Settings", SirenixAssetPaths.OdinEditorConfigsPath, typeof(ScriptableObject), true)
            .AddThumbnailIcons();

        tree.AddAssetAtPath("Odin Getting Started", SirenixAssetPaths.SirenixPluginPath + "Getting Started With Odin.asset");

        var customMenuItem = new OdinMenuItem(tree, "Menu Style", tree.DefaultMenuStyle);
        tree.MenuItems.Insert(2, customMenuItem);

        tree.Add("Menu/Items/Are/Created/As/Needed", new GUIContent());
        tree.Add("Menu/Items/Are/Created", new GUIContent("And can be overridden"));

        // As you can see, Odin provides a few ways to quickly add editors / objects to your menu tree.
        // The API also gives you full control over the selection, etc..
        // Make sure to check out the API Documentation for OdinMenuEditorWindow, OdinMenuTree and OdinMenuItem for more information on what you can do!

        return tree;
    }
}
```

**Fields / properties**

- `MenuWidth` — Gets or sets the width of the menu.
- `ResizableMenuWidth` — Gets a value indicating whether the menu is resizable.
- `MenuTree` — Gets the menu tree.
- `DrawMenuSearchBar` — Gets or sets a value indicating whether to draw the menu search bar.
- `CustomSearchFunction` — Gets or sets the custom search function.

**Methods**

- `OnDestroy()` — Called when the window is destroyed. Remember to call base.OnDestroy();
- `BuildMenuTree()` — Builds the menu tree.
- `ForceMenuTreeRebuild()` — Forces the menu tree rebuild.
- `TrySelectMenuItemWithObject(object)` — Tries to select the menu item with the specified object.
- `GetTargets()` — Draws the menu tree selection.
- `OnImGUI()` — Draws the Odin Editor Window.
- `DrawMenu()` — The method that draws the menu.

### `OdinMenuTree`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuTree`

OdinMenuTree provides a tree of `OdinMenuItem`s, and helps with selection, inserting menu items into the tree, and can handle keyboard navigation for you.

**Examples**

```csharp
OdinMenuTree tree = new OdinMenuTree(supportsMultiSelect: true)
{
    { "Home",                           this,                           EditorIcons.House       },
    { "Odin Settings",                  null,                           SdfIconType.GearFill    },
    { "Odin Settings/Color Palettes",   ColorPaletteManager.Instance,   EditorIcons.EyeDropper  },
    { "Odin Settings/AOT Generation",   AOTGenerationConfig.Instance,   EditorIcons.SmartPhone  },
    { "Camera current",                 Camera.current                                          },
    { "Some Class",                     this.someData                                           }
};

tree.AddAllAssetsAtPath("Some Menu Item", "Some Asset Path", typeof(ScriptableObject), true)
    .AddThumbnailIcons();

tree.AddAssetAtPath("Some Second Menu Item", "SomeAssetPath/SomeAssetFile.asset");

var customMenuItem = new OdinMenuItem(tree, "Menu Style", tree.DefaultMenuStyle);
tree.MenuItems.Insert(2, customMenuItem);

tree.Add("Menu/Items/Are/Created/As/Needed", new GUIContent());
tree.Add("Menu/Items/Are/Created", new GUIContent("And can be overridden"));
```

OdinMenuTrees are typically used with `OdinMenuEditorWindow`s but is made to work perfectly fine on its own for other use cases. OdinMenuItems can be inherited and and customized to fit your needs.

```csharp
// Draw stuff
someTree.DrawMenuTree();
// Draw stuff
someTree.HandleKeybaordMenuNavigation();
```

**Constructors**

- `OdinMenuTree()`
- `OdinMenuTree(bool)`
  - `supportsMultiSelect` — if set to `true` [supports multi select].
- `OdinMenuTree(bool, OdinMenuStyle)`
  - `supportsMultiSelect` — if set to `true` [supports multi select].
  - `defaultMenuStyle` — The default menu item style.
- `OdinMenuTree(bool, OdinMenuTreeDrawingConfig)`

**Fields / properties**

- `ActiveMenuTree` — Gets the currently active menu tree.
- `Selection` — Gets the selection.
- `MenuItems` — Gets the root menu items.
- `RootMenuItem` — Gets the root menu item.
- `DrawInSearchMode` — If true, all indent levels will be ignored, and all menu items with IsVisible == true will be drawn.
- `DefaultMenuStyle` — Gets or sets the default menu item style from Config.DefaultStyle.
- `Config` — Gets or sets the default drawing configuration.

**Methods**

- `Add(string, object)` — Adds a menu item with the specified object instance at the the specified path.
- `Add(string, object, Texture)` — Adds a menu item with the specified object instance and icon at the the specified path.
- `Add(string, object, SdfIconType)` — Adds a menu item with the specified object instance and icon at the the specified path.
- `Add(string, object, Sprite)` — Adds a menu item with the specified object instance and icon at the the specified path.
- `Add(string, object, EditorIcon)` — Adds a menu item with the specified object instance and icon at the the specified path.
- `AddRange``1(IEnumerable{``0}, Func{``0, String})` — Adds a collection of objects to the menu tree and returns all menu items created in random order.
- `AddRange``1(IEnumerable{``0}, Func{``0, String}, Func{``0, Texture})` — Adds a collection of objects to the menu tree and returns all menu items created in random order.
- `FocusSearchField()` — Sets the focus to the `searchField`.
- `ScrollToMenuItem(OdinMenuItem, bool)` — Scrolls to the specified menu item.
- `EnumerateTree(bool)` — Enumerates the tree with a DFS.
- `EnumerateTree(OdinMenuItem, Boolean}, bool)` — Enumerates the tree with a DFS.
- `EnumerateTree(OdinMenuItem})` — Enumerates the tree with a DFS.
- `DrawMenuTree()` — Draws the menu tree recursively.
- `MarkDirty()` — Marks the dirty. This will cause a tree.UpdateTree() in the beginning of the next Layout frame.
- `MarkLayoutChanged()` — Indicates that the layout has changed and needs to be recomputed. This is used when `EXPERIMENTAL_INTERNAL_SparseFixedLayouting` is enabled.
- `DrawSearchToolbar(GUIStyle)` — Draws the search toolbar.
- `UpdateMenuTree()` — Updates the menu tree. This method is usually called automatically when needed.
- `HandleKeybaordMenuNavigation()` — Handles the keyboard menu navigation. Call this at the end of your GUI scope, to prevent the menu tree from stealing input events from other text fields.
- `HandleKeyboardMenuNavigation()` — Handles the keyboard menu navigation. Call this at the end of your GUI scope, to prevent the menu tree from stealing input events from other text fields.

### `OdinMenuItem`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuItem`

A menu item that represents one or more objects.

**Constructors**

- `OdinMenuItem(OdinMenuTree, string, object)`
  - `tree` — The Odin menu tree instance the menu item belongs to.
  - `name` — The name of the menu item.
  - `value` — The instance the value item represents.

**Fields / properties**

- `DefaultToggledState` — The default toggled state
- `OnDrawItem` — Occurs right after the menu item is done drawing, and right before mouse input is handles so you can take control of that.
- `OnRightClick` — Occurs when the user has right-clicked the menu item.
- `ChildMenuItems` — Gets the child menu items.
- `FlatTreeIndex` — Gets the index location of the menu item.
- `IsVisible` — Gets or sets a value indicating whether the menu item is visible. Not that setting this to false will not hide its children as well. For that see use Toggled.
- `Icon` — Gets or sets the icon that is used when the menu item is not selected.
- `IconSelected` — Gets or sets the icon that is used when the menu item is selected.
- `IsSelected` — Gets a value indicating whether this instance is selected.
- `IsSelectable` — Determines whether this instance is selectable.
- `IsEnabled` — Determines whether this instance is enabled.
- `MenuTree` — Gets the menu tree instance.
- `Name` — Gets or sets the raw menu item name.
- `SearchString` — Gets or sets the search string used when searching for menu items.
- `NextVisualMenuItem` — Gets the next visual menu item.
- `NextSelectableMenuItem` — Gets the next selectable visual menu item.
- `Parent` — Gets the parent menu item.
- `PrevVisualMenuItem` — Gets the previous visual menu item.
- `PrevSelectableMenuItem` — Gets the previous selectable visual menu item.
- `Rect` — Gets the drawn rect.
- `LabelRect` — Gets the drawn label rect.
- `Style` — Gets or sets the style. If null is specified, then the menu trees DefaultMenuStyle is used.
- `ObjectInstance` — Gets the first object of the `ObjectInstances`
- `ObjectInstances` — Gets the object instances the menu item represents
- `Value` — Gets or sets the value the menu item represents.
- `SmartName` — Gets a nice menu item name. If the raw name value is null or a dollar sign, then the name is retrieved from the object itself via ToString().
- `Toggled` — Gets or sets a value indicating whether this `OdinMenuItem` is toggled / expanded. This value tries it best to be persistent.
- `IconGetter` — Gets or sets the icon getter.

**Methods**

- `Deselect()` — Deselects this instance.
- `Select(bool)` — Selects the specified add to selection.
- `GetChildMenuItemsRecursive(bool)` — Gets the child menu items recursive in a DFS.
- `GetParentMenuItemsRecursive(bool, bool)` — Gets the child menu items recursive in a DFS.
- `GetFullPath()` — Gets the full menu item path.
- `SetObjectInstance(object)` — Sets the object instance
- `SetObjectInstances(IList)` — Sets the object instances
- `DrawMenuItems(int)` — Draws this menu item followed by all of its child menu items
- `DrawMenuItem(int)` — Draws the menu item with the specified indent level.
- `OnDrawMenuItem(Rect, Rect)` — Override this to add custom GUI to the menu items. This is called right after the menu item is done drawing, and right before mouse input is handles so you can take control of that.
- `HandleMouseEvents(Rect, Rect)` — Handles the mouse events.

### `OdinMenuStyle`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuStyle`

The style settings used by `OdinMenuItem`.

A nice trick to style your menu is to add the tree.DefaultMenuStyle to the tree itself, and style it live. Once you are happy, you can hit the Copy CSharp Snippet button, remove the style from the menu tree, and paste the style directly into your code.

**Fields / properties**

- `DefaultLabelStyle` — Gets or sets the default selected style.
- `SelectedLabelStyle` — Gets or sets the selected label style.
- `Height` — The height of the menu item.
- `Offset` — The global offset of the menu item content
- `LabelVerticalOffset` — The vertical offset of the menu item label
- `IndentAmount` — The number of pixels to indent per level indent level.
- `IconSize` — The size of the icon.
- `IconOffset` — The size of the icon.
- `NotSelectedIconAlpha` — The transparency of icons when the menu item is not selected.
- `IconPadding` — The padding between the icon and other content.
- `DrawFoldoutTriangle` — Whether to draw the a foldout triangle for menu items with children.
- `TriangleSize` — The size of the foldout triangle icon.
- `TrianglePadding` — The padding between the foldout triangle icon and other content.
- `AlignTriangleLeft` — Whether or not to align the triangle left or right of the content. If right, then the icon is pushed all the way to the right at a fixed position ignoring the indent level.
- `Borders` — Whether to draw borders between menu items.
- `BorderPadding` — The horizontal border padding.
- `BorderAlpha` — The border alpha.
- `SelectedColorDarkSkin` — The background color for when a menu item is selected.
- `SelectedInactiveColorDarkSkin` — The background color for when a menu item is selected.
- `SelectedColorLightSkin` — The background color for when a menu item is selected.
- `SelectedInactiveColorLightSkin` — The background color for when a menu item is selected.
- `SelectedColor` — The background color for when a menu item is selected.
- `SelectedInactiveColor` — The background color for when a menu item is selected.
- `TreeViewStyle` — Creates and returns an instance of a menu style that makes it look like Unity's project window.

**Methods**

- `SetHeight(int)` — Sets the height of the menu item.
- `SetOffset(float)` — Sets the global offset of the menu item content
- `SetIndentAmount(float)` — Sets the number of pixels to indent per level indent level.
- `SetIconSize(float)` — Sets the size of the icon.
- `SetIconOffset(float)` — Sets the size of the icon.
- `SetNotSelectedIconAlpha(float)` — Sets the transparency of icons when the menu item is not selected.
- `SetIconPadding(float)` — Sets the padding between the icon and other content.
- `SetDrawFoldoutTriangle(bool)` — Sets whether to draw the a foldout triangle for menu items with children.
- `SetTriangleSize(float)` — Sets the size of the foldout triangle icon.
- `SetTrianglePadding(float)` — Sets the padding between the foldout triangle icon and other content.
- `SetAlignTriangleLeft(bool)` — Sets whether or not to align the triangle left or right of the content. If right, then the icon is pushed all the way to the right at a fixed position ignoring the indent level.
- `SetBorders(bool)` — Sets whether to draw borders between menu items.
- `SetBorderPadding(float)` — Sets the border alpha.
- `SetBorderAlpha(float)` — Sets the border alpha.
- `SetSelectedColorDarkSkin(Color)` — Sets the background color for when a menu item is selected.
- `SetSelectedColorLightSkin(Color)` — Sets the background color for when a menu item is selected.

### `OdinMenuTreeSelection`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuTreeSelection`

Handles the selection of a Odin Menu Tree with support for multi selection.

**Constructors**

- `OdinMenuTreeSelection(bool)`
  - `supportsMultiSelect` — if set to `true` [supports multi select].

**Fields / properties**

- `Count` — Gets the count.
- `SelectedValue` — Gets the first selected value, returns null if non is selected.
- `SelectedValues` — Gets all selected values.
- `SupportsMultiSelect` — Gets or sets a value indicating whether multi selection is supported.

**Methods**

- `Add(OdinMenuItem)` — Adds a menu item to the selection. If the menu item is already selected, then the item is pushed to the bottom of the selection list. If multi selection is off, then the previous selected menu item is removed first. Adding a item to the selection triggers `SelectionChanged`.
- `Clear()` — Clears the selection and triggers `OnSelectionChanged`.
- `Contains(OdinMenuItem)` — Determines whether an OdinMenuItem is selected.
- `CopyTo(OdinMenuItem[], int)` — Copies all the elements of the current array to the specified array starting at the specified destination array index.
- `GetEnumerator()` — Gets the enumerator.
- `IndexOf(OdinMenuItem)` — Searches for the specified menu item and returns the index location.
- `Remove(OdinMenuItem)` — Removes the specified menu item and triggers `SelectionChanged`.
- `RemoveAt(int)` — Removes the menu item at the specified index and triggers `SelectionChanged`.
- `ConfirmSelection()` — Triggers OnSelectionConfirmed.

### `OdinMenuTreeExtensions`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuTreeExtensions`

Class with utility methods for `OdinMenuTree`s and `OdinMenuItem`s.

**Examples**

```csharp
OdinMenuTree tree = new OdinMenuTree();
tree.AddAllAssetsAtPath("Some Menu Item", "Some Asset Path", typeof(ScriptableObject), true)
    .AddThumbnailIcons();
tree.AddAssetAtPath("Some Second Menu Item", "SomeAssetPath/SomeAssetFile.asset");
// etc...
```

**Methods**

- `AddMenuItemAtPath(OdinMenuTree, OdinMenuItem}, string, OdinMenuItem)` — Adds the menu item at the specified menu item path and populates the result list with all menu items created in order to add the menuItem at the specified path.
- `AddMenuItemAtPath(OdinMenuTree, string, OdinMenuItem)` — Adds the menu item at specified menu item path, and returns all menu items created in order to add the menuItem at the specified path.
- `GetMenuItem(OdinMenuTree, string)` — Gets the menu item at the specified path, returns null non was found.
- `AddAllAssetsAtPathCombined(OdinMenuTree, string, string, Type, bool)` — Adds all asset instances from the specified path and type into a single `OdinMenuItem` at the specified menu item path, and returns all menu items created in order to add the menuItem at the specified path..
- `AddAllAssetsAtPath(OdinMenuTree, string, string, Type, bool, bool)` — Adds all assets at the specified path. Each asset found gets its own menu item inside the specified menu item path.
- `AddAllAssetsAtPath(OdinMenuTree, string, string, bool, bool)` — Adds all assets at the specified path. Each asset found gets its own menu item inside the specified menu item path.
- `AddAssetAtPath(OdinMenuTree, string, string)` — Adds the asset at the specified menu item path and returns all menu items created in order to end up at the specified menu path.
- `AddAssetAtPath(OdinMenuTree, string, string, Type)` — Adds the asset at the specified menu item path and returns all menu items created in order to end up at the specified menu path.
- `SortMenuItemsByName(OdinMenuTree, bool)` — Sorts the entire tree of menu items recursively by name with respects to numbers.
- `SortMenuItemsByName(OdinMenuItem}, bool, bool, bool, bool)` — Sorts the collection of menu items recursively by name with respects to numbers. This is a stable sort, meaning that equivalently ordered items will remain in the same order as they start.
- `SortMenuItemsByName(OdinMenuItem}, OdinMenuItem})` — Sorts the collection of menu items recursively using a given custom comparison. This is a stable sort, meaning that equivalently ordered items will remain in the same order as they start.
- `AddObjectAtPath(OdinMenuTree, string, object, bool)` — Adds the specified object at the specified menu item path and returns all menu items created in order to end up at the specified menu path.
- `AddIcons``1(OdinMenuItem}, Func{``0, Texture})` — Assigns the specified icon to all menu items in the collection with the specified ObjectInstanceType.
- `AddIcons``1(OdinMenuItem}, Func{``0, Sprite})` — Assigns the specified icon to all menu items in the collection with the specified ObjectInstanceType.
- `AddIcons(OdinMenuItem}, OdinMenuItem, Texture})` — Assigns the specified icon to all menu items in the collection.
- `AddIcons(OdinMenuItem}, OdinMenuItem, Sprite})` — Assigns the specified icon to all menu items in the collection.
- `AddIcon(OdinMenuItem}, Sprite)` — Assigns the specified icon to the last menu item in the collection.
- `AddIcon(OdinMenuItem, SdfIconType)` — Assigns the specified icon to the last menu item in the collection.
- `AddIcon(OdinMenuItem}, EditorIcon)` — Assigns the specified icon to the last menu item in the collection.
- `AddIcon(OdinMenuItem}, Texture)` — Assigns the specified icon to the last menu item in the collection.
- `AddIcon(OdinMenuItem}, Texture, Texture)` — Assigns the specified icon to the last menu item in the collection.
- `AddIcons(OdinMenuItem}, EditorIcon)` — Assigns the specified icon to all menu items in the collection.
- `AddIcons(OdinMenuItem}, Texture)` — Assigns the specified icon to all menu items in the collection.
- `AddIcons(OdinMenuItem}, Texture, Texture)` — Assigns the specified icon to all menu items in the collection.
- `AddThumbnailIcons(OdinMenuItem}, bool)` — Assigns the asset mini thumbnail as an icon to all menu items in the collection. If the menu items object is null then a Unity folder icon is assigned.
- `AddThumbnailIcon(OdinMenuItem, bool)` — Assigns the asset mini thumbnail as an icon to all menu items in the collection. If the menu items object is null then a Unity folder icon is assigned.

### `OdinMenuTreeDrawingConfig`

*Full name:* `Sirenix.OdinInspector.Editor.OdinMenuTreeDrawingConfig`

The config used by OdinMenuTree to specify which features of the Menu Tree should be used when drawing.

**Fields / properties**

- `DefaultMenuStyle` — Gets or sets the default menu item style.
- `AutoScrollOnSelectionChanged` — The automatic scroll on selection changed. True by default.
- `DrawScrollView` — Whether to draw the tree in a scrollable view. True by default.
- `AutoHandleKeyboardNavigation` — Whether to handle keyboard navigation after it's done drawing. True by default.
- `DrawSearchToolbar` — Whether to draw a searchbar above the menu tree. True by default.
- `UseCachedExpandedStates` — Whether to the menu items expanded state should be cached. True by default.
- `AutoFocusSearchBar` — Whether to automatically set focus on the search bar when the tree is drawn for the first time. True by default.
- `SelectMenuItemsOnMouseDown` — Whether to select menu items on mouse down, or on click. False by default.
- `ScrollPos` — The scroll-view position.
- `SearchTerm` — The search term.
- `SearchToolbarHeight` — The height of the search toolbar.
- `EXPERIMENTAL_INTERNAL_SparseFixedLayouting` — Will only handle layouting when there has been a hierarchical change (such as an item being expanded or collapsed).
- `SearchFunction` — Gets or sets the search function. Null by default.
- `ConfirmSlecectionOnDoubleClick` — By default, the MenuTree.Selection is confirmed when menu items are double clicked, Set this to false if you don't want that behaviour.
- `ConfirmSelectionOnDoubleClick` — By default, the MenuTree.Selection is confirmed when menu items are double clicked, Set this to false if you don't want that behaviour.

### `OdinEditor`

*Full name:* `Sirenix.OdinInspector.Editor.OdinEditor`

*(no XML documentation shipped for this type)*

### `OdinValueDrawer<T>`

*Full name:* `Sirenix.OdinInspector.Editor.OdinValueDrawer`1`

Base class for all value drawers. Use this class to create your own custom drawers for any specific type.

Remember to provide your custom drawer with an `OdinDrawerAttribute` in order for it to be located by the `!:DrawerLocator`.

Odin supports the use of GUILayout and takes care of undo for you. It also takes care of multi-selection in many simple cases. Checkout the manual for more information on handling multi-selection.

**Remarks.** Checkout the manual for more information.

**Examples**

```csharp
public class MyCustomBaseType
{

}

public class MyCustomType : MyCustomBaseType
{

}

// Remember to wrap your custom attribute drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public sealed class MyCustomBaseTypeDrawer<T> : OdinValueDrawer<T> where T : MyCustomBaseType
{
    protected override void DrawPropertyLayout(IPropertyValueEntry<T> entry, GUIContent label)
    {
        T value = entry.SmartValue;
        // Draw your custom drawer here using GUILayout and EditorGUILAyout.
    }
}

// Usage:
// Both values will be drawn using the MyCustomBaseTypeDrawer
public class MyComponent : SerializedMonoBehaviour
{
    public MyCustomBaseType A;

    public MyCustomType B;
}
```

Odin uses multiple drawers to draw any given property, and the order in which these drawers are called are defined using the `DrawerPriorityAttribute`. Your custom drawer injects itself into this chain of drawers based on its `DrawerPriorityAttribute`. If no `DrawerPriorityAttribute` is defined, a priority is generated automatically based on the type of the drawer. Each drawer can ether choose to draw the property or not, or pass on the responsibility to the next drawer by calling CallNextDrawer(). An example of this is provided in the documentation for `OdinAttributeDrawer`2`.

This means that there is no guarantee that your drawer will be called, sins other drawers could have a higher priority than yours and choose not to call CallNextDrawer().

To avoid this, you can tell Odin, that your drawer is a PrependDecorator or an AppendDecorator drawer (see `!:OdinDrawerBehaviour`) as shown in the example shows below. Prepend and append decorators are always drawn and are also ordered by the `!:OdinDrawerBehaviour`.

Note that Odin's `!:DrawerLocator` have full support for generic class constraints, and if that is not enough, you can also add additional type constraints by overriding CanDrawTypeFilter(Type type).

Also note that all custom property drawers needs to handle cases where the label provided by the DrawPropertyLayout is null, otherwise exceptions will be thrown when in cases where the label is hidden. For instance when [HideLabel] is used, or the property is drawn within a list where labels are also not shown.

```csharp
// [OdinDrawer(OdinDrawerBehaviour.DrawProperty)] // default
// [OdinDrawer(OdinDrawerBehaviour.AppendDecorator)]
[OdinDrawer(OdinDrawerBehaviour.PrependDecorator)]
[DrawerPriority(DrawerPriorityLevel.AttributePriority)]
public sealed class MyCustomTypeDrawer<T> : OdinValueDrawer<T> where T : MyCustomType
{
    public override bool CanDrawTypeFilter(Type type)
    {
        return type != typeof(SomeType);
    }

    protected override void DrawPropertyLayout(IPropertyValueEntry<T> entry, GUIContent label)
    {
        T value = entry.SmartValue;
        // Draw property here.
    }
}
```

**Fields / properties**

- `ValueEntry` — The value entry of the property.

**Methods**

- `DrawPropertyLayout(GUIContent)` — Draws the property with GUILayout support.
- `CanDrawProperty(InspectorProperty)` — Gets a value indicating if the drawer can draw for the specified property.
- `CanDrawValueProperty(InspectorProperty)` — Gets a value indicating if the drawer can draw for the specified property. Override this to implement a custom property filter for your drawer.

### `OdinAttributeDrawer<T>`

*Full name:* `Sirenix.OdinInspector.Editor.OdinAttributeDrawer`1`

Base class for attribute drawers. Use this class to create your own custom attribute drawers that will work for all types. Alternatively you can derive from `OdinAttributeDrawer`2` if you want to only support specific types.

Odin supports the use of GUILayout and takes care of undo for you. It also takes care of multi-selection in many simple cases. Check the manual for more information on handling multi-selection.

Also note that Odin does not require that your custom attribute inherits from Unity's PropertyAttribute.

**Remarks.** Checkout the manual for more information.

**Examples**

Example using the `OdinAttributeDrawer`2`.

```csharp
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false)]
public class CustomRangeAttribute : System.Attribute
{
    public float Min;
    public float Max;

    public CustomRangeAttribute(float min, float max)
    {
        this.Min = min;
        this.Max = max;
    }
}

// Remember to wrap your custom attribute drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public sealed class CustomRangeAttributeDrawer : OdinAttributeDrawer<CustomRangeAttribute, float>
{
    protected override void DrawPropertyLayout(GUIContent label)
    {
        this.ValueEntry.SmartValue = EditorGUILayout.Slider(label, this.ValueEntry.SmartValue, this.Attribute.Min, this.Attribute.Max);
    }
}

// Usage:
public class MyComponent : MonoBehaviour
{
    [CustomRangeAttribute(0, 1)]
    public float MyFloat;
}
```

Example using the `OdinAttributeDrawer`1`.

```csharp
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false)]
public class GUITintColorAttribute : System.Attribute
{
    public Color Color;

    public GUITintColorAttribute(float r, float g, float b, float a = 1)
    {
        this.Color = new Color(r, g, b, a);
    }
}

// Remember to wrap your custom attribute drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public sealed class GUITintColorAttributeDrawer : OdinAttributeDrawer<GUITintColorAttribute>
{
    protected override void DrawPropertyLayout(GUIContent label)
    {
       Color prevColor = GUI.color;
       GUI.color *= this.Attribute.Color;
       this.CallNextDrawer(label);
       GUI.color = prevColor;
    }
}

// Usage:
public class MyComponent : MonoBehaviour
{
    [GUITintColor(0, 1, 0)]
    public float MyFloat;
}
```

Odin uses multiple drawers to draw any given property, and the order in which these drawers are called are defined using the `DrawerPriorityAttribute`. Your custom drawer injects itself into this chain of drawers based on its `DrawerPriorityAttribute`. If no `DrawerPriorityAttribute` is defined, a priority is generated automatically based on the type of the drawer. Each drawer can ether choose to draw the property or not, or pass on the responsibility to the next drawer by calling CallNextDrawer(), as the f attribute does in the example above.

This means that there is no guarantee that your drawer will be called, sins other drawers could have a higher priority than yours and choose not to call CallNextDrawer().

Note that Odin's `DefaultDrawerChainResolver` has full support for generic class constraints, and if that is not enough, you can also add additional type constraints by overriding CanDrawTypeFilter

Also note that all custom property drawers needs to handle cases where the label provided by the DrawPropertyLayout is null, otherwise exceptions will be thrown when in cases where the label is hidden. For instance when [HideLabel] is used, or the property is drawn within a list where labels are also not shown.

```csharp
[DrawerPriority(DrawerPriorityLevel.AttributePriority)]
public sealed class MyCustomAttributeDrawer<T> : OdinAttributeDrawer<MyCustomAttribute, T> where T : class
{
    public override bool CanDrawTypeFilter(Type type)
    {
        return type != typeof(string);
    }

    protected override void DrawPropertyLayout(GUIContent label)
    {
        // Draw property here.
    }
}
```

**Fields / properties**

- `Attribute` — Gets the attribute that the OdinAttributeDrawer draws for.
- `AllowsMultipleAttributes` — Tells whether or not multiple attributes are allowed.

**Methods**

- `DrawPropertyLayout(GUIContent)` — Draws the property with the given label. Override this to implement your custom OdinAttributeDrawer.
- `CanDrawProperty(InspectorProperty)` — Tests if the drawer can draw for the specified property.
- `CanDrawAttributeProperty(InspectorProperty)` — Tests if the attribute drawer can draw for the specified property.

### `OdinAttributeDrawer<T1, T2>`

*Full name:* `Sirenix.OdinInspector.Editor.OdinAttributeDrawer`2`

Base class for all type specific attribute drawers. For non-type specific attribute drawers see `OdinAttributeDrawer`2`.

Odin supports the use of GUILayout and takes care of undo for you. It also takes care of multi-selection in many simple cases. Checkout the manual for more information on handling multi-selection.

Also note that Odin does not require that your custom attribute inherits from Unity's PropertyAttribute.

**Remarks.** Checkout the manual for more information.

**Examples**

Example using the `OdinAttributeDrawer`2`.

```csharp
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false)]
public class CustomRangeAttribute : System.Attribute
{
    public float Min;
    public float Max;

    public CustomRangeAttribute(float min, float max)
    {
        this.Min = min;
        this.Max = max;
    }
}

// Remember to wrap your custom attribute drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public sealed class CustomRangeAttributeDrawer : OdinAttributeDrawer<CustomRangeAttribute, float>
{
    protected override void DrawPropertyLayout(GUIContent label)
    {
        this.ValueEntry.SmartValue = EditorGUILayout.Slider(label, this.ValueEntry.SmartValue, this.Attribute.Min, this.Attribute.Max);
    }
}

// Usage:
public class MyComponent : MonoBehaviour
{
    [CustomRangeAttribute(0, 1)]
    public float MyFloat;
}
```

Example using the `OdinAttributeDrawer`1`.

```csharp
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false)]
public class GUITintColorAttribute : System.Attribute
{
    public Color Color;

    public GUITintColorAttribute(float r, float g, float b, float a = 1)
    {
        this.Color = new Color(r, g, b, a);
    }
}

// Remember to wrap your custom attribute drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public sealed class GUITintColorAttributeDrawer : OdinAttributeDrawer<GUITintColorAttribute>
{
    protected override void DrawPropertyLayout(GUIContent label)
    {
       Color prevColor = GUI.color;
       GUI.color *= this.Attribute.Color;
       this.CallNextDrawer(label);
       GUI.color = prevColor;
    }
}

// Usage:
public class MyComponent : MonoBehaviour
{
    [GUITintColor(0, 1, 0)]
    public float MyFloat;
}
```

Odin uses multiple drawers to draw any given property, and the order in which these drawers are called is defined using the `DrawerPriorityAttribute`. Your custom drawer injects itself into this chain of drawers based on its `DrawerPriorityAttribute`. If no `DrawerPriorityAttribute` is defined, a priority is generated automatically based on the type of the drawer. Each drawer can ether choose to draw the property or not, or pass on the responsibility to the next drawer by calling CallNextDrawer(), as the GUITintColor attribute does in the example above.

This means that there is no guarantee that your drawer will be called, since other drawers could have a higher priority than yours and choose not to call CallNextDrawer().

Note that Odin's `DefaultDrawerChainResolver` has full support for generic class constraints, and if that is not enough, you can also add additional type constraints by overriding CanDrawTypeFilter

Also note that all custom property drawers needs to handle cases where the label provided by the DrawPropertyLayout is null, otherwise exceptions will be thrown when in cases where the label is hidden. For instance when [HideLabel] is used, or the property is drawn within a list where labels are also not shown.

```csharp
[DrawerPriority(DrawerPriorityLevel.AttributePriority)]
public class MyCustomAttributeDrawer<T> : OdinAttributeDrawer<MyCustomAttribute, T> where T : class
{
    public override bool CanDrawTypeFilter(Type type)
    {
        return type != typeof(string);
    }

    protected override void DrawPropertyLayout(GUIContent label)
    {
        // Draw property here.
    }
}
```

**Fields / properties**

- `ValueEntry` — Gets the strongly typed ValueEntry of the OdinAttributeDrawer's property.

**Methods**

- `DrawPropertyLayout(GUIContent)` — Draws the property with the given label. Override this to implement your custom OdinAttributeDrawer.
- `CanDrawAttributeProperty(InspectorProperty)` — Tests if the drawer can draw for the specified property.
- `CanDrawAttributeValueProperty(InspectorProperty)` — Tests if the attribute drawer can draw for the specified property.

### `OdinGroupDrawer<T>`

*Full name:* `Sirenix.OdinInspector.Editor.OdinGroupDrawer`1`

Base class for all group drawers. Use this class to create your own custom group drawers. OdinGroupDrawer are used to group multiple properties together using an attribute.

Note that all box group attributes needs to inherit from the `PropertyGroupAttribute`

Remember to provide your custom drawer with an `OdinDrawerAttribute` in order for it to be located by the `!:DrawerLocator`.

**Remarks.** Checkout the manual for more information.

**Examples**

```csharp
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Property | AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
public class MyBoxGroupAttribute : PropertyGroupAttribute
{
    public MyBoxGroupAttribute(string group, float order = 0) : base(group, order)
    {
    }
}

// Remember to wrap your custom group drawer within a #if UNITY_EDITOR condition, or locate the file inside an Editor folder.

public class BoxGroupAttributeDrawer : OdinGroupDrawer<MyBoxGroupAttribute>
{
    protected override void DrawPropertyGroupLayout(InspectorProperty property, MyBoxGroupAttribute attribute, GUIContent label)
    {
        GUILayout.BeginVertical("box");
        for (int i = 0; i < property.Children.Count; i++)
        {
            InspectorUtilities.DrawProperty(property.Children[i]);
        }
        GUILayout.EndVertical();
    }
}

// Usage:
public class MyComponent : MonoBehaviour
{
    [MyBoxGroup("MyGroup")]
    public int A;

    [MyBoxGroup("MyGroup")]
    public int B;

    [MyBoxGroup("MyGroup")]
    public int C;
}
```

**Methods**

- `DrawPropertyLayout(GUIContent)` — Draws the property with GUILayout support.

### `OdinAttributeProcessor`

*Full name:* `Sirenix.OdinInspector.Editor.OdinAttributeProcessor`

Attribute processor that can add, change and remove attributes from a property.

**Methods**

- `Create(Type)` — Instanciates an OdinAttributeProcessor instance of the specified type.
- `CanProcessChildMemberAttributes(InspectorProperty, MemberInfo)` — Checks if the processor can process attributes for the specified member.
- `CanProcessSelfAttributes(InspectorProperty)` — Checks if the processor can process attributes for the specified property.
- `ProcessChildMemberAttributes(InspectorProperty, MemberInfo, Attribute})` — Processes attributes for the specified member.
- `ProcessSelfAttributes(InspectorProperty, Attribute})` — Processes attributes for the specified property.

### `OdinAttributeProcessor<T>`

*Full name:* `Sirenix.OdinInspector.Editor.OdinAttributeProcessor`1`

Attribute processor that can add, change and remove attributes from a property.

### `InspectorProperty`

*Full name:* `Sirenix.OdinInspector.Editor.InspectorProperty`

Represents a property in the inspector, and provides the hub for all functionality related to that property.

**Fields / properties**

- `SerializationRoot` — Gets the property which is the ultimate root of this property's serialization.
- `Name` — The name of the property.
- `NiceName` — The nice name of the property, usually as converted by `String)`.
- `Label` — The cached label of the property, usually containing `NiceName`.
- `Path` — The full Odin path of the property. To get the Unity property path, see `UnityPropertyPath`.
- `Index` — The child index of this property.
- `ChildResolver` — Gets the resolver for this property's children.
- `RecursiveDrawDepth` — The current recursive draw depth, incremented for each time that the property has caused itself to be drawn recursively.

Note that this is the *current* recursion level, not the total amount of recursions so far this frame.
- `DrawCount` — The amount of times that the property has been drawn so far this frame.
- `DrawerChainIndex` — How deep in the drawer chain the property currently is, in the current drawing session as determined by `DrawCount`.
- `SupportsPrefabModifications` — Whether this property supports having prefab modifications applied or not.
- `Components` — Gets an immutable list of the components attached to the property.
- `Attributes` — Gets an immutable list of processed attributes for the property.
- `StateUpdaters` — Gets an array of the state updaters of the property. Don't change the contents of this array!
- `BaseValueEntry` — The value entry that represents the base value of this property.
- `ValueEntry` — The value entry that represents the strongly typed value of the property; this is possibly an alias entry in case of polymorphism.
- `Parent` — The parent of the property. If null, this property is a root-level property in the `PropertyTree`.
- `Info` — The `InspectorPropertyInfo` of this property.
- `Tree` — The `PropertyTree` that this property exists in.
- `Children` — The children of this property.
- `Context` — The context container of this property.
- `LastDrawnValueRect` — The last rect that this property was drawn within.
- `ParentType` — The type on which this property is declared. This is the same as `TypeOfOwner`.
- `ParentValues` — The parent values of this property, by selection index; this represents the values that 'own' this property, on which it is declared.
- `UnityPropertyPath` — The full Unity property path of this property; note that this is merely a converted version of `Path`, and not necessarily a path to an actual Unity property.

In the case of Odin-serialized data, for example, no Unity properties will exist at this path.
- `DeepReflectionPath` — The full path of this property as used by deep reflection, containing all the necessary information to find this property through reflection only. This is used as the path for prefab modifications.
- `PrefabModificationPath` — The full path of this property as used by prefab modifications and the deep reflection system, containing all the necessary information to find this property through reflection only.
- `State` — The PropertyState of the property at the current draw count index.

**Methods**

- `GetComponent``1()` — Gets the component of a given type on the property, or null if the property does not have a component of the given type.
- `MarkSerializationRootDirty()` — Marks the property's serialization root values dirty if they are derived from UnityEngine.Object.
- `RecordForUndo(string, bool)` — Records the property's serialization root for undo to prepare for undoable changes, with a custom string that includes the property path and Unity object name. If a message is specified, it is included in the custom undo string.
- `GetAttribute``1()` — Gets the first attribute of a given type on this property.
- `GetAttribute``1(Attribute})` — Gets the first attribute of a given type on this property, which is not contained in a given hashset.
- `GetAttributes``1()` — Gets all attributes of a given type on the property.
- `ToString()` — Returns a `String` that represents this instance.
- `Draw()` — Draws this property in the inspector.
- `Draw(GUIContent)` — Draws this property in the inspector with a given default label. This default label may be overridden by attributes on the drawn property.
- `PushDraw()` — Push a draw session. This is used by `DrawCount` and `RecursiveDrawDepth`.
- `IncrementDrawerChainIndex()` — Increments the current drawer chain index. This is used by `DrawerChainIndex`.
- `PopDraw()` — Pop a draw session. This is used by `DrawCount` and `RecursiveDrawDepth`.
- `NextProperty(bool, bool)` — Gets the next property in the `PropertyTree`, or null if none is found.
- `FindParent(InspectorProperty, Boolean}, bool)` — Finds the first parent property that matches a given predicate.
- `FindChild(InspectorProperty, Boolean}, bool)` — Finds the first child recursively, that matches a given predicate.
- `Update(bool)` — Updates the property. This method resets the temporary context, and updates the value entry and the property children.
- `PopulateGenericMenu(GenericMenu)` — Populates a generic menu with items from all drawers for this property that implement `IDefinesGenericMenuItems`.
- `IsChildOf(InspectorProperty)` — Determines whether this property is the child of another property in the hierarchy.
- `IsParentOf(InspectorProperty)` — Determines whether this property is a parent of another property in the hierarchy.

### `PropertyTree`

*Full name:* `Sirenix.OdinInspector.Editor.PropertyTree`

Represents a set of values of the same type as a tree of properties that can be drawn in the inspector, and provides an array of utilities for querying the tree of properties.

**Constructors**

- `PropertyTree()`

**Fields / properties**

- `TreeIsSetupForIMGUIDrawing_TEMP_INTERNAL` — This will be replaced by an IMGUIDrawingComponent in patch 3.2.
- `ComponentProviders` — The component providers that create components for each property in the tree. If you change this list after the tree has been used, you should call tree.RootProperty.RefreshSetup() to make the changes update properly throughout the tree.
- `UnitySerializedObject` — The `SerializedObject` that this tree represents, if the tree was created for a `SerializedObject`.
- `UpdateID` — The current update ID of the tree. This is incremented once, each update, and is used by `Boolean)` to avoid updating multiple times in the same update round.
- `TargetType` — The type of the values that the property tree represents.
- `WeakTargets` — The actual values that the property tree represents.
- `RootPropertyCount` — The number of root properties in the tree.
- `PrefabModificationHandler` — The prefab modification handler of the tree.
- `IncludesSpeciallySerializedMembers` — Whether this property tree also represents members that are specially serialized by Odin.
- `DrawMonoScriptObjectField` — Gets a value indicating whether or not to draw the mono script object field at the top of the property tree.
- `IsStatic` — Gets a value indicating whether or not the PropertyTree is inspecting a static type.
- `SerializationBackend` — The serialization backend used to determine how to draw this property tree. Set this to control.
- `AttributeProcessorLocator` — Gets or sets the `OdinAttributeProcessorLocator` for the PropertyTree.
- `PropertyResolverLocator` — Gets or sets the `OdinPropertyResolverLocator` for the PropertyTree.
- `DrawerChainResolver` — Gets or sets the `DrawerChainResolver` for the PropertyTree.
- `StateUpdaterLocator` — Gets or sets the `StateUpdaterLocator` for the PropertyTree.
- `RootProperty` — Gets the root property of the tree.
- `SecretRootProperty` — Gets the secret root property of the tree, which hosts the property resolver used to resolve the "actual" root properties of the tree.

**Methods**

- `RegisterPropertyDirty(InspectorProperty)` — Registers that a given property is dirty and needs its changes to be applied at the end of the current frame.
- `DelayAction(Action)` — Schedules a delegate to be invoked at the end of the current GUI frame.
- `DelayActionUntilRepaint(Action)` — Schedules a delegate to be invoked at the end of the next Repaint GUI frame.
- `EnumerateTree(bool, bool)` — Enumerates over the properties of the tree.
- `GetPropertyAtPath(string)` — Gets the property at the given path. Note that this is the path found in `Path`, not the Unity path.
- `GetPropertyAtPath(string, InspectorProperty@)` — Gets the property at the given path. Note that this is the path found in `Path`, not the Unity path.
- `GetPropertyAtUnityPath(string)` — Gets the property at the given Unity path.
- `GetPropertyAtUnityPath(string, InspectorProperty@)` — Gets the property at the given Unity path.
- `GetPropertyAtDeepReflectionPath(string)` — Gets the property at the given deep reflection path.
- `GetPropertyAtPrefabModificationPath(string)` — Gets the property at the given Odin prefab modification path.
- `GetPropertyAtPrefabModificationPath(string, InspectorProperty@)` — Gets the property at the given Odin prefab modification path.
- `Draw(bool)` — Draw the property tree, and handles management of undo, as well as marking scenes and drawn assets dirty.

This is a shorthand for calling `Boolean)`, `PropertyTree)` and . `PropertyTree)`.
- `DrawSearch()` — Draws a search bar for the property tree, and draws the search results if the search bar is used.

If this method returns true, the property tree should generally not be drawn normally afterwards.

Note that this method will throw exceptions if the property tree is not set up to be searchable; for that, see `SearchableAttribute)`.
- `GetUnityPropertyForPath(string)` — Gets a Unity property for the given Odin or Unity path. If there is no `SerializedObject` for this property tree, or no such property is found in the `SerializedObject`, a property will be emitted using `UnityPropertyEmitter`.
- `GetUnityPropertyForPath(string, FieldInfo@)` — Gets a Unity property for the given Odin or Unity path. If there is no `SerializedObject` for this property tree, or no such property is found in the `SerializedObject`, a property will be emitted using `UnityPropertyEmitter`.
- `ObjectIsReferenced(object, String@)` — Checks whether a given object instance is referenced anywhere in the tree, and if it is, gives the path of the first time the object reference was encountered as an out parameter.
- `GetReferenceCount(object)` — Gets the number of references to a given object instance in this tree.
- `UpdateTree()` — Updates all properties in the entire tree, and validates the prefab state of the tree, if applicable.
- `ReplaceAllReferences(object, object)` — Replaces all occurrences of a value with another value, in the entire tree.
- `GetRootProperty(int)` — Gets the root tree property at a given index.
- `InvokeDelayedActions()` — Invokes the actions that have been delayed using `Action)` and `Action)`.
- `ApplyChanges()` — Applies all changes made with properties to the inspected target tree values, and marks all changed Unity objects dirty.
- `InvokeOnValidate()` — Invokes the OnValidate method on the property tree's targets if they are derived from `Object` and have the method defined.
- `ForceRegisterObjectReference(object, InspectorProperty)` — Registers an object reference to a given path; this is used to ensure that objects are always registered after having been encountered once.
- `CreateStatic(Type)` — Creates a PropertyTree to inspect the static values of the given type.
- `Create(object)` — Creates a new `PropertyTree` for a given target value.
- `Create(object, SerializationBackend)` — Creates a new `PropertyTree` for a given target value.
- `Create(Object[])` — Creates a new `PropertyTree` for a set of given target values.

Note that the targets all need to be of the same type.
- `Create(SerializedObject)` — Creates a new `PropertyTree` for all target values of a `SerializedObject`.
- `Create(SerializedObject, SerializationBackend)` — Creates a new `PropertyTree` for all target values of a `SerializedObject`.
- `Create(IList)` — Creates a new `PropertyTree` for a set of given target values.

Note that the targets all need to be of the same type.
- `Create(IList, SerializationBackend)` — Creates a new `PropertyTree` for a set of given target values.

Note that the targets all need to be of the same type.
- `Create(IList, SerializedObject)` — Creates a new `PropertyTree` for a set of given target values, represented by a given `SerializedObject`.

Note that the targets all need to be of the same type.
- `Create(IList, SerializedObject, SerializationBackend)` — Creates a new `PropertyTree` for a set of given target values, represented by a given `SerializedObject`.

Note that the targets all need to be of the same type.
- `SetSearchable(bool, SearchableAttribute)` — Sets whether the property tree should be searchable or not, and allows the passing in of a custom SearchableAttribute instance to configure the search.

### `RegisterValidatorAttribute`

*Full name:* `Sirenix.OdinInspector.Editor.Validation.RegisterValidatorAttribute`

Apply this to an assembly to register validators for the validation system. This enables locating of all relevant validator types very quickly.
