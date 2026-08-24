---
title: "Odin Inspector 4.0.2.3: attribute reference (Sirenix.OdinInspector)"
source_files: ["Assets/Plugins/Sirenix/Assemblies/Sirenix.OdinInspector.Attributes.xml"]
odin_version: "4.0.2.3"
publisher: "Sirenix (Odin Inspector XML documentation shipped with the DLLs)"
generated: "2026-08-24"
generator: "docs/reference/_tools/build_odin_reference.py"
topic: "third-party/odin-inspector"
---

> Generated file — do not edit by hand. Re-run the generator after an Odin upgrade.


# Odin Inspector 4.0.2.3 — attributes in `Sirenix.OdinInspector`

113 attribute types from `Sirenix.OdinInspector.Attributes.dll`. All of them are Editor-only drawing/validation hints: they never change what Unity serializes (see [serialization.md](serialization.md) for the separate Odin serializer, which this project does not use).

## Index

- [`AssetListAttribute`](#assetlistattribute) — AssetLists is used on lists and arrays and single elements of unity types, and replaces the default list drawer with a list of all possib…
- [`AssetSelectorAttribute`](#assetselectorattribute) — The AssetSelector attribute can be used on all Unity types and will prepend a small button next to the object field that when clicked, wi…
- [`AssetsOnlyAttribute`](#assetsonlyattribute) — AssetsOnly is used on object properties, and restricts the property to project assets, and not scene objects.
- [`BoxGroupAttribute`](#boxgroupattribute) — BoxGroup is used on any property and organizes the property in a boxed group.
- [`ButtonAttribute`](#buttonattribute) — Buttons are used on functions, and allows for clickable buttons in the inspector.
- [`ButtonGroupAttribute`](#buttongroupattribute) — ButtonGroup is used on any instance function, and adds buttons to the inspector organized into horizontal groups.
- [`ChildGameObjectsOnlyAttribute`](#childgameobjectsonlyattribute) — The ChildGameObjectsOnly attribute can be used on Components and GameObject fields and will prepend a small button next to the object-fie…
- [`ColorPaletteAttribute`](#colorpaletteattribute) — ColorPalette is used on any Color property, and allows for choosing colors from different definable palettes.
- [`CustomContextMenuAttribute`](#customcontextmenuattribute) — CustomContextMenu is used on any property, and adds a custom options to the context menu for the property.
- [`CustomValueDrawerAttribute`](#customvaluedrawerattribute) — Instead of making a new attribute, and a new drawer, for a one-time thing, you can with this attribute, make a method that acts as a cust…
- [`DelayedPropertyAttribute`](#delayedpropertyattribute) — Delays applying changes to properties while they still being edited in the inspector. Similar to Unity's built-in Delayed attribute, but…
- [`DetailedInfoBoxAttribute`](#detailedinfoboxattribute) — DetailedInfoBox is used on any property, and displays a message box that can be expanded to show more details.
- [`DisableContextMenuAttribute`](#disablecontextmenuattribute) — DisableContextMenu is used on any property and disables the context menu for that property.
- [`DisableIfAttribute`](#disableifattribute) — DisableIf is used on any property, and can disable or enable the property in the inspector.
- [`DisableInAttribute`](#disableinattribute) — Disables a member based on which type of a prefab and instance it is in.
- [`DisableInEditorModeAttribute`](#disableineditormodeattribute) — DisableInEditorMode is used on any property, and disables the property when not in play mode.
- [`DisableInInlineEditorsAttribute`](#disableininlineeditorsattribute) — Disables a property if it is drawn within an `InlineEditorAttribute`.
- [`DisableInNonPrefabsAttribute`](#disableinnonprefabsattribute) — Disables a property if it is drawn from a non-prefab asset or instance.
- [`DisableInPlayModeAttribute`](#disableinplaymodeattribute) — DisableInPlayMode is used on any property, and disables the property when in play mode.
- [`DisableInPrefabAssetsAttribute`](#disableinprefabassetsattribute) — Disables a property if it is drawn from a prefab asset.
- [`DisableInPrefabInstancesAttribute`](#disableinprefabinstancesattribute) — Disables a property if it is drawn from a prefab instance.
- [`DisableInPrefabsAttribute`](#disableinprefabsattribute) — Disables a property if it is drawn from a prefab asset or a prefab instance.
- [`DisallowModificationsInAttribute`](#disallowmodificationsinattribute) — DisallowModificationsIn disables / grays out members, preventing modifications from being made and enables validation, providing error me…
- [`DisplayAsStringAttribute`](#displayasstringattribute) — DisplayAsString is used on any property, and displays a string in the inspector as text.
- [`DoNotDrawAsReferenceAttribute`](#donotdrawasreferenceattribute) — Indicates that the member should not be drawn as a value reference, if it becomes a reference to another value in the tree. Beware, and u…
- [`DontApplyToListElementsAttribute`](#dontapplytolistelementsattribute) — DontApplyToListElements is used on other attributes, and indicates that those attributes should be applied only to the list, and not to t…
- [`DontValidateAttribute`](#dontvalidateattribute) — Tells the validation system that this member should not be validated. It will not show validation messages in the inspector, and it will…
- [`DrawWithUnityAttribute`](#drawwithunityattribute) — DrawWithUnity can be applied to a field or property to make Odin draw it using Unity's old drawing system. Use it if you want to selectiv…
- [`DrawWithVisualElementsAttribute`](#drawwithvisualelementsattribute) — Force Odin to draw this value as an IMGUI-embedded UI Toolkit Visual Element.
- [`EnableGUIAttribute`](#enableguiattribute) — An attribute that enables GUI.
- [`EnableIfAttribute`](#enableifattribute) — EnableIf is used on any property, and can enable or disable the property in the inspector.
- [`EnableInAttribute`](#enableinattribute) — Enables a member based on which type of a prefab and instance it is.
- [`EnumPagingAttribute`](#enumpagingattribute) — Draws an enum selector in the inspector with next and previous buttons to let you cycle through the available values for the enum property.
- [`EnumToggleButtonsAttribute`](#enumtogglebuttonsattribute) — Draws an enum in a horizontal button group instead of a dropdown.
- [`FilePathAttribute`](#filepathattribute) — FilePath is used on string properties, and provides an interface for file paths.
- [`FolderPathAttribute`](#folderpathattribute) — FolderPath is used on string properties, and provides an interface for directory paths.
- [`FoldoutGroupAttribute`](#foldoutgroupattribute) — FoldoutGroup is used on any property, and organizes properties into a foldout.
- [`GUIColorAttribute`](#guicolorattribute) — GUIColor is used on any property and changes the GUI color used to draw the property.
- [`HideDuplicateReferenceBoxAttribute`](#hideduplicatereferenceboxattribute) — Indicates that Odin should hide the reference box, if this property would otherwise be drawn as a reference to another property, due to d…
- [`HideIfAttribute`](#hideifattribute) — HideIf is used on any property and can hide the property in the inspector.
- [`HideIfGroupAttribute`](#hideifgroupattribute) — HideIfGroup allows for showing or hiding a group of properties based on a condition. The attribute is a group attribute and can therefore…
- [`HideInAttribute`](#hideinattribute) — Hides a member based on which type of a prefab and instance it is in.
- [`HideInEditorModeAttribute`](#hideineditormodeattribute) — HideInEditorMode is used on any property, and hides the property when not in play mode.
- [`HideInInlineEditorsAttribute`](#hideininlineeditorsattribute) — Hides a property if it is drawn within an `InlineEditorAttribute`.
- [`HideInNonPrefabsAttribute`](#hideinnonprefabsattribute) — Hides a property if it is drawn from a non prefab instance or asset.
- [`HideInPlayModeAttribute`](#hideinplaymodeattribute) — HideInPlayMode is used on any property, and hides the property when not in editor mode.
- [`HideInPrefabAssetsAttribute`](#hideinprefabassetsattribute) — Hides a property if it is drawn from a prefab asset.
- [`HideInPrefabInstancesAttribute`](#hideinprefabinstancesattribute) — Hides a property if it is drawn from a prefab instance.
- [`HideInPrefabsAttribute`](#hideinprefabsattribute) — Hides a property if it is drawn from a prefab instance or a prefab asset.
- [`HideInTablesAttribute`](#hideintablesattribute) — The HideInTables attribute is used to prevent members from showing up as columns in tables drawn using the `TableListAttribute`.
- [`HideLabelAttribute`](#hidelabelattribute) — HideLabel is used on any property, and hides the label in the inspector.
- [`HideMonoScriptAttribute`](#hidemonoscriptattribute) — Apply HideMonoScript to your class to prevent the Script property from being shown in the inspector.
- [`HideNetworkBehaviourFieldsAttribute`](#hidenetworkbehaviourfieldsattribute) — Apply HideNetworkBehaviourFields to your class to prevent the special "Network Channel" and "Network Send Interval" properties from being…
- [`HideReferenceObjectPickerAttribute`](#hidereferenceobjectpickerattribute) — Hides the polymorphic object-picker shown above the properties of non-Unity serialized reference types.
- [`HorizontalGroupAttribute`](#horizontalgroupattribute) — HorizontalGroup is used group multiple properties horizontally in the inspector.
- [`ImageAttribute`](#imageattribute) — Draws an image directly in the inspector.
- [`IncludeMyAttributesAttribute`](#includemyattributesattribute) — When this attribute is added is added to another attribute, then attributes from that attribute will also be added to the property in the…
- [`IndentAttribute`](#indentattribute) — Indent is used on any property and moves the property's label to the right.
- [`InfoBoxAttribute`](#infoboxattribute) — InfoBox is used on any property, and display a text box above the property in the inspector.
- [`InlineButtonAttribute`](#inlinebuttonattribute) — The inline button adds a button to the end of a property.
- [`InlineEditorAttribute`](#inlineeditorattribute) — InlineAttribute is used on any property or field with a type that inherits from UnityEngine.Object. This includes components and assets etc.
- [`InlinePropertyAttribute`](#inlinepropertyattribute) — The Inline Property is used to place the contents of a type next to the label, instead of being rendered in a foldout.
- [`LabelTextAttribute`](#labeltextattribute) — LabelText is used to change the labels of properties.
- [`LabelWidthAttribute`](#labelwidthattribute) — LabelWidth is used to change the width of labels for properties.
- [`ListDrawerSettingsAttribute`](#listdrawersettingsattribute) — Customize the behavior for lists and arrays in the inspector.
- [`MaxValueAttribute`](#maxvalueattribute) — MaxValue is used on primitive fields. It caps value of the field to a maximum value.
- [`MinMaxSliderAttribute`](#minmaxsliderattribute) — Draw a special slider the user can use to specify a range between a min and a max value.
- [`MinValueAttribute`](#minvalueattribute) — MinValue is used on primitive fields. It caps value of the field to a minimum value.
- [`MultiLinePropertyAttribute`](#multilinepropertyattribute) — MultiLineProperty is used on any string property.
- [`OnCollectionChangedAttribute`](#oncollectionchangedattribute) — OnCollectionChanged can be put on collections, and provides an event callback when the collection is about to be changed through the insp…
- [`OnInspectorDisposeAttribute`](#oninspectordisposeattribute) — The OnInspectorDispose attribute takes in an action string as an argument (typically the name of a method to be invoked, or an expression…
- [`OnInspectorGUIAttribute`](#oninspectorguiattribute) — OnInspectorGUI is used on any property, and will call the specified function whenever the inspector code is running.
- [`OnInspectorInitAttribute`](#oninspectorinitattribute) — The OnInspectorInit attribute takes in an action string as an argument (typically the name of a method to be invoked, or an expression to…
- [`OnStateUpdateAttribute`](#onstateupdateattribute) — OnStateUpdate provides an event callback when the property's state should be updated, when the StateUpdaters run on the property instance…
- [`OnValueChangedAttribute`](#onvaluechangedattribute) — OnValueChanged works on properties and fields, and calls the specified function whenever the value has been changed via the inspector.
- [`OptionalAttribute`](#optionalattribute) — Overrides the 'Reference Required by Default' rule to allow for null values. Has no effect if the rule is disabled.
- [`PreviewFieldAttribute`](#previewfieldattribute) — Draws a square ObjectField which renders a preview for UnityEngine.Object types. This object field also adds support for drag and drop, d…
- [`ProgressBarAttribute`](#progressbarattribute) — Draws a horizontal progress bar based on the value of the property.
- [`PropertyGroupAttribute`](#propertygroupattribute) — Attribute to derive from if you wish to create a new property group type, such as box groups or tab groups.
- [`PropertyOrderAttribute`](#propertyorderattribute) — PropertyOrder is used on any property, and allows for ordering of properties.
- [`PropertyRangeAttribute`](#propertyrangeattribute) — PropertyRange attribute creates a slider control to set the value of a property to between the specified range.
- [`PropertySpaceAttribute`](#propertyspaceattribute) — The PropertySpace attribute have the same function as Unity's existing Space attribute, but can be applied anywhere as opposed to just fi…
- [`PropertyTooltipAttribute`](#propertytooltipattribute) — PropertyTooltip is used on any property, and creates tooltips for when hovering the property in the inspector.
- [`ReadOnlyAttribute`](#readonlyattribute) — ReadOnly is used on any property, and prevents the property from being changed in the inspector.
- [`RequiredAttribute`](#requiredattribute) — Required is used on any object property, and draws a message in the inspector if the property is missing.
- [`RequiredInAttribute`](#requiredinattribute) — Makes a member required based on which type of a prefab and instance it is in.
- [`ResponsiveButtonGroupAttribute`](#responsivebuttongroupattribute) — Groups buttons into a group that will position and resize the buttons based on the amount of available layout space.
- [`SceneObjectsOnlyAttribute`](#sceneobjectsonlyattribute) — SceneObjectsOnly is used on object properties, and restricts the property to scene objects, and not project assets.
- [`SearchableAttribute`](#searchableattribute) — Adds a search filter that can search the children of the field or type on which it is applied. Note that this does not currently work whe…
- [`ShowDrawerChainAttribute`](#showdrawerchainattribute) — ShowDrawerChain lists all prepend, append and value drawers being used in the inspector. This is great in situations where you want to de…
- [`ShowIfAttribute`](#showifattribute) — ShowIf is used on any property and can hide the property in the inspector.
- [`ShowIfGroupAttribute`](#showifgroupattribute) — ShowIfGroup allows for showing or hiding a group of properties based on a condition. The attribute is a group attribute and can therefore…
- [`ShowInAttribute`](#showinattribute) — Shows a member based on which type of a prefab and instance it is in.
- [`ShowInInlineEditorsAttribute`](#showininlineeditorsattribute) — Only shows a property if it is drawn within an `InlineEditorAttribute`.
- [`ShowInInspectorAttribute`](#showininspectorattribute) — ShowInInspector is used on any member, and shows the value in the inspector. Note that the value being shown due to this attribute DOES N…
- [`ShowOdinSerializedPropertiesInInspectorAttribute`](#showodinserializedpropertiesininspectorattribute) — Marks a type as being specially serialized. Odin uses this attribute to check whether it should include non-Unity-serialized members in t…
- [`ShowPropertyResolverAttribute`](#showpropertyresolverattribute) — ShowPropertyResolver shows the property resolver responsible for bringing the member into the property tree. This is useful in situations…
- [`SuffixLabelAttribute`](#suffixlabelattribute) — The SuffixLabel attribute draws a label at the end of a property.
- [`SuppressInvalidAttributeErrorAttribute`](#suppressinvalidattributeerrorattribute) — SuppressInvalidAttributeError is used on members to suppress the inspector error message you get when applying an attribute to a value th…
- [`TabGroupAttribute`](#tabgroupattribute) — TabGroup is used on any property, and organizes properties into different tabs.
- [`TableColumnWidthAttribute`](#tablecolumnwidthattribute) — The TableColumnWidth attribute is used to further customize the width of a column in tables drawn using the `TableListAttribute`.
- [`TableListAttribute`](#tablelistattribute) — Renders lists and arrays in the inspector as tables.
- [`TableMatrixAttribute`](#tablematrixattribute) — The TableMatrix attribute is used to further specify how Odin should draw two-dimensional arrays.
- [`TitleAttribute`](#titleattribute) — Title is used to make a bold header above a property.
- [`TitleGroupAttribute`](#titlegroupattribute) — Groups properties vertically together with a title, an optional subtitle, and an optional horizontal line.
- [`ToggleAttribute`](#toggleattribute) — Toggle is used on any field or property, and allows to enable or disable the property in the inspector.
- [`ToggleGroupAttribute`](#togglegroupattribute) — ToggleGroup is used on any field, and create a toggleable group of options.
- [`ToggleLeftAttribute`](#toggleleftattribute) — Draws the checkbox before the label instead of after.
- [`TypeInfoBoxAttribute`](#typeinfoboxattribute) — The TypeInfoBox attribute adds an info box to the very top of a type in the inspector.
- [`ValidateInputAttribute`](#validateinputattribute) — ValidateInput is used on any property, and allows to validate input from inspector.
- [`ValueDropdownAttribute`](#valuedropdownattribute) — ValueDropdown is used on any property and creates a dropdown with configurable options.
- [`VerticalGroupAttribute`](#verticalgroupattribute) — VerticalGroup is used to gather properties together in a vertical group in the inspector.
- [`WrapAttribute`](#wrapattribute) — Wrap is used on most primitive property, and allows for wrapping the value when it goes out of the defined range.

## Attributes

### `AssetListAttribute`

*Full name:* `Sirenix.OdinInspector.AssetListAttribute`

AssetLists is used on lists and arrays and single elements of unity types, and replaces the default list drawer with a list of all possible assets with the specified filter.

Use this to both filter and include or exclude assets from a list or an array, without navigating the project window.

**Remarks.** Asset lists works on all asset types such as materials, scriptable objects, prefabs, custom components, audio, textures etc, and does also show inherited types.

**Examples**

The following example will display an asset list of all prefabs located in the project window.

```csharp
public class AssetListExamples : MonoBehaviour
{
    [InfoBox("The AssetList attribute work on both lists of UnityEngine.Object types and UnityEngine.Object types, but have different behaviour.")]
    [AssetList]
    [InlineEditor(InlineEditorModes.LargePreview)]
    public GameObject Prefab;

    [AssetList]
    public List<PlaceableObject> PlaceableObjects;

    [AssetList(Path = "Plugins/Sirenix/")]
    [InlineEditor(InlineEditorModes.LargePreview)]
    public UnityEngine.Object Object;

    [AssetList(AutoPopulate = true)]
    public List<PlaceableObject> PlaceableObjectsAutoPopulated;

    [AssetList(LayerNames = "MyLayerName")]
    public GameObject[] AllPrefabsWithLayerName;

    [AssetList(AssetNamePrefix = "Rock")]
    public List<GameObject> PrefabsStartingWithRock;

    [AssetList(Path = "/Plugins/Sirenix/")]
    public List<GameObject> AllPrefabsLocatedInFolder;

    [AssetList(Tags = "MyTagA, MyTabB", Path = "/Plugins/Sirenix/")]
    public List<GameObject> GameObjectsWithTag;

    [AssetList(Path = "/Plugins/Sirenix/")]
    public List<Material> AllMaterialsInSirenix;

    [AssetList(Path = "/Plugins/Sirenix/")]
    public List<ScriptableObject> AllScriptableObjects;

    [InfoBox("Use a method as a custom filter for the asset list.")]
    [AssetList(CustomFilterMethod = "HasRigidbodyComponent")]
    public List<GameObject> MyRigidbodyPrefabs;

    private bool HasRigidbodyComponent(GameObject obj)
    {
        return obj.GetComponent<Rigidbody>() != null;
    }
}
```

**Constructors**

- `AssetListAttribute()`

**Fields / properties**

- `AutoPopulate` — If `true`, all assets found and displayed by the asset list, will automatically be added to the list when inspected.
- `Tags` — Comma separated list of tags to filter the asset list.
- `LayerNames` — Filter the asset list to only include assets with a specified layer.
- `AssetNamePrefix` — Filter the asset list to only include assets which name begins with.
- `Path` — Filter the asset list to only include assets which is located at the specified path.
- `CustomFilterMethod` — Filter the asset list to only include assets for which the given filter method returns true.

### `AssetSelectorAttribute`

*Full name:* `Sirenix.OdinInspector.AssetSelectorAttribute`

The AssetSelector attribute can be used on all Unity types and will prepend a small button next to the object field that when clicked, will present the user with a dropdown of assets to select from which can be customized from the attribute.

**Fields / properties**

- `IsUniqueList` — True by default.
- `DrawDropdownForListElements` — True by default. If the ValueDropdown attribute is applied to a list, then disabling this, will render all child elements normally without using the ValueDropdown. The ValueDropdown will still show up when you click the add button on the list drawer, unless `DisableListAddButtonBehaviour` is true.
- `DisableListAddButtonBehaviour` — False by default.
- `ExcludeExistingValuesInList` — If the ValueDropdown attribute is applied to a list, and `IsUniqueList` is set to true, then enabling this, will exclude existing values, instead of rendering a checkbox indicating whether the item is already included or not.
- `ExpandAllMenuItems` — If the dropdown renders a tree-view, then setting this to true will ensure everything is expanded by default.
- `FlattenTreeView` — By default, the dropdown will create a tree view.
- `DropdownWidth` — Gets or sets the width of the dropdown. Default is zero.
- `DropdownHeight` — Gets or sets the height of the dropdown. Default is zero.
- `DropdownTitle` — Gets or sets the title for the dropdown. Null by default.
- `SearchInFolders` — Specify which folders to search in. Specifying no folders will make it search in your entire project. Use the `Paths` property for a more clean way of populating this array through attributes.
- `Filter` — The filters we should use when calling AssetDatabase.FindAssets.
- `Paths` — Specify which folders to search in. Specifying no folders will make it search in your entire project. You can declare multiple paths using '|' as the separator. Example:

```csharp
[AssetList(Paths = "Assets/Textures|Assets/Other/Textures")]
```

This property is simply a more clean way of populating the `SearchInFolders` array.

### `AssetsOnlyAttribute`

*Full name:* `Sirenix.OdinInspector.AssetsOnlyAttribute`

AssetsOnly is used on object properties, and restricts the property to project assets, and not scene objects.

Use this when you want to ensure an object is from the project, and not from the scene.

**Examples**

The following example shows a component with a game object property, that must be a prefab from the project, and not a scene object.

```csharp
public MyComponent : MonoBehaviour
{
    [AssetsOnly]
    public GameObject MyPrefab;
}
```

### `BoxGroupAttribute`

*Full name:* `Sirenix.OdinInspector.BoxGroupAttribute`

BoxGroup is used on any property and organizes the property in a boxed group.

Use this to cleanly organize relevant values together in the inspector.

**Examples**

The following example shows how BoxGroup is used to organize properties together into a box.

```csharp
public class BoxGroupExamples : MonoBehaviour
{
    // Box with a centered title.
    [BoxGroup("Centered Title", centerLabel: true)]
    public int A;

    [BoxGroup("Centered Title", centerLabel: true)]
    public int B;

    [BoxGroup("Centered Title", centerLabel: true)]
    public int C;

    // Box with a title.
    [BoxGroup("Left Oriented Title")]
    public int D;

    [BoxGroup("Left Oriented Title")]
    public int E;

    // Box with a title recieved from a field.
    [BoxGroup("$DynamicTitle1"), LabelText("Dynamic Title")]
    public string DynamicTitle1 = "Dynamic box title";

    [BoxGroup("$DynamicTitle1")]
    public int F;

    // Box with a title recieved from a property.
    [BoxGroup("$DynamicTitle2")]
    public int G;

    [BoxGroup("$DynamicTitle2")]
    public int H;

    // Box without a title.
    [InfoBox("You can also hide the label of a box group.")]
    [BoxGroup("NoTitle", false)]
    public int I;

    [BoxGroup("NoTitle")]
    public int J;

    [BoxGroup("NoTitle")]
    public int K;

#if UNITY_EDITOR
    public string DynamicTitle2
    {
        get { return UnityEditor.PlayerSettings.productName; }
    }
#endif

    [BoxGroup("Boxed Struct"), HideLabel]
    public SomeStruct BoxedStruct;

    public SomeStruct DefaultStruct;

    [Serializable]
    public struct SomeStruct
    {
        public int One;
        public int Two;
        public int Three;
    }
}
```

**Constructors**

- `BoxGroupAttribute(string, bool, bool, float)`
  - `group` — The box group.
  - `showLabel` — If `true` a label will be drawn for the group.
  - `centerLabel` — If set to `true` the header label will be centered.
  - `order` — The order of the group in the inspector.
- `BoxGroupAttribute()`

**Fields / properties**

- `ShowLabel` — If `true` a label for the group will be drawn on top.
- `CenterLabel` — If `true` the header label will be places in the center of the group header. Otherwise it will be in left side.
- `LabelText` — If non-null, this is used instead of the group's name as the title label.

### `ButtonAttribute`

*Full name:* `Sirenix.OdinInspector.ButtonAttribute`

Buttons are used on functions, and allows for clickable buttons in the inspector.

**Examples**

The following example shows a component that has an initialize method, that can be called from the inspector.

```csharp
public class MyComponent : MonoBehaviour
{
    [Button]
    private void Init()
    {
        // ...
    }
}
```

The following example show how a Button could be used to test a function.

```csharp
public class MyBot : MonoBehaviour
{
    [Button]
    private void Jump()
    {
        // ...
    }
}
```

The following example show how a Button can named differently than the function it's been attached to.

```csharp
public class MyComponent : MonoBehaviour
{
    [Button("Function")]
    private void MyFunction()
    {
        // ...
    }
}
```

**Constructors**

- `ButtonAttribute()`
- `ButtonAttribute(ButtonSizes)`
  - `size` — The size of the button.
- `ButtonAttribute(int)`
  - `buttonSize` — The size of the button.
- `ButtonAttribute(string)`
  - `name` — Custom name for the button.
- `ButtonAttribute(string, ButtonSizes)`
  - `name` — Custom name for the button.
  - `buttonSize` — Size of the button.
- `ButtonAttribute(string, int)`
  - `name` — Custom name for the button.
  - `buttonSize` — Size of the button in pixels.
- `ButtonAttribute(ButtonStyle)`
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(int, ButtonStyle)`
  - `buttonSize` — The size of the button.
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(ButtonSizes, ButtonStyle)`
  - `size` — The size of the button.
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(string, ButtonStyle)`
  - `name` — Custom name for the button.
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(string, ButtonSizes, ButtonStyle)`
  - `name` — Custom name for the button.
  - `buttonSize` — Size of the button.
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(string, int, ButtonStyle)`
  - `name` — Custom name for the button.
  - `buttonSize` — Size of the button in pixels.
  - `parameterBtnStyle` — Button style for methods with parameters.
- `ButtonAttribute(SdfIconType, IconAlignment)`
  - `icon` — The icon to be displayed inside the button.
  - `iconAlignment` — The alignment of the icon that is displayed inside the button.
- `ButtonAttribute(SdfIconType)`
  - `icon` — The icon to be displayed inside the button.
- `ButtonAttribute(SdfIconType, string)`
  - `icon` — The icon to be displayed inside the button.
  - `name` — Custom name for the button.

**Fields / properties**

- `Name` — Use this to override the label on the button.
- `Style` — The style in which to draw the button.
- `Expanded` — If the button contains parameters, you can disable the foldout it creates by setting this to true.
- `DisplayParameters` — Whether to display the button method's parameters (if any) as values in the inspector. True by default.

If this is set to false, the button method will instead be invoked through an ActionResolver or ValueResolver (based on whether it returns a value), giving access to contextual named parameter values like "InspectorProperty property" that can be passed to the button method.
- `DirtyOnClick` — Whether the containing object or scene (if there is one) should be marked dirty when the button is clicked. True by default. Note that if this is false, undo for any changes caused by the button click is also disabled, as registering undo events also causes dirtying.
- `ButtonHeight` — Gets the height of the button. If it's zero or below then use default.
- `Icon` — The icon to be displayed inside the button.
- `IconAlignment` — The alignment of the icon that is displayed inside the button.
- `ButtonAlignment` — The alignment of the button represented by a range from 0 to 1 where 0 is the left edge of the available space and 1 is the right edge. ButtonAlignment only has an effect when Stretch is set to false.
- `Stretch` — Whether the button should stretch to fill all of the available space. Default value is true.
- `DrawResult` — If the button has a return type, set this to false to not draw the result. Default value is true.

### `ButtonGroupAttribute`

*Full name:* `Sirenix.OdinInspector.ButtonGroupAttribute`

ButtonGroup is used on any instance function, and adds buttons to the inspector organized into horizontal groups.

Use this to organize multiple button in a tidy horizontal group.

**Examples**

The following example shows how ButtonGroup is used to organize two buttons into one group.

```csharp
public class MyComponent : MonoBehaviour
{
    [ButtonGroup("MyGroup")]
    private void A()
    {
        // ..
    }

    [ButtonGroup("MyGroup")]
    private void B()
    {
        // ..
    }
}
```

The following example shows how ButtonGroup can be used to create multiple groups of buttons.

```csharp
public class MyComponent : MonoBehaviour
{
    [ButtonGroup("First")]
    private void A()
    { }

    [ButtonGroup("First")]
    private void B()
    { }

    [ButtonGroup("")]
    private void One()
    { }

    [ButtonGroup("")]
    private void Two()
    { }

    [ButtonGroup("")]
    private void Three()
    { }
}
```

**Constructors**

- `ButtonGroupAttribute(string, float)`
  - `group` — The group to organize the button into.
  - `order` — The order of the group in the inspector..

**Fields / properties**

- `ButtonHeight` — Gets the height of the button. If it's zero or below then use default.
- `IconAlignment` — The alignment of the icon that is displayed inside the button.
- `ButtonAlignment` — The alignment of the button represented by a range from 0 to 1 where 0 is the left edge of the available space and 1 is the right edge.
- `Stretch` — Whether the button should stretch to fill all of the available space. Default value is true.

### `ChildGameObjectsOnlyAttribute`

*Full name:* `Sirenix.OdinInspector.ChildGameObjectsOnlyAttribute`

The ChildGameObjectsOnly attribute can be used on Components and GameObject fields and will prepend a small button next to the object-field that will search through all child gameobjects for assignable objects and present them in a dropdown for the user to choose from.

### `ColorPaletteAttribute`

*Full name:* `Sirenix.OdinInspector.ColorPaletteAttribute`

ColorPalette is used on any Color property, and allows for choosing colors from different definable palettes.

Use this to allow the user to choose from a set of predefined color options.

**Remarks.** See and edit the color palettes in Tools > Odin > Inspector > Preferences > Drawers > Color Palettes.

> **Note:** The color property is not tied to the color palette, and can be edited. Therefore the color will also not update if the ColorPalette is edited.

**Examples**

The following example shows how ColorPalette is applied to a property. The user can freely choose between all available ColorPalettes.

```csharp
public class ColorPaletteExamples : MonoBehaviour
{
    [ColorPalette]
    public Color ColorOptions;

    [ColorPalette("Underwater")]
    public Color UnderwaterColor;

    [ColorPalette("Fall"), HideLabel]
    public Color WideColorPalette;

    [ColorPalette("My Palette")]
    public Color MyColor;

    [ColorPalette("Clovers")]
    public Color[] ColorArray;
}
```

**Constructors**

- `ColorPaletteAttribute()`
- `ColorPaletteAttribute(string)`
  - `paletteName` — Name of the palette.

**Fields / properties**

- `PaletteName` — Gets the name of the palette.
- `ShowAlpha` — Indicates if the color palette should show alpha values or not.

### `CustomContextMenuAttribute`

*Full name:* `Sirenix.OdinInspector.CustomContextMenuAttribute`

CustomContextMenu is used on any property, and adds a custom options to the context menu for the property.

Use this for when you want to add custom actions to the context menu of a property.

**Remarks.** > **Note:** CustomContextMenu currently does not support static functions.

**Examples**

The following example shows how CustomContextMenu is used to add a custom option to a property.

```csharp
public class MyComponent : MonoBehaviour
{
    [CustomContextMenu("My custom option", "MyAction")]
    public Vector3 MyVector;

    private void MyAction()
    {
        MyVector = Random.onUnitSphere;
    }
}
```

**Constructors**

- `CustomContextMenuAttribute(string, string)`
  - `menuItem` — A resolved string defining the name of the menu item.
  - `action` — A resolved string defining the action to take when the context menu is clicked.

**Fields / properties**

- `MenuItem` — A resolved string defining the name of the menu item.
- `MethodName` — The name of the callback method. Obsolete; use the Action member instead.
- `Action` — A resolved string defining the action to take when the context menu is clicked.

### `CustomValueDrawerAttribute`

*Full name:* `Sirenix.OdinInspector.CustomValueDrawerAttribute`

Instead of making a new attribute, and a new drawer, for a one-time thing, you can with this attribute, make a method that acts as a custom property drawer. These drawers will out of the box have support for undo/redo and multi-selection.

**Examples**

Usage:

```csharp
public class CustomDrawerExamples : MonoBehaviour
{
    public float From = 2, To = 7;

    [CustomValueDrawer("MyStaticCustomDrawerStatic")]
    public float CustomDrawerStatic;

    [CustomValueDrawer("MyStaticCustomDrawerInstance")]
    public float CustomDrawerInstance;

    [CustomValueDrawer("MyStaticCustomDrawerArray")]
    public float[] CustomDrawerArray;

#if UNITY_EDITOR

    private static float MyStaticCustomDrawerStatic(float value, GUIContent label)
    {
        return EditorGUILayout.Slider(value, 0f, 10f);
    }

    private float MyStaticCustomDrawerInstance(float value, GUIContent label)
    {
        return EditorGUILayout.Slider(value, this.From, this.To);
    }

    private float MyStaticCustomDrawerArray(float value, GUIContent label)
    {
        return EditorGUILayout.Slider(value, this.From, this.To);
    }

#endif
}
```

**Constructors**

- `CustomValueDrawerAttribute(string)`
  - `action` — A resolved string that defines the custom drawer action to take, such as an expression or method invocation.

**Fields / properties**

- `MethodName` — Name of the custom drawer method. Obsolete; use the Action member instead.
- `Action` — A resolved string that defines the custom drawer action to take, such as an expression or method invocation.

### `DelayedPropertyAttribute`

*Full name:* `Sirenix.OdinInspector.DelayedPropertyAttribute`

Delays applying changes to properties while they still being edited in the inspector. Similar to Unity's built-in Delayed attribute, but this attribute can also be applied to properties.

### `DetailedInfoBoxAttribute`

*Full name:* `Sirenix.OdinInspector.DetailedInfoBoxAttribute`

DetailedInfoBox is used on any property, and displays a message box that can be expanded to show more details.

Use this to convey a message to a user, and give them the option to see more details.

**Examples**

The following example shows how DetailedInfoBox is used on a field.

```csharp
public class MyComponent : MonoBehaviour
{
    [DetailedInfoBox("This is a message", "Here is some more details about that message")]
    public int MyInt;
}
```

**Constructors**

- `DetailedInfoBoxAttribute(string, string, InfoMessageType, string)`
  - `message` — The message for the message box.
  - `details` — The hideable details of the message box.
  - `infoMessageType` — Type of the message box.
  - `visibleIf` — Optional name of a member to hide or show the message box.

**Fields / properties**

- `Message` — The message for the message box.
- `Details` — The hideable details of the message box.
- `InfoMessageType` — Type of the message box.
- `VisibleIf` — Optional name of a member to hide or show the message box.

### `DisableContextMenuAttribute`

*Full name:* `Sirenix.OdinInspector.DisableContextMenuAttribute`

DisableContextMenu is used on any property and disables the context menu for that property.

Use this if you do not want the context menu to be available for a property.

**Examples**

The following example shows how DisableContextMenu is used on a property.

```csharp
public class MyComponent : MonoBehaviour
{
    [DisableContextMenu]
    public Vector3 MyVector;
}
```

**Constructors**

- `DisableContextMenuAttribute(bool, bool)`
  - `disableForMember` — Whether to disable the context menu for the member itself.
  - `disableCollectionElements` — Whether to also disable the context menu of collection elements.

**Fields / properties**

- `DisableForMember` — Whether to disable the context menu for the member itself.
- `DisableForCollectionElements` — Whether to disable the context menu for collection elements.

### `DisableIfAttribute`

*Full name:* `Sirenix.OdinInspector.DisableIfAttribute`

DisableIf is used on any property, and can disable or enable the property in the inspector.

Use this to disable properties when they are irrelevant.

**Examples**

The following example shows how a property can be disabled by the state of a field.

```csharp
public class MyComponent : MonoBehaviour
{
       public bool DisableProperty;

       [DisableIf("DisableProperty")]
       public int MyInt;

       public SomeEnum SomeEnumField;

       [DisableIf("SomeEnumField", SomeEnum.SomeEnumMember)]
       public string SomeString;
}
```

The following examples show how a property can be disabled by a function.

```csharp
public class MyComponent : MonoBehaviour
{
       [EnableIf("MyDisableFunction")]
       public int MyInt;

       private bool MyDisableFunction()
       {
           // ...
       }
}
```

**Constructors**

- `DisableIfAttribute(string)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `DisableIfAttribute(string, object)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `optionalValue` — Value to check against.

**Fields / properties**

- `MemberName` — The name of a bool member field, property or method. Obsolete; use the Condition member instead.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `Value` — The optional condition value.

### `DisableInAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInAttribute`

Disables a member based on which type of a prefab and instance it is in.

### `DisableInEditorModeAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInEditorModeAttribute`

DisableInEditorMode is used on any property, and disables the property when not in play mode.

Use this when you only want a property to be editable when in play mode.

**Examples**

The following example shows how DisableInEditorMode is used to disable a property when in the editor.

```csharp
public class MyComponent : MonoBehaviour
{
    [DisableInEditorMode]
    public int MyInt;
}
```

### `DisableInInlineEditorsAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInInlineEditorsAttribute`

Disables a property if it is drawn within an `InlineEditorAttribute`.

### `DisableInNonPrefabsAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInNonPrefabsAttribute`

Disables a property if it is drawn from a non-prefab asset or instance.

### `DisableInPlayModeAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInPlayModeAttribute`

DisableInPlayMode is used on any property, and disables the property when in play mode.

Use this to prevent users from editing a property when in play mode.

**Examples**

The following example shows how DisableInPlayMode is used to disable a property when in play mode.

```csharp
public class MyComponent : MonoBehaviour
{
    [DisableInPlayMode]
    public int MyInt;
}
```

### `DisableInPrefabAssetsAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInPrefabAssetsAttribute`

Disables a property if it is drawn from a prefab asset.

### `DisableInPrefabInstancesAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInPrefabInstancesAttribute`

Disables a property if it is drawn from a prefab instance.

### `DisableInPrefabsAttribute`

*Full name:* `Sirenix.OdinInspector.DisableInPrefabsAttribute`

Disables a property if it is drawn from a prefab asset or a prefab instance.

### `DisallowModificationsInAttribute`

*Full name:* `Sirenix.OdinInspector.DisallowModificationsInAttribute`

DisallowModificationsIn disables / grays out members, preventing modifications from being made and enables validation, providing error messages in case a modification was made prior to introducing the attribute.

### `DisplayAsStringAttribute`

*Full name:* `Sirenix.OdinInspector.DisplayAsStringAttribute`

DisplayAsString is used on any property, and displays a string in the inspector as text.

Use this for when you want to show a string in the inspector, but not allow for any editing.

**Remarks.** DisplayAsString uses the property's ToString method to display the property as a string.

**Examples**

The following example shows how DisplayAsString is used to display a string property as text in the inspector.

```csharp
public class MyComponent : MonoBehaviour
   {
       [DisplayAsString]
       public string MyInt = 5;

       // You can combine with
```

**Constructors**

- `DisplayAsStringAttribute()`
- `DisplayAsStringAttribute(bool)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
- `DisplayAsStringAttribute(TextAlignment)`
  - `alignment` — How the string should be aligned.
- `DisplayAsStringAttribute(int)`
  - `fontSize` — The size of the font.
- `DisplayAsStringAttribute(bool, TextAlignment)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `alignment` — How the string should be aligned.
- `DisplayAsStringAttribute(bool, int)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `fontSize` — The size of the font.
- `DisplayAsStringAttribute(int, TextAlignment)`
  - `fontSize` — The size of the font.
  - `alignment` — How the string should be aligned.
- `DisplayAsStringAttribute(bool, int, TextAlignment)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `fontSize` — The size of the font.
  - `alignment` — How the string should be aligned.
- `DisplayAsStringAttribute(TextAlignment, bool)`
  - `alignment` — How the string should be aligned.
  - `enableRichText` — If `true` the string will support rich text.
- `DisplayAsStringAttribute(int, bool)`
  - `fontSize` — The size of the font.
  - `enableRichText` — If `true` the string will support rich text.
- `DisplayAsStringAttribute(bool, TextAlignment, bool)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `alignment` — How the string should be aligned.
  - `enableRichText` — If `true` the string will support rich text.
- `DisplayAsStringAttribute(bool, int, bool)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `fontSize` — The size of the font.
  - `enableRichText` — If `true` the string will support rich text.
- `DisplayAsStringAttribute(int, TextAlignment, bool)`
  - `fontSize` — The size of the font.
  - `alignment` — How the string should be aligned.
  - `enableRichText` — If `true` the string will support rich text.
- `DisplayAsStringAttribute(bool, int, TextAlignment, bool)`
  - `overflow` — Value indicating if the string should overflow past the available space, or expand to multiple lines when there's not enough horizontal space.
  - `fontSize` — The size of the font.
  - `alignment` — How the string should be aligned.
  - `enableRichText` — If `true` the string will support rich text.

**Fields / properties**

- `Overflow` — If `true`, the string will overflow past the drawn space and be clipped when there's not enough space for the text. If `false` the string will expand to multiple lines, if there's not enough space when drawn.
- `Alignment` — How the string should be aligned.
- `FontSize` — The size of the font.
- `EnableRichText` — If `true` the string will support rich text.
- `Format` — String for formatting the value. Type must implement the `IFormattable` interface.

### `DoNotDrawAsReferenceAttribute`

*Full name:* `Sirenix.OdinInspector.DoNotDrawAsReferenceAttribute`

Indicates that the member should not be drawn as a value reference, if it becomes a reference to another value in the tree. Beware, and use with care! This may lead to infinite draw loops!

### `DontApplyToListElementsAttribute`

*Full name:* `Sirenix.OdinInspector.DontApplyToListElementsAttribute`

DontApplyToListElements is used on other attributes, and indicates that those attributes should be applied only to the list, and not to the elements of the list.

Use this on attributes that should only work on a list or array property as a whole, and not on each element of the list.

**Examples**

The following example shows how DontApplyToListElements is used on `ShowIfAttribute`.

```csharp
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class VisibleIfAttribute : Attribute
{
    public string MemberName { get; private set; }

    public VisibleIfAttribute(string memberName)
    {
        this.MemberName = memberName;
    }
}
```

### `DontValidateAttribute`

*Full name:* `Sirenix.OdinInspector.DontValidateAttribute`

Tells the validation system that this member should not be validated. It will not show validation messages in the inspector, and it will not be scanned by the project validator.

### `DrawWithUnityAttribute`

*Full name:* `Sirenix.OdinInspector.DrawWithUnityAttribute`

DrawWithUnity can be applied to a field or property to make Odin draw it using Unity's old drawing system. Use it if you want to selectively disable Odin drawing for a particular member.

**Remarks.** Note that this attribute does not mean "disable Odin completely for this property"; it is visual only in nature, and in fact represents an Odin drawer which calls into Unity's old property drawing system. As Odin is still ultimately responsible for arranging the drawing of the property, and since other attributes exist with a higher priority than this attribute, and it is not guaranteed that Unity will draw the property if another attribute is present to override this one.

### `DrawWithVisualElementsAttribute`

*Full name:* `Sirenix.OdinInspector.DrawWithVisualElementsAttribute`

Force Odin to draw this value as an IMGUI-embedded UI Toolkit Visual Element.

### `EnableGUIAttribute`

*Full name:* `Sirenix.OdinInspector.EnableGUIAttribute`

An attribute that enables GUI.

**Examples**

```csharp
public class InlineEditorExamples : MonoBehaviour
{
    [EnableGUI]
    public string SomeReadonlyProperty { get { return "My GUI is usually disabled." } }
}
```

### `EnableIfAttribute`

*Full name:* `Sirenix.OdinInspector.EnableIfAttribute`

EnableIf is used on any property, and can enable or disable the property in the inspector.

Use this to enable properties when they are relevant.

**Examples**

The following example shows how a property can be enabled by the state of a field.

```csharp
public class MyComponent : MonoBehaviour
{
       public bool EnableProperty;

       [EnableIf("EnableProperty")]
       public int MyInt;

       public SomeEnum SomeEnumField;

       [EnableIf("SomeEnumField", SomeEnum.SomeEnumMember)]
       public string SomeString;
}
```

The following examples show how a property can be enabled by a function.

```csharp
public class MyComponent : MonoBehaviour
{
       [EnableIf("MyEnableFunction")]
       public int MyInt;

       private bool MyEnableFunction()
       {
           // ...
       }
}
```

**Constructors**

- `EnableIfAttribute(string)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `EnableIfAttribute(string, object)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `optionalValue` — Value to check against.

**Fields / properties**

- `MemberName` — The name of a bool member field, property or method. Obsolete; use the Condition member instead.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `Value` — The optional condition value.

### `EnableInAttribute`

*Full name:* `Sirenix.OdinInspector.EnableInAttribute`

Enables a member based on which type of a prefab and instance it is.

### `EnumPagingAttribute`

*Full name:* `Sirenix.OdinInspector.EnumPagingAttribute`

Draws an enum selector in the inspector with next and previous buttons to let you cycle through the available values for the enum property.

**Examples**

```csharp
public enum MyEnum
{
    One,
    Two,
    Three,
}

public class MyMonoBehaviour : MonoBehaviour
{
    [EnumPaging]
    public MyEnum Value;
}
```

### `EnumToggleButtonsAttribute`

*Full name:* `Sirenix.OdinInspector.EnumToggleButtonsAttribute`

Draws an enum in a horizontal button group instead of a dropdown.

**Examples**

```csharp
public class MyComponent : MonoBehvaiour
{
    [EnumToggleButtons]
    public MyBitmaskEnum MyBitmaskEnum;

    [EnumToggleButtons]
    public MyEnum MyEnum;
}

[Flags]
public enum MyBitmaskEnum
{
    A = 1 << 1, // 1
    B = 1 << 2, // 2
    C = 1 << 3, // 4
    ALL = A | B | C
}

public enum MyEnum
{
    A,
    B,
    C
}
```

### `FilePathAttribute`

*Full name:* `Sirenix.OdinInspector.FilePathAttribute`

FilePath is used on string properties, and provides an interface for file paths.

**Examples**

The following example demonstrates how FilePath is used.

```csharp
public class FilePathExamples : MonoBehaviour
{
    // By default, FilePath provides a path relative to the Unity project.
    [FilePath]
    public string UnityProjectPath;

    // It is possible to provide custom parent path. Parent paths can be relative to the Unity project, or absolute.
    [FilePath(ParentFolder = "Assets/Plugins/Sirenix")]
    public string RelativeToParentPath;

    // Using parent path, FilePath can also provide a path relative to a resources folder.
    [FilePath(ParentFolder = "Assets/Resources")]
    public string ResourcePath;

    // Provide a comma seperated list of allowed extensions. Dots are optional.
    [FilePath(Extensions = "cs")]
    public string ScriptFiles;

    // By setting AbsolutePath to true, the FilePath will provide an absolute path instead.
    [FilePath(AbsolutePath = true)]
    [BoxGroup("Conditions")]
    public string AbsolutePath;

    // FilePath can also be configured to show an error, if the provided path is invalid.
    [FilePath(RequireValidPath = true)]
    public string ValidPath;

    // By default, FilePath will enforce the use of forward slashes. It can also be configured to use backslashes instead.
    [FilePath(UseBackslashes = true)]
    public string Backslashes;

    // FilePath also supports member references with the $ symbol.
    [FilePath(ParentFolder = "$DynamicParent", Extensions = "$DynamicExtensions")]
    public string DynamicFilePath;

    public string DynamicParent = "Assets/Plugin/Sirenix";

    public string DynamicExtensions = "cs, unity, jpg";
}
```

**Fields / properties**

- `AbsolutePath` — If `true` the FilePath will provide an absolute path, instead of a relative one.
- `Extensions` — Comma separated list of allowed file extensions. Dots are optional. Supports member referencing with $.
- `ParentFolder` — ParentFolder provides an override for where the path is relative to. ParentFolder can be relative to the Unity project, or an absolute path. Supports member referencing with $.
- `RequireValidPath` — If `true` an error will be displayed for invalid, or missing paths.
- `RequireExistingPath` — If `true` an error will be displayed for non-existing paths.
- `UseBackslashes` — By default FilePath enforces forward slashes. Set UseBackslashes to `true` if you want backslashes instead.
- `IncludeFileExtension` — If `true` the file path will include the file's extension.
- `ReadOnly` — Gets or sets a value indicating whether the path should be read only.

### `FolderPathAttribute`

*Full name:* `Sirenix.OdinInspector.FolderPathAttribute`

FolderPath is used on string properties, and provides an interface for directory paths.

**Examples**

The following example demonstrates how FolderPath is used.

```csharp
public class FolderPathExamples : MonoBehaviour
{
    // By default, FolderPath provides a path relative to the Unity project.
    [FolderPath]
    public string UnityProjectPath;

    // It is possible to provide custom parent patn. ParentFolder paths can be relative to the Unity project, or absolute.
    [FolderPath(ParentFolder = "Assets/Plugins/Sirenix")]
    public string RelativeToParentPath;

    // Using ParentFolder, FolderPath can also provide a path relative to a resources folder.
    [FolderPath(ParentFolder = "Assets/Resources")]
    public string ResourcePath;

    // By setting AbsolutePath to true, the FolderPath will provide an absolute path instead.
    [FolderPath(AbsolutePath = true)]
    public string AbsolutePath;

    // FolderPath can also be configured to show an error, if the provided path is invalid.
    [FolderPath(RequireValidPath = true)]
    public string ValidPath;

    // By default, FolderPath will enforce the use of forward slashes. It can also be configured to use backslashes instead.
    [FolderPath(UseBackslashes = true)]
    public string Backslashes;

    // FolderPath also supports member references with the $ symbol.
    [FolderPath(ParentFolder = "$DynamicParent")]
    public string DynamicFolderPath;

    public string DynamicParent = "Assets/Plugins/Sirenix";
}
```

**Fields / properties**

- `AbsolutePath` — If `true` the FolderPath will provide an absolute path, instead of a relative one.
- `ParentFolder` — ParentFolder provides an override for where the path is relative to. ParentFolder can be relative to the Unity project, or an absolute path. Supports member referencing with $.
- `RequireValidPath` — If `true` an error will be displayed for invalid, or missing paths.
- `RequireExistingPath` — If `true` an error will be displayed for non-existing paths.
- `UseBackslashes` — By default FolderPath enforces forward slashes. Set UseBackslashes to `true` if you want backslashes instead.

### `FoldoutGroupAttribute`

*Full name:* `Sirenix.OdinInspector.FoldoutGroupAttribute`

FoldoutGroup is used on any property, and organizes properties into a foldout.

Use this to organize properties, and to allow the user to hide properties that are not relevant for them at the moment.

**Examples**

The following example shows how FoldoutGroup is used to organize properties into a foldout.

```csharp
public class MyComponent : MonoBehaviour
   {
       [FoldoutGroup("MyGroup")]
       public int A;

       [FoldoutGroup("MyGroup")]
       public int B;

       [FoldoutGroup("MyGroup")]
       public int C;
   }
```

The following example shows how properties can be organizes into multiple foldouts.

```csharp
public class MyComponent : MonoBehaviour
   {
       [FoldoutGroup("First")]
       public int A;

       [FoldoutGroup("First")]
       public int B;

       [FoldoutGroup("Second")]
       public int C;
   }
```

**Constructors**

- `FoldoutGroupAttribute(string, float)`
  - `groupName` — Name of the foldout group.
  - `order` — The order of the group in the inspector.
- `FoldoutGroupAttribute(string, bool, float)`
  - `groupName` — Name of the foldout group.
  - `expanded` — Whether or not the foldout should be expanded by default.
  - `order` — The order of the group in the inspector.

**Fields / properties**

- `Expanded` — Gets a value indicating whether or not the foldout should be expanded by default.
- `HasDefinedExpanded` — Gets a value indicating whether or not the Expanded property has been set.

### `GUIColorAttribute`

*Full name:* `Sirenix.OdinInspector.GUIColorAttribute`

GUIColor is used on any property and changes the GUI color used to draw the property.

**Examples**

The following example shows how GUIColor is used on a properties to create a rainbow effect.

```csharp
public class MyComponent : MonoBehaviour
{
    [GUIColor(1f, 0f, 0f)]
    public int A;

    [GUIColor(1f, 0.5f, 0f, 0.2f)]
    public int B;

    [GUIColor("GetColor")]
    public int C;

    private Color GetColor() { return this.A == 0 ? Color.red : Color.white; }
}
```

**Constructors**

- `GUIColorAttribute(float, float, float, float)`
  - `r` — The red channel.
  - `g` — The green channel.
  - `b` — The blue channel.
  - `a` — The alpha channel.
- `GUIColorAttribute(string)`
  - `getColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor").

**Fields / properties**

- `Color` — The GUI color of the property.
- `GetColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.

### `HideDuplicateReferenceBoxAttribute`

*Full name:* `Sirenix.OdinInspector.HideDuplicateReferenceBoxAttribute`

Indicates that Odin should hide the reference box, if this property would otherwise be drawn as a reference to another property, due to duplicate reference values being encountered. Note that if the value is referencing itself recursively, then the reference box will be drawn regardless of this attribute in all recursive draw calls.

### `HideIfAttribute`

*Full name:* `Sirenix.OdinInspector.HideIfAttribute`

HideIf is used on any property and can hide the property in the inspector.

Use this to hide irrelevant properties based on the current state of the object.

**Examples**

This example shows a component with fields hidden by the state of another field.

```csharp
public class MyComponent : MonoBehaviour
{
       public bool HideProperties;

       [HideIf("HideProperties")]
       public int MyInt;

       [HideIf("HideProperties", false)]
       public string MyString;

       public SomeEnum SomeEnumField;

       [HideIf("SomeEnumField", SomeEnum.SomeEnumMember)]
       public string SomeString;
}
```

This example shows a component with a field that is hidden when the game object is inactive.

```csharp
public class MyComponent : MonoBehaviour
{
       [HideIf("MyVisibleFunction")]
       public int MyHideableField;

       private bool MyVisibleFunction()
       {
           return !this.gameObject.activeInHierarchy;
       }
}
```

**Constructors**

- `HideIfAttribute(string, bool)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `animate` — Whether or not to slide the property in and out when the state changes.
- `HideIfAttribute(string, object, bool)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `optionalValue` — Value to check against.
  - `animate` — Whether or not to slide the property in and out when the state changes.

**Fields / properties**

- `MemberName` — The name of a bool member field, property or method. Obsolete; use the Condition member instead.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `Value` — The optional condition value.
- `Animate` — Whether or not to slide the property in and out when the state changes.

### `HideIfGroupAttribute`

*Full name:* `Sirenix.OdinInspector.HideIfGroupAttribute`

HideIfGroup allows for showing or hiding a group of properties based on a condition. The attribute is a group attribute and can therefore be combined with other group attributes, and even be used to show or hide entire groups. Note that in the vast majority of cases where you simply want to be able to control the visibility of a single group, it is better to use the VisibleIf parameter that *all* group attributes have.

**Constructors**

- `HideIfGroupAttribute(string, bool)`
  - `path` — The group path.
  - `animate` — If `true` then a fade animation will be played when the group is hidden or shown.
- `HideIfGroupAttribute(string, object, bool)`
  - `path` — The group path.
  - `value` — The value the member should equal for the property to shown.
  - `animate` — If `true` then a fade animation will be played when the group is hidden or shown.

**Fields / properties**

- `Animate` — Whether or not to visually animate group visibility changes.
- `Value` — The optional member value.
- `MemberName` — Name of member to use when to hide the group. Defaults to the name of the group, by can be overriden by setting this property.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.

### `HideInAttribute`

*Full name:* `Sirenix.OdinInspector.HideInAttribute`

Hides a member based on which type of a prefab and instance it is in.

### `HideInEditorModeAttribute`

*Full name:* `Sirenix.OdinInspector.HideInEditorModeAttribute`

HideInEditorMode is used on any property, and hides the property when not in play mode.

Use this when you only want a property to only be visible play mode.

**Examples**

The following example shows how HideInEditorMode is used to hide a property when in the editor.

```csharp
public class MyComponent : MonoBehaviour
{
    [HideInEditorMode]
    public int MyInt;
}
```

### `HideInInlineEditorsAttribute`

*Full name:* `Sirenix.OdinInspector.HideInInlineEditorsAttribute`

Hides a property if it is drawn within an `InlineEditorAttribute`.

### `HideInNonPrefabsAttribute`

*Full name:* `Sirenix.OdinInspector.HideInNonPrefabsAttribute`

Hides a property if it is drawn from a non prefab instance or asset.

### `HideInPlayModeAttribute`

*Full name:* `Sirenix.OdinInspector.HideInPlayModeAttribute`

HideInPlayMode is used on any property, and hides the property when not in editor mode.

Use this when you only want a property to only be visible the editor.

**Examples**

The following example shows how HideInPlayMode is used to hide a property when in play mode.

```csharp
public class MyComponent : MonoBehaviour
{
    [HideInPlayMode]
    public int MyInt;
}
```

### `HideInPrefabAssetsAttribute`

*Full name:* `Sirenix.OdinInspector.HideInPrefabAssetsAttribute`

Hides a property if it is drawn from a prefab asset.

### `HideInPrefabInstancesAttribute`

*Full name:* `Sirenix.OdinInspector.HideInPrefabInstancesAttribute`

Hides a property if it is drawn from a prefab instance.

### `HideInPrefabsAttribute`

*Full name:* `Sirenix.OdinInspector.HideInPrefabsAttribute`

Hides a property if it is drawn from a prefab instance or a prefab asset.

### `HideInTablesAttribute`

*Full name:* `Sirenix.OdinInspector.HideInTablesAttribute`

The HideInTables attribute is used to prevent members from showing up as columns in tables drawn using the `TableListAttribute`.

### `HideLabelAttribute`

*Full name:* `Sirenix.OdinInspector.HideLabelAttribute`

HideLabel is used on any property, and hides the label in the inspector.

Use this to hide the label of properties in the inspector.

**Examples**

The following example show how HideLabel is used to hide the label of a game object property.

```csharp
public class MyComponent : MonoBehaviour
{
    [HideLabel]
    public GameObject MyGameObjectWithoutLabel;
}
```

### `HideMonoScriptAttribute`

*Full name:* `Sirenix.OdinInspector.HideMonoScriptAttribute`

Apply HideMonoScript to your class to prevent the Script property from being shown in the inspector.

This attribute has the same effect on a single type that the global configuration option "Show Mono Script In Editor" in "Preferences -> Odin Inspector -> General -> Drawers" has globally when disabled.

**Examples**

The following example shows how to use this attribute.

```csharp
[HideMonoScript]
public class MyComponent : MonoBehaviour
{
    // The Script property will not be shown for this component in the inspector
}
```

### `HideNetworkBehaviourFieldsAttribute`

*Full name:* `Sirenix.OdinInspector.HideNetworkBehaviourFieldsAttribute`

Apply HideNetworkBehaviourFields to your class to prevent the special "Network Channel" and "Network Send Interval" properties from being shown in the inspector for a NetworkBehaviour. This attribute has no effect on classes that are not derived from NetworkBehaviour.

**Examples**

The following example shows how to use this attribute.

```csharp
[HideNetworkBehaviourFields]
public class MyComponent : NetworkBehaviour
{
    // The "Network Channel" and "Network Send Interval" properties will not be shown for this component in the inspector
}
```

### `HideReferenceObjectPickerAttribute`

*Full name:* `Sirenix.OdinInspector.HideReferenceObjectPickerAttribute`

Hides the polymorphic object-picker shown above the properties of non-Unity serialized reference types.

**Remarks.** When the object picker is hidden, you can right click and set the instance to null, in order to set a new value. If you don't want this behavior, you can use `!:DisableContextMenu` attribute to ensure people can't change the value.

**Examples**

```csharp
public class MyComponent : SerializedMonoBehaviour
{
    [Header("Hidden Object Pickers")]
    [Indent]
    [HideReferenceObjectPicker]
    public MyCustomReferenceType OdinSerializedProperty1;

    [Indent]
    [HideReferenceObjectPicker]
    public MyCustomReferenceType OdinSerializedProperty2;

    [Indent]
    [Header("Shown Object Pickers")]
    public MyCustomReferenceType OdinSerializedProperty3;

    [Indent]
    public MyCustomReferenceType OdinSerializedProperty4;

    public class MyCustomReferenceType
    {
        public int A;
        public int B;
        public int C;
    }
}
```

### `HorizontalGroupAttribute`

*Full name:* `Sirenix.OdinInspector.HorizontalGroupAttribute`

HorizontalGroup is used group multiple properties horizontally in the inspector.

The width can either be specified as percentage or pixels.

All values between 0 and 1 will be treated as a percentage.

If the width is 0 the column will be automatically sized.

Margin-left and right can only be specified in pixels.

**Examples**

The following example shows how three properties have been grouped together horizontally.

```csharp
// The width can either be specified as percentage or pixels.
// All values between 0 and 1 will be treated as a percentage.
// If the width is 0 the column will be automatically sized.
// Margin-left and right can only be specified in pixels.

public class HorizontalGroupAttributeExamples : MonoBehaviour
{
    [HorizontalGroup]
    public int A;

    [HideLabel, LabelWidth (150)]
    [HorizontalGroup(150)]
    public LayerMask B;

    // LabelWidth can be helpfull when dealing with HorizontalGroups.
    [HorizontalGroup("Group 1"), LabelWidth(15)]
    public int C;

    [HorizontalGroup("Group 1"), LabelWidth(15)]
    public int D;

    [HorizontalGroup("Group 1"), LabelWidth(15)]
    public int E;

    // Having multiple properties in a column can be achived using multiple groups. Checkout the "Combining Group Attributes" example.
    [HorizontalGroup("Split", 0.5f, PaddingRight = 15)]
    [BoxGroup("Split/Left"), LabelWidth(15)]
    public int L;

    [BoxGroup("Split/Right"), LabelWidth(15)]
    public int M;

    [BoxGroup("Split/Left"), LabelWidth(15)]
    public int N;

    [BoxGroup("Split/Right"), LabelWidth(15)]
    public int O;

    // Horizontal Group also has supprot for: Title, MarginLeft, MarginRight, PaddingLeft, PaddingRight, MinWidth and MaxWidth.
    [HorizontalGroup("MyButton", MarginLeft = 0.25f, MarginRight = 0.25f)]
    public void SomeButton()
    {

    }
}
```

**Constructors**

- `HorizontalGroupAttribute(string, float, int, int, float)`
  - `group` — The group for the property.
  - `width` — The width of the property. Values between 0 and 1 are interpolated as a percentage, otherwise pixels.
  - `marginLeft` — The left margin in pixels.
  - `marginRight` — The right margin in pixels.
  - `order` — The order of the group in the inspector.
- `HorizontalGroupAttribute(float, int, int, float)`
  - `width` — The width of the property. Values between 0 and 1 are interpolated as a percentage, otherwise pixels.
  - `marginLeft` — The left margin in pixels.
  - `marginRight` — The right margin in pixels.
  - `order` — The order of the group in the inspector.

**Fields / properties**

- `Width` — The width. Values between 0 and 1 will be treated as percentage, 0 = auto, otherwise pixels.
- `MarginLeft` — The margin left. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `MarginRight` — The margin right. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `PaddingLeft` — The padding left. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `PaddingRight` — The padding right. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `MinWidth` — The minimum Width. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `MaxWidth` — The maximum Width. Values between 0 and 1 will be treated as percentage, 0 = ignore, otherwise pixels.
- `Gap` — The width between each column. Values between 0 and 1 will be treated as percentage, otherwise pixels.
- `Title` — Adds a title above the horizontal group.
- `DisableAutomaticLabelWidth` — Fallback to using the default label width, whatever that might be.
- `LabelWidth` — The label width, 0 = auto.

### `ImageAttribute`

*Full name:* `Sirenix.OdinInspector.ImageAttribute`

Draws an image directly in the inspector.

**Examples**

The following example shows how Image is applied to draw images directly in the inspector.

```csharp
[Image("Banner", 96)]
public class MyComponent : MonoBehaviour
{
    [Image(128, DrawProperty = false)]
    public Texture2D Banner;

    [Image("Icon", 64)]
    public string Text;

    public Sprite Icon;
}
```

**Constructors**

- `ImageAttribute()`
- `ImageAttribute(float)`
  - `height` — The height of the image.
- `ImageAttribute(float, ImageScaleMode)`
  - `height` — The height of the image.
  - `scaleMode` — The scale mode used when drawing the image.
- `ImageAttribute(float, float)`
  - `width` — The width of the image.
  - `height` — The height of the image.
- `ImageAttribute(float, float, ImageScaleMode)`
  - `width` — The width of the image.
  - `height` — The height of the image.
  - `scaleMode` — The scale mode used when drawing the image.
- `ImageAttribute(string)`
  - `imageSource` — A resolved value that should resolve to the image object to draw.
- `ImageAttribute(string, float)`
  - `imageSource` — A resolved value that should resolve to the image object to draw.
  - `height` — The height of the image.
- `ImageAttribute(string, float, ImageScaleMode)`
  - `imageSource` — A resolved value that should resolve to the image object to draw.
  - `height` — The height of the image.
  - `scaleMode` — The scale mode used when drawing the image.
- `ImageAttribute(string, float, float)`
  - `imageSource` — A resolved value that should resolve to the image object to draw.
  - `width` — The width of the image.
  - `height` — The height of the image.
- `ImageAttribute(string, float, float, ImageScaleMode)`
  - `imageSource` — A resolved value that should resolve to the image object to draw.
  - `width` — The width of the image.
  - `height` — The height of the image.
  - `scaleMode` — The scale mode used when drawing the image.

**Fields / properties**

- `Width` — The width of the image. Set to 0 to use the image's natural width.
- `Height` — The height of the image. Set to 0 to use the image's natural height.
- `FitToAvailableWidth` — Whether the image should fit to the normal inspector layout width when Width and Height are both 0.
- `Alignment` — Horizontal alignment of the image inside the available preview area. 0 is left, 0.5 is center, and 1 is right.
- `ScaleMode` — The scale mode used when drawing the image.
- `FilterMode` — The filter mode to use while drawing the image.
- `AlphaBlend` — Whether the image should be drawn with alpha blending.
- `DrawProperty` — Whether the property itself should be drawn after the image.
- `DrawPosition` — Whether the image should be drawn before or after the original property.
- `IgnorePadding` — Whether the image should ignore the current layout padding and indentation.
- `ImageSource` — A resolved value that should resolve to the image object to draw.
- `ImageSourceHasValue` — Whether an image source value is specified.

### `IncludeMyAttributesAttribute`

*Full name:* `Sirenix.OdinInspector.IncludeMyAttributesAttribute`

When this attribute is added is added to another attribute, then attributes from that attribute will also be added to the property in the attribute processing step.

### `IndentAttribute`

*Full name:* `Sirenix.OdinInspector.IndentAttribute`

Indent is used on any property and moves the property's label to the right.

Use this to clearly organize properties in the inspector.

**Examples**

The following example shows how a property is indented by Indent.

```csharp
public class MyComponent : MonoBehaviour
{
    [Indent]
    public int IndentedInt;
}
```

**Constructors**

- `IndentAttribute(int)`
  - `indentLevel` — How much a property should be indented.

**Fields / properties**

- `IndentLevel` — Indicates how much a property should be indented.

### `InfoBoxAttribute`

*Full name:* `Sirenix.OdinInspector.InfoBoxAttribute`

InfoBox is used on any property, and display a text box above the property in the inspector.

Use this to add comments or warn about the use of different properties.

**Examples**

The following example shows different info box types.

```csharp
public class MyComponent : MonoBehaviour
{
    [InfoBox("This is an int property")]
    public int MyInt;

    [InfoBox("This info box is a warning", InfoMessageType.Warning)]
    public float MyFloat;

    [InfoBox("This info box is an error", InfoMessageType.Error)]
    public object MyObject;

 [InfoBox("This info box is just a box", InfoMessageType.None)]
    public Vector3 MyVector;
}
```

The following example how info boxes can be hidden by fields and properties.

```csharp
public class MyComponent : MonoBehaviour
{
       [InfoBox("This info box is hidden by an instance field.", "InstanceShowInfoBoxField")]
       public int MyInt;
       public bool InstanceShowInfoBoxField;

       [InfoBox("This info box is hideable by a static field.", "StaticShowInfoBoxField")]
       public float MyFloat;
       public static bool StaticShowInfoBoxField;

       [InfoBox("This info box is hidden by an instance property.", "InstanceShowInfoBoxProperty")]
       public int MyOtherInt;
    public bool InstanceShowInfoBoxProperty { get; set; }

       [InfoBox("This info box is hideable by a static property.", "StaticShowInfoBoxProperty")]
       public float MyOtherFloat;
       public static bool StaticShowInfoBoxProperty { get; set; }
}
```

The following example shows how info boxes can be hidden by functions.

```csharp
public class MyComponent : MonoBehaviour
{
    [InfoBox("This info box is hidden by an instance function.", "InstanceShowFunction")]
    public int MyInt;
    public bool InstanceShowFunction()
    {
        return this.MyInt == 0;
    }

    [InfoBox("This info box is hidden by a static function.", "StaticShowFunction")]
    public short MyShort;
    public bool StaticShowFunction()
    {
        return true;
    }

    // You can also specify a function with the same type of parameter.
    // Use this to specify the same function, for multiple different properties.
    [InfoBox("This info box is hidden by an instance function with a parameter.", "InstanceShowParameterFunction")]
    public GameObject MyGameObject;
    public bool InstanceShowParameterFunction(GameObject property)
    {
        return property != null;
    }

    [InfoBox("This info box is hidden by a static function with a parameter.", "StaticShowParameterFunction")]
    public Vector3 MyVector;
    public bool StaticShowParameterFunction(Vector3 property)
    {
        return property.magnitude == 0f;
    }
}
```

**Constructors**

- `InfoBoxAttribute(string, InfoMessageType, string)`
  - `message` — The message for the message box. Supports referencing a member string field, property or method by using $.
  - `infoMessageType` — The type of the message box.
  - `visibleIfMemberName` — Name of member bool to show or hide the message box.
- `InfoBoxAttribute(string, string)`
  - `message` — The message for the message box. Supports referencing a member string field, property or method by using $.
  - `visibleIfMemberName` — Name of member bool to show or hide the message box.
- `InfoBoxAttribute(string, SdfIconType, string)`
  - `message` — The message for the message box. Supports referencing a member string field, property or method by using $.
  - `icon` — The icon to be displayed next to the message.
  - `visibleIfMemberName` — Name of member bool to show or hide the message box.

**Fields / properties**

- `Message` — The message to display in the info box.
- `InfoMessageType` — The type of the message box.
- `VisibleIf` — Optional member field, property or function to show and hide the info box.
- `GUIAlwaysEnabled` — When `true` the InfoBox will ignore the GUI.enable flag and always draw as enabled.
- `Icon` — The icon to be displayed next to the message.
- `IconColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.

### `InlineButtonAttribute`

*Full name:* `Sirenix.OdinInspector.InlineButtonAttribute`

The inline button adds a button to the end of a property.

**Remarks.** > **Note:** Due to a bug, multiple inline buttons are currently not supported.

**Examples**

The following examples demonstrates how InlineButton can be used.

```csharp
public class MyComponent : MonoBehaviour
{
    // Adds a button to the end of the A property.
    [InlineButton("MyFunction")]
    public int A;

    // This is example demonstrates how you can change the label of the button.
    // InlineButton also supports refering to string members with $.
    [InlineButton("MyFunction", "Button")]
    public int B;

 private void MyFunction()
    {
        // ...
    }
}
```

**Constructors**

- `InlineButtonAttribute(string, string)`
  - `action` — A resolved string that defines the action to perform when the button is clicked, such as an expression or method invocation.
  - `label` — Optional label of the button.
- `InlineButtonAttribute(string, SdfIconType, string)`
  - `action` — A resolved string that defines the action to perform when the button is clicked, such as an expression or method invocation.
  - `icon` — The icon to be shown inside the button.
  - `label` — Optional label of the button.

**Fields / properties**

- `MemberMethod` — Name of member method to call when the button is clicked. Obsolete; use the Action member instead.
- `Action` — A resolved string that defines the action to perform when the button is clicked, such as an expression or method invocation.
- `Label` — Optional label of the button.
- `ShowIf` — Optional resolved string that specifies a condition for whether to show the inline button or not.
- `ButtonColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.
- `TextColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.

### `InlineEditorAttribute`

*Full name:* `Sirenix.OdinInspector.InlineEditorAttribute`

InlineAttribute is used on any property or field with a type that inherits from UnityEngine.Object. This includes components and assets etc.

**Examples**

```csharp
public class InlineEditorExamples : MonoBehaviour
{
    [DisableInInlineEditors]
    public Vector3 DisabledInInlineEditors;

    [HideInInlineEditors]
    public Vector3 HiddenInInlineEditors;

    [InlineEditor]
    public Transform InlineComponent;

    [InlineEditor(InlineEditorModes.FullEditor)]
    public Material FullInlineEditor;

    [InlineEditor(InlineEditorModes.GUIAndHeader)]
    public Material InlineMaterial;

    [InlineEditor(InlineEditorModes.SmallPreview)]
    public Material[] InlineMaterialList;

    [InlineEditor(InlineEditorModes.LargePreview)]
    public GameObject InlineObjectPreview;

    [InlineEditor(InlineEditorModes.LargePreview)]
    public Mesh InlineMeshPreview;
}
```

**Constructors**

- `InlineEditorAttribute(InlineEditorModes, InlineEditorObjectFieldModes)`
  - `inlineEditorMode` — The inline editor mode.
  - `objectFieldMode` — How the object field should be drawn.
- `InlineEditorAttribute(InlineEditorObjectFieldModes)`
  - `objectFieldMode` — How the object field should be drawn.

**Fields / properties**

- `Expanded` — If true, the inline editor will start expanded.
- `DrawHeader` — Draw the header editor header inline.
- `DrawGUI` — Draw editor GUI inline.
- `DrawPreview` — Draw editor preview inline.
- `MaxHeight` — Maximum height of the inline editor. If the inline editor exceeds the specified height, a scrollbar will appear. Values less or equals to zero will let the InlineEditor expand to its full size.
- `PreviewWidth` — The size of the editor preview if drawn together with GUI.
- `PreviewHeight` — The size of the editor preview if drawn alone.
- `IncrementInlineEditorDrawerDepth` — If false, this will prevent the InlineEditor attribute from incrementing the InlineEditorAttributeDrawer.CurrentInlineEditorDrawDepth. This is helpful in cases where you want to draw the entire editor, and disregard attributes such as [`HideInInlineEditorsAttribute`] and [`DisableInInlineEditorsAttribute`].
- `DisableGUIForVCSLockedAssets` — Whether to set GUI.enabled = false when drawing an editor for an asset that is locked by source control. Defaults to true.
- `ObjectFieldMode` — How the InlineEditor attribute drawer should draw the object field.
- `PreviewAlignment` — Where to draw the preview.

### `InlinePropertyAttribute`

*Full name:* `Sirenix.OdinInspector.InlinePropertyAttribute`

The Inline Property is used to place the contents of a type next to the label, instead of being rendered in a foldout.

**Examples**

```csharp
public class InlinePropertyExamples : MonoBehaviour
{
    public Vector3 Vector3;

    public Vector3Int Vector3Int;

    [InlineProperty(LabelWidth = 12)]  // It can be placed on classes as well as members
    public Vector2Int Vector2Int;

}

[Serializable]
[InlineProperty(LabelWidth = 12)] // It can be placed on classes as well as members
public struct Vector3Int
{
    [HorizontalGroup]
    public int X;

    [HorizontalGroup]
    public int Y;

    [HorizontalGroup]
    public int Z;
}

[Serializable]
public struct Vector2Int
{
    [HorizontalGroup]
    public int X;

    [HorizontalGroup]
    public int Y;
}
```

**Fields / properties**

- `LabelWidth` — Specify a label width for all child properties.

### `LabelTextAttribute`

*Full name:* `Sirenix.OdinInspector.LabelTextAttribute`

LabelText is used to change the labels of properties.

Use this if you want a different label than the name of the property.

**Examples**

The following example shows how LabelText is applied to a few property fields.

```csharp
public MyComponent : MonoBehaviour
{
       [LabelText("1")]
       public int MyInt1;

       [LabelText("2")]
       public int MyInt2;

       [LabelText("3")]
       public int MyInt3;
}
```

**Constructors**

- `LabelTextAttribute(string)`
  - `text` — The new text of the label.
- `LabelTextAttribute(SdfIconType)`
  - `icon` — The icon to be shown next to the property.
- `LabelTextAttribute(string, bool)`
  - `text` — The new text of the label.
  - `nicifyText` — Whether to nicify the label text.
- `LabelTextAttribute(string, SdfIconType)`
  - `text` — The new text of the label.
  - `icon` — The icon to be displayed.
- `LabelTextAttribute(string, bool, SdfIconType)`
  - `text` — The new text of the label.
  - `nicifyText` — Whether to nicify the label text.
  - `icon` — The icon to be displayed.

**Fields / properties**

- `Text` — The new text of the label.
- `NicifyText` — Whether the label text should be nicified before it is displayed, IE, "m_someField" becomes "Some Field". If the label text is resolved via a member reference, an expression, or the like, then the evaluated result of that member reference or expression will be nicified.
- `Icon` — The icon to be displayed.
- `IconColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.

### `LabelWidthAttribute`

*Full name:* `Sirenix.OdinInspector.LabelWidthAttribute`

LabelWidth is used to change the width of labels for properties.

**Examples**

The following example shows how LabelText is applied to a few property fields.

```csharp
public MyComponent : MonoBehaviour
{
    [LabelWidth("3")]
    public int MyInt3;
}
```

**Constructors**

- `LabelWidthAttribute(float)`
  - `width` — The width of the label.

**Fields / properties**

- `Width` — The new text of the label.

### `ListDrawerSettingsAttribute`

*Full name:* `Sirenix.OdinInspector.ListDrawerSettingsAttribute`

Customize the behavior for lists and arrays in the inspector.

**Remarks.** This attribute is scheduled for refactoring.

**Examples**

This example shows how you can add your own custom add button to a list.

```csharp
[ListDrawerSettings(HideAddButton = true, OnTitleBarGUI = "DrawTitleBarGUI")]
public List<MyType> SomeList;

#if UNITY_EDITOR
private void DrawTitleBarGUI()
{
    if (SirenixEditorGUI.ToolbarButton(EditorIcons.Plus))
    {
        this.SomeList.Add(new MyType());
    }
}
#endif
```

**Fields / properties**

- `HideAddButton` — If true, the add button will not be rendered in the title toolbar. You can use OnTitleBarGUI to implement your own add button.
- `HideRemoveButton` — If true, the remove button will not be rendered on list items. You can use OnBeginListElementGUI and OnEndListElementGUI to implement your own remove button.
- `ListElementLabelName` — Specify the name of a member inside each list element which defines the label being drawn for each list element.
- `CustomAddFunction` — Override the default behaviour for adding objects to the list. If the referenced member returns the list type element, it will be called once per selected object. If the referenced method returns void, it will only be called once regardless of how many objects are selected.
- `OnBeginListElementGUI` — Calls a method before each list element. The member referenced must have a return type of void, and an index parameter of type int which represents the element index being drawn.
- `OnEndListElementGUI` — Calls a method after each list element. The member referenced must have a return type of void, and an index parameter of type int which represents the element index being drawn.
- `AlwaysAddDefaultValue` — If true, object/type pickers will never be shown when the list add button is clicked, and default(T) will always be added instantly instead, where T is the element type of the list.
- `AddCopiesLastElement` — Whether adding a new element should copy the last element. False by default.
- `ElementColor` — A resolved string with "int index" and "Color defaultColor" parameters that lets you control the color of individual elements. Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.
- `ShowPaging` — Override the default setting specified in the Advanced Odin Preferences window and explicitly tell whether paging should be enabled or not.
- `DraggableItems` — Override the default setting specified in the Advanced Odin Preferences window and explicitly tell whether items should be draggable or not.
- `NumberOfItemsPerPage` — Override the default setting specified in the Advanced Odin Preferences window and explicitly tells how many items each page should contain.
- `IsReadOnly` — Mark a list as read-only. This removes all editing capabilities from the list such as Add, Drag and delete, but without disabling GUI for each element drawn as otherwise would be the case if the `ReadOnlyAttribute` was used.
- `ShowItemCount` — Override the default setting specified in the Advanced Odin Preferences window and explicitly tell whether or not item count should be shown.
- `ShowFoldout` — Whether to show a foldout for the collection or not. If this is set to false, the collection will *always* be expanded.
- `Expanded` — Whether to show a foldout for the collection or not. If this is set to false, the collection will *always* be expanded.

This documentation used to wrongly state that this value would override the default setting specified in the Advanced Odin Preferences window and explicitly tell whether or not the list should be expanded or collapsed by default. This value *would* do that, but it would also simultaneously act as ShowFoldout, leading to weird and unintuitive behaviour.
- `DefaultExpandedState` — Override the default setting specified in the Odin Preferences window and explicitly tell whether or not the list should be expanded or collapsed by default. Note that this will override the persisted expand state, as this is set *every time* the collection drawer is initialized.
- `ShowIndexLabels` — If true, a label is drawn for each element which shows the index of the element.
- `OnTitleBarGUI` — Use this to inject custom GUI into the title-bar of the list.
- `PagingHasValue` — Whether the Paging property is set.
- `ShowItemCountHasValue` — Whether the ShowItemCount property is set.
- `NumberOfItemsPerPageHasValue` — Whether the NumberOfItemsPerPage property is set.
- `DraggableHasValue` — Whether the Draggable property is set.
- `IsReadOnlyHasValue` — Whether the IsReadOnly property is set.
- `ShowIndexLabelsHasValue` — Whether the ShowIndexLabels property is set.
- `DefaultExpandedStateHasValue` — Whether the DefaultExpandedState property is set.

### `MaxValueAttribute`

*Full name:* `Sirenix.OdinInspector.MaxValueAttribute`

MaxValue is used on primitive fields. It caps value of the field to a maximum value.

Use this to define a maximum value for the field.

**Remarks.** > **Note:** Note that this attribute only works in the editor! Values changed from scripting will not be capped at a maximum.

**Examples**

The following example shows a component where a speed value must be less than or equal to 200.

```csharp
public class Car : MonoBehaviour
{
    // The speed of the car must be less than or equal to 200.
    [MaxValue(200)]
    public float Speed;
}
```

The following example shows how MaxValue can be combined with `MinValueAttribute`.

```csharp
public class Health : MonoBehaviour
{
    // The speed value must be between 0 and 200.
    [MinValue(0), MaxValue(200)]
    public float Speed;
}
```

**Constructors**

- `MaxValueAttribute(double)`
  - `maxValue` — The max value.
- `MaxValueAttribute(string)`
  - `expression` — The string with which to resolve a maximum value. This could be a field, property or method name, or an expression.

**Fields / properties**

- `MaxValue` — The maximum value for the property.
- `Expression` — The string with which to resolve a maximum value. This could be a field, property or method name, or an expression.

### `MinMaxSliderAttribute`

*Full name:* `Sirenix.OdinInspector.MinMaxSliderAttribute`

Draw a special slider the user can use to specify a range between a min and a max value.

Uses a Vector2 where x is min and y is max.

**Examples**

The following example shows how MinMaxSlider is used.

```csharp
public class Player : MonoBehaviour
{
    [MinMaxSlider(4, 5)]
    public Vector2 SpawnRadius;
}
```

**Constructors**

- `MinMaxSliderAttribute(float, float, bool)`
  - `minValue` — The min value.
  - `maxValue` — The max value.
  - `showFields` — If `true` number fields will drawn next to the MinMaxSlider.
- `MinMaxSliderAttribute(string, float, bool)`
  - `minValueGetter` — A resolved string that should evaluate to a float value, which is used as the min bounds.
  - `maxValue` — The max value.
  - `showFields` — If `true` number fields will drawn next to the MinMaxSlider.
- `MinMaxSliderAttribute(float, string, bool)`
  - `minValue` — The min value.
  - `maxValueGetter` — A resolved string that should evaluate to a float value, which is used as the max bounds.
  - `showFields` — If `true` number fields will drawn next to the MinMaxSlider.
- `MinMaxSliderAttribute(string, string, bool)`
  - `minValueGetter` — A resolved string that should evaluate to a float value, which is used as the min bounds.
  - `maxValueGetter` — A resolved string that should evaluate to a float value, which is used as the max bounds.
  - `showFields` — If `true` number fields will drawn next to the MinMaxSlider.
- `MinMaxSliderAttribute(string, bool)`
  - `minMaxValueGetter` — A resolved string that should evaluate to a Vector2 value, which is used as the min/max bounds. If this is non-null, it overrides the behaviour of the MinValue, MinValueGetter, MaxValue and MaxValueGetter members.
  - `showFields` — If `true` number fields will drawn next to the MinMaxSlider.

**Fields / properties**

- `MinValue` — The hardcoded min value for the slider.
- `MaxValue` — The hardcoded max value for the slider.
- `MinMember` — The name of a field, property or method to get the min value from. Obsolete; use MinValueGetter instead.
- `MinValueGetter` — A resolved string that should evaluate to a float value, which is used as the min bounds.
- `MaxMember` — The name of a field, property or method to get the max value from. Obsolete; use MaxValueGetter instead.
- `MaxValueGetter` — A resolved string that should evaluate to a float value, which is used as the max bounds.
- `MinMaxMember` — The name of a Vector2 field, property or method to get the min max values from. Obsolete; use MinMaxValueGetter instead.
- `MinMaxValueGetter` — A resolved string that should evaluate to a Vector2 value, which is used as the min/max bounds. If this is non-null, it overrides the behaviour of the MinValue, MinValueGetter, MaxValue and MaxValueGetter members.
- `ShowFields` — Draw float fields for min and max value.

### `MinValueAttribute`

*Full name:* `Sirenix.OdinInspector.MinValueAttribute`

MinValue is used on primitive fields. It caps value of the field to a minimum value.

Use this to define a minimum value for the field.

**Remarks.** > **Note:** Note that this attribute only works in the editor! Values changed from scripting will not be capped at a minimum.

**Examples**

The following example shows a player component that must have at least 1 life.

```csharp
public class Player : MonoBehaviour
{
    // The life value must be set to at least 1.
    [MinValue(1)]
    public int Life;
}
```

The following example shows how MinValue can be combined with `MaxValueAttribute`

```csharp
public class Health : MonoBehaviour
{
    // The health value must be between 0 and 100.
    [MinValue(0), MaxValue(100)]
    public float Health;
}
```

**Constructors**

- `MinValueAttribute(double)`
  - `minValue` — The minimum value.
- `MinValueAttribute(string)`
  - `expression` — The string with which to resolve a minimum value. This could be a field, property or method name, or an expression.

**Fields / properties**

- `MinValue` — The minimum value for the property.
- `Expression` — The string with which to resolve a minimum value. This could be a field, property or method name, or an expression.

### `MultiLinePropertyAttribute`

*Full name:* `Sirenix.OdinInspector.MultiLinePropertyAttribute`

MultiLineProperty is used on any string property.

Use this to allow users to edit strings in a multi line textbox.

**Remarks.** MultiLineProperty is similar to Unity's `MultilineAttribute` but can be applied to both fields and properties.

**Examples**

The following example shows how MultiLineProperty is applied to properties.

```csharp
public class MyComponent : MonoBehaviour
{
    [MultiLineProperty]
    public string MyString;

    [ShowInInspector, MultiLineProperty(10)]
    public string PropertyString;
}
```

**Constructors**

- `MultiLinePropertyAttribute(int)`
  - `lines` — The number of lines for the text box.

**Fields / properties**

- `Lines` — The number of lines for the text box.

### `OnCollectionChangedAttribute`

*Full name:* `Sirenix.OdinInspector.OnCollectionChangedAttribute`

OnCollectionChanged can be put on collections, and provides an event callback when the collection is about to be changed through the inspector, and when the collection has been changed through the inspector. Additionally, it provides a CollectionChangeInfo struct containing information about the exact changes made to the collection. This attribute works for all collections with a collection resolver, amongst them arrays, lists, dictionaries, hashsets, stacks and linked lists.

**Remarks.** > **Note:** Note that this attribute only works in the editor! Collections changed by script will not trigger change events!

**Examples**

The following example shows how OnCollectionChanged can be used to get callbacks when a collection is being changed.

```csharp
[OnCollectionChanged("Before", "After")]
public List<string> list;

public void Before(CollectionChangeInfo info)
{
    if (info.ChangeType == CollectionChangeType.Add || info.ChangeType == CollectionChangeType.Insert)
    {
        Debug.Log("Adding to the list!");
    }
    else if (info.ChangeType == CollectionChangeType.RemoveIndex || info.ChangeType == CollectionChangeType.RemoveValue)
    {
        Debug.Log("Removing from the list!");
    }
}

public void After(CollectionChangeInfo info)
{
    if (info.ChangeType == CollectionChangeType.Add || info.ChangeType == CollectionChangeType.Insert)
    {
        Debug.Log("Finished adding to the list!");
    }
    else if (info.ChangeType == CollectionChangeType.RemoveIndex || info.ChangeType == CollectionChangeType.RemoveValue)
    {
        Debug.Log("Finished removing from the list!");
    }
}
```

### `OnInspectorDisposeAttribute`

*Full name:* `Sirenix.OdinInspector.OnInspectorDisposeAttribute`

The OnInspectorDispose attribute takes in an action string as an argument (typically the name of a method to be invoked, or an expression to be executed), and executes that action when the property's drawers are disposed in the inspector.

Disposing will happen at least once, when the inspector changes selection or the property tree is collected by the garbage collector, but may also happen several times before that, most often when the type of a polymorphic property changes and it refreshes its drawer setup and recreates all its children, disposing of the old setup and children.

**Examples**

The following example demonstrates how OnInspectorDispose works.

```csharp
public class MyComponent : MonoBehaviour
{
    [OnInspectorDispose(@"@UnityEngine.Debug.Log(""Dispose event invoked!"")")]
    [ShowInInspector, InfoBox("When you change the type of this field, or set it to null, the former property setup is disposed. The property setup will also be disposed when you deselect this example."), DisplayAsString]
    public BaseClass PolymorphicField;

    public abstract class BaseClass { public override string ToString() { return this.GetType().Name; } }
    public class A : BaseClass { }
    public class B : BaseClass { }
    public class C : BaseClass { }
}
```

**Constructors**

- `OnInspectorDisposeAttribute()`
- `OnInspectorDisposeAttribute(string)`

### `OnInspectorGUIAttribute`

*Full name:* `Sirenix.OdinInspector.OnInspectorGUIAttribute`

OnInspectorGUI is used on any property, and will call the specified function whenever the inspector code is running.

Use this to create custom inspector GUI for an object.

**Examples**

```csharp
public MyComponent : MonoBehaviour
{
       [OnInspectorGUI]
       private void MyInspectorGUI()
       {
           GUILayout.Label("Label drawn from callback");
       }
}
```

The following example shows how a callback can be set before another property.

```csharp
public MyComponent : MonoBehaviour
{
       [OnInspectorGUI("MyInspectorGUI", false)]
       public int MyField;

       private void MyInspectorGUI()
       {
           GUILayout.Label("Label before My Field property");
       }
}
```

The following example shows how callbacks can be added both before and after a property.

```csharp
public MyComponent : MonoBehaviour
{
       [OnInspectorGUI("GUIBefore", "GUIAfter")]
       public int MyField;

       private void GUIBefore()
       {
           GUILayout.Label("Label before My Field property");
       }

       private void GUIAfter()
       {
           GUILayout.Label("Label after My Field property");
       }
}
```

**Constructors**

- `OnInspectorGUIAttribute()`
- `OnInspectorGUIAttribute(string, bool)`
  - `action` — The resolved action string that defines the action to be invoked.
  - `append` — If `true` the method will be called after the property has been drawn. Otherwise the method will be called before.
- `OnInspectorGUIAttribute(string, string)`
  - `prepend` — The resolved action string that defines the action to be invoked before the property is drawn, if any.
  - `append` — The resolved action string that defines the action to be invoked after the property is drawn, if any.

**Fields / properties**

- `Prepend` — The resolved action string that defines the action to be invoked before the property is drawn, if any.
- `Append` — The resolved action string that defines the action to be invoked after the property is drawn, if any.
- `PrependMethodName` — The name of the method to be called before the property is drawn, if any. Obsolete; use the Prepend member instead.
- `AppendMethodName` — The name of the method to be called after the property is drawn, if any. Obsolete; use the Append member instead.

### `OnInspectorInitAttribute`

*Full name:* `Sirenix.OdinInspector.OnInspectorInitAttribute`

The OnInspectorInit attribute takes in an action string as an argument (typically the name of a method to be invoked, or an expression to be executed), and executes that action when the property's drawers are initialized in the inspector.

Initialization will happen at least once during the first drawn frame of any given property, but may also happen several times later, most often when the type of a polymorphic property changes and it refreshes its drawer setup and recreates all its children.

**Examples**

The following example demonstrates how OnInspectorInit works.

```csharp
public class MyComponent : MonoBehaviour
{
    // Display current time for reference.
    [ShowInInspector, DisplayAsString, PropertyOrder(-1)]
    public string CurrentTime { get { GUIHelper.RequestRepaint(); return DateTime.Now.ToString(); } }

    // OnInspectorInit executes the first time this string is about to be drawn in the inspector.
    // It will execute again when the example is reselected.
    [OnInspectorInit("@TimeWhenExampleWasOpened = DateTime.Now.ToString()")]
    public string TimeWhenExampleWasOpened;

    // OnInspectorInit will not execute before the property is actually "resolved" in the inspector.
    // Remember, Odin's property system is lazily evaluated, and so a property does not actually exist
    // and is not initialized before something is actually asking for it.
    //
    // Therefore, this OnInspectorInit attribute won't execute until the foldout is expanded.
    [FoldoutGroup("Delayed Initialization", Expanded = false, HideWhenChildrenAreInvisible = false)]
    [OnInspectorInit("@TimeFoldoutWasOpened = DateTime.Now.ToString()")]
    public string TimeFoldoutWasOpened;
}
```

**Constructors**

- `OnInspectorInitAttribute()`
- `OnInspectorInitAttribute(string)`

### `OnStateUpdateAttribute`

*Full name:* `Sirenix.OdinInspector.OnStateUpdateAttribute`

OnStateUpdate provides an event callback when the property's state should be updated, when the StateUpdaters run on the property instance. This generally happens at least once per frame, and the callback will be invoked even when the property is not visible. This can be used to approximate custom StateUpdaters like [ShowIf] without needing to make entire attributes and StateUpdaters for one-off cases.

**Examples**

The following example shows how OnStateUpdate can be used to control the visible state of a property.

```csharp
public class MyComponent : MonoBehaviour
{
       [OnStateUpdate("@$property.State.Visible = ToggleMyInt")]
       public int MyInt;

       public bool ToggleMyInt;
}
```

The following example shows how OnStateUpdate can be used to control the expanded state of a list.

```csharp
public class MyComponent : MonoBehaviour
{
       [OnStateUpdate("@$property.State.Expanded = ExpandList")]
       public List<string> list;

       public bool ExpandList;
}
```

The following example shows how OnStateUpdate can be used to control the state of another property.

```csharp
public class MyComponent : MonoBehaviour
{
       public List>string< list;

       [OnStateUpdate("@#(list).State.Expanded = $value")]
       public bool ExpandList;
}
```

### `OnValueChangedAttribute`

*Full name:* `Sirenix.OdinInspector.OnValueChangedAttribute`

OnValueChanged works on properties and fields, and calls the specified function whenever the value has been changed via the inspector.

**Remarks.** > **Note:** Note that this attribute only works in the editor! Properties changed by script will not call the function.

**Examples**

The following example shows how OnValueChanged is used to provide a callback for a property.

```csharp
public class MyComponent : MonoBehaviour
{
       [OnValueChanged("MyCallback")]
       public int MyInt;

       private void MyCallback()
       {
           // ..
       }
}
```

The following example show how OnValueChanged can be used to get a component from a prefab property.

```csharp
public class MyComponent : MonoBehaviour
{
       [OnValueChanged("OnPrefabChange")]
       public GameObject MyPrefab;

       // RigidBody component of MyPrefab.
       [SerializeField, HideInInspector]
       private RigidBody myPrefabRigidbody;

       private void OnPrefabChange()
       {
           if(MyPrefab != null)
           {
               myPrefabRigidbody = MyPrefab.GetComponent<Rigidbody>();
           }
           else
           {
               myPrefabRigidbody = null;
           }
       }
}
```

**Constructors**

- `OnValueChangedAttribute(string, bool)`
  - `action` — A resolved string that defines the action to perform when the value is changed, such as an expression or method invocation.
  - `includeChildren` — Whether to perform the action when a child value of the property is changed.

**Fields / properties**

- `MethodName` — Name of callback member function. Obsolete; use the Action member instead.
- `Action` — A resolved string that defines the action to perform when the value is changed, such as an expression or method invocation.
- `IncludeChildren` — Whether to perform the action when a child value of the property is changed.
- `InvokeOnUndoRedo` — Whether to perform the action when an undo or redo event occurs via UnityEditor.Undo.undoRedoPerformed. True by default.
- `InvokeOnInitialize` — Whether to perform the action when the property is initialized. This will generally happen when the property is first viewed/queried (IE when the inspector is first opened, or when its containing foldout is first expanded, etc), and whenever its type or a parent type changes, or it is otherwise forced to rebuild.

### `OptionalAttribute`

*Full name:* `Sirenix.OdinInspector.OptionalAttribute`

Overrides the 'Reference Required by Default' rule to allow for null values. Has no effect if the rule is disabled.

This attribute does not do anything unless you have Odin Validator and the 'Reference Required by Default' rule is enabled.

### `PreviewFieldAttribute`

*Full name:* `Sirenix.OdinInspector.PreviewFieldAttribute`

Draws a square ObjectField which renders a preview for UnityEngine.Object types. This object field also adds support for drag and drop, dragging an object to another square object field, swaps the values. If you hold down control while letting go it will replace the value, And you can control + click the object field to quickly delete the value it holds.

These object fields can also be selectively enabled and customized globally from the Odin preferences window.

**Examples**

The following example shows how PreviewField is applied to a few property fields.

```csharp
public MyComponent : MonoBehaviour
{
       [PreviewField]
       public UnityEngine.Object SomeObject;

       [PreviewField]
       public Texture SomeTexture;

       [HorizontalGroup, HideLabel, PreviewField(30)]
       public Material A, B, C, D, F;
}
```

**Constructors**

- `PreviewFieldAttribute()`
- `PreviewFieldAttribute(float)`
  - `height` — The height of the preview field.
- `PreviewFieldAttribute(string, FilterMode)`
  - `previewGetter` — A resolved value that should resolve to the desired preview texture.
  - `filterMode` — The filter mode to be used for the preview texture.
- `PreviewFieldAttribute(string, float, FilterMode)`
  - `previewGetter` — A resolved value that should resolve to the desired preview texture.
  - `height` — The height of the preview field.
  - `filterMode` — The filter mode to be used for the preview texture.
- `PreviewFieldAttribute(float, ObjectFieldAlignment)`
  - `height` — The height of the preview field.
  - `alignment` — The alignment of the preview field.
- `PreviewFieldAttribute(string, ObjectFieldAlignment, FilterMode)`
  - `previewGetter` — A resolved value that should resolve to the desired preview texture.
  - `alignment` — The alignment of the preview field.
  - `filterMode` — The filter mode to be used for the preview texture.
- `PreviewFieldAttribute(string, float, ObjectFieldAlignment, FilterMode)`
  - `previewGetter` — A resolved value that should resolve to the desired preview texture.
  - `height` — The height of the preview field.
  - `alignment` — The alignment of the preview field.
  - `filterMode` — The filter mode to be used for the preview texture.
- `PreviewFieldAttribute(ObjectFieldAlignment)`
  - `alignment` — The alignment of the preview field.

**Fields / properties**

- `Height` — The height of the object field
- `FilterMode` — The FilterMode to be used for the preview.
- `Alignment` — Left aligned.
- `AlignmentHasValue` — Whether an alignment value is specified.
- `PreviewGetter` — A resolved value that should resolve to the desired preview texture.

### `ProgressBarAttribute`

*Full name:* `Sirenix.OdinInspector.ProgressBarAttribute`

Draws a horizontal progress bar based on the value of the property.

Use it for displaying a meter to indicate how full an inventory is, or to make a visual indication of a health bar.

**Examples**

The following example shows how ProgressBar can be used.

```csharp
public class ProgressBarExample : MonoBehaviour
{
       // Default progress bar.
       [ProgressBar(0, 100)]
       public int ProgressBar;

       // Health bar.
       [ProgressBar(0, 100, ColorMember = "GetHealthBarColor")]
       public float HealthBar = 50;

       private Color GetHealthBarColor(float value)
       {
           // Blends between red, and yellow color for when the health is below 30,
           // and blends between yellow and green color for when the health is above 30.
           return Color.Lerp(Color.Lerp(
               Color.red, Color.yellow, MathUtilities.LinearStep(0f, 30f, value)),
               Color.green, MathUtilities.LinearStep(0f, 100f, value));
       }

       // Stacked health bar.
       // The ProgressBar attribute is placed on property, without a set method, so it can't be edited directly.
       // So instead we have this Range attribute on a float to change the value.
       [Range(0, 300)]
       public float StackedHealth;

       [ProgressBar(0, 100, ColorMember = "GetStackedHealthColor", BackgroundColorMember = "GetStackHealthBackgroundColor")]
       private float StackedHealthProgressBar
       {
           // Loops the stacked health value between 0, and 100.
           get { return this.StackedHealth - 100 * (int)((this.StackedHealth - 1) / 100); }
       }

       private Color GetStackedHealthColor()
       {
           return
               this.StackedHealth > 200 ? Color.cyan :
               this.StackedHealth > 100 ? Color.green :
               Color.red;
       }

       private Color GetStackHealthBackgroundColor()
       {
           return
               this.StackedHealth > 200 ? Color.green :
               this.StackedHealth > 100 ? Color.red :
               new Color(0.16f, 0.16f, 0.16f, 1f);
       }

       // Custom color and height.
       [ProgressBar(-100, 100, r: 1, g: 1, b: 1, Height = 30)]
       public short BigProgressBar = 50;

    // You can also reference members by name to dynamically assign the min and max progress bar values.
    [ProgressBar("DynamicMin", "DynamicMax")]
    public float DynamicProgressBar;

    public float DynamicMin, DynamicMax;
}
```

**Constructors**

- `ProgressBarAttribute(double, double, float, float, float)`
  - `min` — The minimum value.
  - `max` — The maximum value.
  - `r` — The red channel of the color of the progress bar.
  - `g` — The green channel of the color of the progress bar.
  - `b` — The blue channel of the color of the progress bar.
- `ProgressBarAttribute(string, double, float, float, float)`
  - `minGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
  - `max` — The maximum value.
  - `r` — The red channel of the color of the progress bar.
  - `g` — The green channel of the color of the progress bar.
  - `b` — The blue channel of the color of the progress bar.
- `ProgressBarAttribute(double, string, float, float, float)`
  - `min` — The minimum value.
  - `maxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.
  - `r` — The red channel of the color of the progress bar.
  - `g` — The green channel of the color of the progress bar.
  - `b` — The blue channel of the color of the progress bar.
- `ProgressBarAttribute(string, string, float, float, float)`
  - `minGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
  - `maxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.
  - `r` — The red channel of the color of the progress bar.
  - `g` — The green channel of the color of the progress bar.
  - `b` — The blue channel of the color of the progress bar.

**Fields / properties**

- `Min` — The minimum value.
- `Max` — The maximum value.
- `MinMember` — The name of a field, property or method to get the min values from. Obsolete; use the MinGetter member instead.
- `MinGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
- `MaxMember` — The name of a field, property or method to get the max values from. Obsolete; use the MaxGetter member instead.
- `MaxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.
- `R` — The red channel of the color of the progress bar.
- `G` — The green channel of the color of the progress bar.
- `B` — The blue channel of the color of the progress bar.
- `Height` — The height of the progress bar in pixels. Defaults to 12 pixels.
- `ColorMember` — Optional reference to a Color field, property or method, to dynamically change the color of the progress bar. Obsolete; use the ColorGetter member instead.
- `ColorGetter` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.
- `BackgroundColorMember` — Optional reference to a Color field, property or method, to dynamically change the background color of the progress bar. Default background color is (0.16, 0.16, 0.16, 1). Obsolete; use the BackgroundColorGetter member instead.
- `BackgroundColorGetter` — Optional resolved string that should evaluate to a Color value, to dynamically change the background color of the progress bar. Default background color is (0.16, 0.16, 0.16, 1). It supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.
- `Segmented` — If `true` then the progress bar will be drawn in tiles.
- `CustomValueStringMember` — References a member by name to get a custom value label string from. Obsolete; use the CustomValueStringGetter member instead.
- `CustomValueStringGetter` — A resolved string to get a custom value label string from.
- `DrawValueLabel` — If `true` then there will be drawn a value label on top of the progress bar.
- `DrawValueLabelHasValue` — Gets a value indicating if the user has set a custom DrawValueLabel value.
- `ValueLabelAlignment` — The alignment of the value label on top of the progress bar. Defaults to center.
- `ValueLabelAlignmentHasValue` — Gets a value indicating if the user has set a custom ValueLabelAlignment value.

### `PropertyGroupAttribute`

*Full name:* `Sirenix.OdinInspector.PropertyGroupAttribute`

Attribute to derive from if you wish to create a new property group type, such as box groups or tab groups.

> **Note:** Note that this attribute has special behaviour for "combining" several attributes into one, as one group, may be declared across attributes in several members, completely out of order. See `PropertyGroupAttribute)`.

**Remarks.** All group attributes for a group with the same name (and of the same attribute type) are combined into a single representative group attribute using the `PropertyGroupAttribute)` method, which is called by the `PropertyGroupAttribute)` method.

This behaviour is a little unusual, but it is important that you understand it when creating groups with many custom parameters that may have to be combined.

**Examples**

This example shows how `BoxGroupAttribute` could be implemented.

```csharp
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class BoxGroupAttribute : PropertyGroupAttribute
{
    public string Label { get; private set; }
    public bool ShowLabel { get; private set; }
    public bool CenterLabel { get; private set; }

    public BoxGroupAttribute(string group, bool showLabel = true, bool centerLabel = false, float order = 0)
        : base(group, order)
    {
        this.Label = group;
        this.ShowLabel = showLabel;
        this.CenterLabel = centerLabel;
    }

    protected override void CombineValuesWith(PropertyGroupAttribute other)
    {
        // The given attribute parameter is *guaranteed* to be of type BoxGroupAttribute.
        var attr = other as BoxGroupAttribute;

        // If this attribute has no label, we the other group's label, thus preserving the label across combines.
        if (this.Label == null)
        {
            this.Label = attr.Label;
        }

        // Combine ShowLabel and CenterLabel parameters.
        this.ShowLabel |= attr.ShowLabel;
        this.CenterLabel |= attr.CenterLabel;
    }
}
```

**Constructors**

- `PropertyGroupAttribute(string, float)`
  - `groupId` — The group identifier.
  - `order` — The group order.
- `PropertyGroupAttribute(string)`
  - `groupId` — The group identifier.

**Fields / properties**

- `GroupID` — The ID used to grouping properties together.
- `GroupName` — The name of the group. This is the last part of the group ID if there is a path, otherwise it is just the group ID.
- `Order` — The order of the group.
- `HideWhenChildrenAreInvisible` — Whether to hide the group by default when all its children are not visible. True by default.
- `AnimateVisibility` — Whether to animate the visibility changes of this group or make the visual transition instantly. True by default.
- `VisibleIf` — If not null, this resolved string controls the group's visibility. Note that if `HideWhenChildrenAreInvisible` is true, there must be *both* a visible child *and* this condition must be true, before the group is shown.

**Methods**

- `Combine(PropertyGroupAttribute)` — Combines this attribute with another attribute of the same type. This method invokes the virtual `PropertyGroupAttribute)` method to invoke custom combine logic.

All group attributes are combined to one attribute used by a single OdinGroupDrawer.

Example:

```csharp
protected override void CombineValuesWith(PropertyGroupAttribute other) { this.Title = this.Title ?? (other as MyGroupAttribute).Title; }
```

### `PropertyOrderAttribute`

*Full name:* `Sirenix.OdinInspector.PropertyOrderAttribute`

PropertyOrder is used on any property, and allows for ordering of properties.

Use this to define in which order your properties are shown.

**Remarks.** Lower order values will be drawn before higher values.

> **Note:** There is unfortunately no way of ensuring that properties are in the same order, as they appear in your class. PropertyOrder overcomes this.

**Examples**

The following example shows how PropertyOrder is used to order properties in the inspector.

```csharp
public class MyComponent : MonoBehaviour
{
    [PropertyOrder(1)]
    public int MySecondProperty;

    [PropertyOrder(-1)]
    public int MyFirstProperty;
}
```

**Constructors**

- `PropertyOrderAttribute()`
- `PropertyOrderAttribute(float)`
  - `order` — The order for the property.

**Fields / properties**

- `Order` — The order for the property.

### `PropertyRangeAttribute`

*Full name:* `Sirenix.OdinInspector.PropertyRangeAttribute`

PropertyRange attribute creates a slider control to set the value of a property to between the specified range.

This is equivalent to Unity's Range attribute, but this attribute can be applied to both fields and property.

**Examples**

The following example demonstrates how PropertyRange is used.

**Constructors**

- `PropertyRangeAttribute(double, double)`
  - `min` — The minimum value.
  - `max` — The maximum value.
- `PropertyRangeAttribute(string, double)`
  - `minGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
  - `max` — The maximum value.
- `PropertyRangeAttribute(double, string)`
  - `min` — The minimum value.
  - `maxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.
- `PropertyRangeAttribute(string, string)`
  - `minGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
  - `maxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.

**Fields / properties**

- `Min` — The minimum value.
- `Max` — The maximum value.
- `MinMember` — The name of a field, property or method to get the min value from. Obsolete; use the MinGetter member instead.
- `MinGetter` — A resolved string that should evaluate to a float value, and will be used as the min bounds.
- `MaxMember` — The name of a field, property or method to get the max value from. Obsolete; use the MaxGetter member instead.
- `MaxGetter` — A resolved string that should evaluate to a float value, and will be used as the max bounds.

### `PropertySpaceAttribute`

*Full name:* `Sirenix.OdinInspector.PropertySpaceAttribute`

The PropertySpace attribute have the same function as Unity's existing Space attribute, but can be applied anywhere as opposed to just fields.

**Examples**

The following example demonstrates the usage of the PropertySpace attribute.

```csharp
[PropertySpace] // Defaults to a space of 8 pixels just like Unity's Space attribute.
public int MyField;

[ShowInInspector, PropertySpace(16)]
public int MyProperty { get; set; }

[ShowInInspector, PropertySpace(16, 16)]
public int MyProperty { get; set; }

[Button, PropertySpace(32)]
public void MyMethod()
{
    ...
}

[PropertySpace(-8)] // A negative space can also be remove existing space between properties.
public int MovedUp;
```

**Constructors**

- `PropertySpaceAttribute()`
- `PropertySpaceAttribute(float)`
- `PropertySpaceAttribute(float, float)`

**Fields / properties**

- `SpaceBefore` — The space between properties in pixels.
- `SpaceAfter` — The space between properties in pixels.

### `PropertyTooltipAttribute`

*Full name:* `Sirenix.OdinInspector.PropertyTooltipAttribute`

PropertyTooltip is used on any property, and creates tooltips for when hovering the property in the inspector.

Use this to explain the purpose, or how to use a property.

**Remarks.** This is similar to Unity's `TooltipAttribute` but can be applied to both fields and properties.

**Examples**

The following example shows how PropertyTooltip is applied to various properties.

```csharp
public class MyComponent : MonoBehaviour
{
    [PropertyTooltip("This is an int property.")]
    public int MyField;

    [ShowInInspector, PropertyTooltip("This is another int property.")]
    public int MyProperty { get; set; }
}
```

**Constructors**

- `PropertyTooltipAttribute(string)`
  - `tooltip` — The message shown in the tooltip.

**Fields / properties**

- `Tooltip` — The message shown in the tooltip.

### `ReadOnlyAttribute`

*Full name:* `Sirenix.OdinInspector.ReadOnlyAttribute`

ReadOnly is used on any property, and prevents the property from being changed in the inspector.

Use this for when you want to see the value of a property in the inspector, but don't want it to be changed.

**Remarks.** > **Note:** This attribute only affects the inspector! Values can still be changed by script.

**Examples**

The following example shows how a field can be displayed in the editor, but not be editable.

```csharp
public class Health : MonoBehaviour
{
       public int MaxHealth;

       [ReadOnly]
       public int CurrentHealth;
}
```

ReadOnly can also be combined with `ShowInInspectorAttribute`.

```csharp
public class Health : MonoBehaviour
{
       public int MaxHealth;

       [ShowInInspector, ReadOnly]
       private int currentHealth;
}
```

### `RequiredAttribute`

*Full name:* `Sirenix.OdinInspector.RequiredAttribute`

Required is used on any object property, and draws a message in the inspector if the property is missing.

Use this to clearly mark fields as necessary to the object.

**Examples**

The following example shows different uses of the Required attribute.

```csharp
public class MyComponent : MonoBehaviour
{
       [Required]
       public GameObject MyPrefab;

       [Required(InfoMessageType.Warning)]
       public Texture2D MyTexture;

       [Required("MyMesh is nessessary for this component.")]
       public Mesh MyMesh;

       [Required("MyTransform might be important.", InfoMessageType.Info)]
       public Transform MyTransform;
}
```

**Constructors**

- `RequiredAttribute()`
- `RequiredAttribute(string, InfoMessageType)`
  - `errorMessage` — The message to display in the error box.
  - `messageType` — The type of info box to draw.
- `RequiredAttribute(string)`
  - `errorMessage` — The message to display in the error box.
- `RequiredAttribute(InfoMessageType)`
  - `messageType` — The type of info box to draw.

**Fields / properties**

- `ErrorMessage` — The message of the info box.
- `MessageType` — The type of the info box.

### `RequiredInAttribute`

*Full name:* `Sirenix.OdinInspector.RequiredInAttribute`

Makes a member required based on which type of a prefab and instance it is in.

### `ResponsiveButtonGroupAttribute`

*Full name:* `Sirenix.OdinInspector.ResponsiveButtonGroupAttribute`

Groups buttons into a group that will position and resize the buttons based on the amount of available layout space.

**Examples**

```csharp
[ResponsiveButtonGroup]
public void Foo() { }

[ResponsiveButtonGroup]
public void Bar() { }

[ResponsiveButtonGroup]
public void Baz() { }
```

```csharp
[ResponsiveButtonGroup(UniformLayout = true)]
public void Foo() { }

[ResponsiveButtonGroup]
public void Bar() { }

[ResponsiveButtonGroup]
public void Baz() { }
```

```csharp
[ResponsiveButtonGroupAttribute(UniformLayout = true, DefaultButtonSize = ButtonSizes.Large)]
public void Foo() { }

[GUIColor(0, 1, 0))]
[Button(ButtonSizes.Large)]
[ResponsiveButtonGroup]
public void Bar() { }

[ResponsiveButtonGroup]
public void Baz() { }
```

```csharp
[TabGroup("SomeTabGroup", "SomeTab")]
[ResponsiveButtonGroup("SomeTabGroup/SomeTab/SomeBtnGroup")]
public void Foo() { }

[ResponsiveButtonGroup("SomeTabGroup/SomeTab/SomeBtnGroup")]
public void Bar() { }

[ResponsiveButtonGroup("SomeTabGroup/SomeTab/SomeBtnGroup")]
public void Baz() { }
```

**Constructors**

- `ResponsiveButtonGroupAttribute(string)`
  - `group` — The name of the group to place the button in.

**Fields / properties**

- `DefaultButtonSize` — The default size of the button.
- `UniformLayout` — If `true` then the widths of a line of buttons will be the same.

### `SceneObjectsOnlyAttribute`

*Full name:* `Sirenix.OdinInspector.SceneObjectsOnlyAttribute`

SceneObjectsOnly is used on object properties, and restricts the property to scene objects, and not project assets.

Use this when you want to ensure an object is a scene object, and not from a project asset.

**Examples**

The following example shows a component with a game object property, that must be from a scene, and not a prefab asset.

```csharp
public MyComponent : MonoBehaviour
{
    [SceneObjectsOnly]
    public GameObject MyPrefab;
}
```

### `SearchableAttribute`

*Full name:* `Sirenix.OdinInspector.SearchableAttribute`

Adds a search filter that can search the children of the field or type on which it is applied. Note that this does not currently work when directly applied to dictionaries, though a search field "above" the dictionary will still search the dictionary's properties if it is searching recursively.

**Fields / properties**

- `FuzzySearch` — Whether to use fuzzy string matching for the search. Default value: true.
- `FilterOptions` — The options for which things to use to filter the search. Default value: All.
- `Recursive` — Whether to search recursively, or only search the top level properties. Default value: true.

### `ShowDrawerChainAttribute`

*Full name:* `Sirenix.OdinInspector.ShowDrawerChainAttribute`

ShowDrawerChain lists all prepend, append and value drawers being used in the inspector. This is great in situations where you want to debug, and want to know which drawers might be involved in drawing the property.

Your own custom drawers are highlighted with a green label.

Drawers, that have not been called during the draw chain, will be greyed out in the inspector to make it clear which drawers have had an effect on the properties.

**Examples**

```csharp
public class MyComponent : MonoBehaviour
{
    [ShowDrawerChain]
    public int IndentedInt;
}
```

### `ShowIfAttribute`

*Full name:* `Sirenix.OdinInspector.ShowIfAttribute`

ShowIf is used on any property and can hide the property in the inspector.

Use this to hide irrelevant properties based on the current state of the object.

**Examples**

This example shows a component with fields hidden by the state of another field.

```csharp
public class MyComponent : MonoBehaviour
{
       public bool ShowProperties;

       [ShowIf("showProperties")]
       public int MyInt;

       [ShowIf("showProperties", false)]
       public string MyString;

       public SomeEnum SomeEnumField;

       [ShowIf("SomeEnumField", SomeEnum.SomeEnumMember)]
       public string SomeString;
}
```

This example shows a component with a field that is hidden when the game object is inactive.

```csharp
public class MyComponent : MonoBehaviour
{
       [ShowIf("MyVisibleFunction")]
       public int MyHideableField;

       private bool MyVisibleFunction()
       {
           return this.gameObject.activeInHierarchy;
       }
}
```

**Constructors**

- `ShowIfAttribute(string, bool)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `animate` — Whether or not to slide the property in and out when the state changes.
- `ShowIfAttribute(string, object, bool)`
  - `condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
  - `optionalValue` — Value to check against.
  - `animate` — Whether or not to slide the property in and out when the state changes.

**Fields / properties**

- `MemberName` — The name of a bool member field, property or method. Obsolete; use the Condition member instead.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.
- `Value` — The optional condition value.
- `Animate` — Whether or not to slide the property in and out when the state changes.

### `ShowIfGroupAttribute`

*Full name:* `Sirenix.OdinInspector.ShowIfGroupAttribute`

ShowIfGroup allows for showing or hiding a group of properties based on a condition. The attribute is a group attribute and can therefore be combined with other group attributes, and even be used to show or hide entire groups. Note that in the vast majority of cases where you simply want to be able to control the visibility of a single group, it is better to use the VisibleIf parameter that *all* group attributes have.

**Constructors**

- `ShowIfGroupAttribute(string, bool)`
  - `path` — The group path.
  - `animate` — If `true` then a fade animation will be played when the group is hidden or shown.
- `ShowIfGroupAttribute(string, object, bool)`
  - `path` — The group path.
  - `value` — The value the member should equal for the property to shown.
  - `animate` — If `true` then a fade animation will be played when the group is hidden or shown.

**Fields / properties**

- `Animate` — Whether or not to visually animate group visibility changes. Alias for AnimateVisibility.
- `Value` — The optional member value.
- `MemberName` — Name of member to use when to hide the group. Defaults to the name of the group, by can be overriden by setting this property.
- `Condition` — A resolved string that defines the condition to check the value of, such as a member name or an expression.

### `ShowInAttribute`

*Full name:* `Sirenix.OdinInspector.ShowInAttribute`

Shows a member based on which type of a prefab and instance it is in.

### `ShowInInlineEditorsAttribute`

*Full name:* `Sirenix.OdinInspector.ShowInInlineEditorsAttribute`

Only shows a property if it is drawn within an `InlineEditorAttribute`.

### `ShowInInspectorAttribute`

*Full name:* `Sirenix.OdinInspector.ShowInInspectorAttribute`

ShowInInspector is used on any member, and shows the value in the inspector. Note that the value being shown due to this attribute DOES NOT mean that the value is being serialized.

**Remarks.** This can for example be combined with `ReadOnlyAttribute` to allow for live debugging of values.

> **Note:**

**Examples**

The following example shows how ShowInInspector is used to show properties in the inspector, that otherwise wouldn't.

```csharp
public class MyComponent : MonoBehaviour
{
    [ShowInInspector]
    private int myField;

    [ShowInInspector]
    public int MyProperty { get; set; }
}
```

### `ShowOdinSerializedPropertiesInInspectorAttribute`

*Full name:* `Sirenix.OdinInspector.ShowOdinSerializedPropertiesInInspectorAttribute`

Marks a type as being specially serialized. Odin uses this attribute to check whether it should include non-Unity-serialized members in the inspector.

### `ShowPropertyResolverAttribute`

*Full name:* `Sirenix.OdinInspector.ShowPropertyResolverAttribute`

ShowPropertyResolver shows the property resolver responsible for bringing the member into the property tree. This is useful in situations where you want to debug why a particular member that is normally not shown in the inspector suddenly is.

**Examples**

```csharp
public class MyComponent : MonoBehaviour
{
    [ShowPropertyResolver]
    public int IndentedInt;
}
```

### `SuffixLabelAttribute`

*Full name:* `Sirenix.OdinInspector.SuffixLabelAttribute`

The SuffixLabel attribute draws a label at the end of a property.

Use this for conveying intend about a property. Is the distance measured in meters, kilometers, or in light years?. Is the angle measured in degrees or radians? Using SuffixLabel, you can place a neat label at the end of a property, to clearly show how the the property is used.

**Examples**

The following example demonstrates how SuffixLabel is used.

```csharp
public class MyComponent : MonoBehaviour
{
    // The SuffixLabel attribute draws a label at the end of a property.
    // It's useful for conveying intend about a property.
    // Fx, this field is supposed to have a prefab assigned.
    [SuffixLabel("Prefab")]
    public GameObject GameObject;

    // Using the Overlay property, the suffix label will be drawn on top of the property instead of behind it.
    // Use this for a neat inline look.
    [SuffixLabel("ms", Overlay = true)]
    public float Speed;

    [SuffixLabel("radians", Overlay = true)]
    public float Angle;

    // The SuffixLabel attribute also supports string member references by using $.
    [SuffixLabel("$Suffix", Overlay = true)]
    public string Suffix = "Dynamic suffix label";
}
```

**Constructors**

- `SuffixLabelAttribute(string, bool)`
  - `label` — The text of the label.
  - `overlay` — If `true` the suffix label will be drawn on top of the property, instead of after.
- `SuffixLabelAttribute(string, SdfIconType, bool)`
  - `label` — The text of the label.
  - `icon` — The icon to be displayed.
  - `overlay` — If `true` the suffix label will be drawn on top of the property, instead of after.
- `SuffixLabelAttribute(SdfIconType)`
  - `icon` — The icon to be displayed.

**Fields / properties**

- `Label` — The label displayed at the end of the property.
- `Overlay` — If `true` the suffix label will be drawn on top of the property, instead of after.
- `Icon` — The icon to be displayed.
- `IconColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.

### `SuppressInvalidAttributeErrorAttribute`

*Full name:* `Sirenix.OdinInspector.SuppressInvalidAttributeErrorAttribute`

SuppressInvalidAttributeError is used on members to suppress the inspector error message you get when applying an attribute to a value that it's not supposed to work on.

This can be very useful for applying attributes to generic parameter values, when it only applies to some of the possible types that the value might become.

**Examples**

The following example shows a case where the attribute might be useful.

```csharp
public class NamedValue<T>
{
    public string Name;

    // The Range attribute will be applied if T is compatible with it, but if T is not compatible, an error will not be shown.
       [SuppressInvalidAttributeError, Range(0, 10)]
       public T Value;
}
```

### `TabGroupAttribute`

*Full name:* `Sirenix.OdinInspector.TabGroupAttribute`

TabGroup is used on any property, and organizes properties into different tabs.

Use this to organize different value to make a clean and easy to use inspector.

**Remarks.** Use groups to create multiple tab groups, each with multiple tabs and even sub tabs.

**Examples**

The following example shows how to create a tab group with two tabs.

```csharp
public class MyComponent : MonoBehaviour
   {
       [TabGroup("First")]
       public int MyFirstInt;

       [TabGroup("First")]
       public int AnotherInt;

       [TabGroup("Second")]
       public int MySecondInt;
   }
```

The following example shows how multiple groups of tabs can be created.

```csharp
public class MyComponent : MonoBehaviour
{
    [TabGroup("A", "FirstGroup")]
    public int FirstGroupA;

    [TabGroup("B", "FirstGroup")]
    public int FirstGroupB;

    // The second tab group has been configured to have constant height across all tabs.
    [TabGroup("A", "SecondGroup", true)]
    public int SecondgroupA;

    [TabGroup("B", "SecondGroup")]
    public int SecondGroupB;

    [TabGroup("B", "SecondGroup")]
    public int AnotherInt;
}
```

This example demonstrates how multiple tabs groups can be combined to create tabs in tabs.

```csharp
public class MyComponent : MonoBehaviour
{
    [TabGroup("ParentGroup", "First Tab")]
    public int A;

    [TabGroup("ParentGroup", "Second Tab")]
    public int B;

    // Specify 'First Tab' as a group, and another child group to the 'First Tab' group.
    [TabGroup("ParentGroup/First Tab/InnerGroup", "Inside First Tab A")]
    public int C;

    [TabGroup("ParentGroup/First Tab/InnerGroup", "Inside First Tab B")]
    public int D;

    [TabGroup("ParentGroup/Second Tab/InnerGroup", "Inside Second Tab")]
    public int E;
}
```

**Constructors**

- `TabGroupAttribute(string, bool, float)`
  - `tab` — The tab.
  - `useFixedHeight` — if set to `true` [use fixed height].
  - `order` — The order.
- `TabGroupAttribute(string, string, bool, float)`
  - `group` — The group to attach the tab to.
  - `tab` — The name of the tab.
  - `useFixedHeight` — Set to true to have a constant height across the entire tab group.
  - `order` — The order of the group.
- `TabGroupAttribute(string, string, SdfIconType, bool, float)`
  - `group` — The group to attach the tab to.
  - `tab` — The name of the tab.
  - `useFixedHeight` — Set to true to have a constant height across the entire tab group.
  - `order` — The order of the group.

**Fields / properties**

- `DEFAULT_NAME` — The default tab group name which is used when the single-parameter constructor is called.
- `TabName` — Name of the tab.
- `UseFixedHeight` — Should this tab be the same height as the rest of the tab group.
- `Paddingless` — If true, the content of each page will not be contained in any box.
- `HideTabGroupIfTabGroupOnlyHasOneTab` — If true, the tab group will be hidden if it only contains one tab.
- `TextColor` — Supports a variety of color formats, including named colors (e.g. "red", "orange", "green", "blue"), hex codes (e.g. "#FF0000" and "#FF0000FF"), and RGBA (e.g. "RGBA(1,1,1,1)") or RGB (e.g. "RGB(1,1,1)"), including Odin attribute expressions (e.g "@this.MyColor"). Here are the available named colors: black, blue, clear, cyan, gray, green, grey, magenta, orange, purple, red, transparent, transparentBlack, transparentWhite, white, yellow, lightblue, lightcyan, lightgray, lightgreen, lightgrey, lightmagenta, lightorange, lightpurple, lightred, lightyellow, darkblue, darkcyan, darkgray, darkgreen, darkgrey, darkmagenta, darkorange, darkpurple, darkred, darkyellow.
- `TabLayouting` — Specify how tabs should be layouted.
- `Tabs` — Name of all tabs in this group.

### `TableColumnWidthAttribute`

*Full name:* `Sirenix.OdinInspector.TableColumnWidthAttribute`

The TableColumnWidth attribute is used to further customize the width of a column in tables drawn using the `TableListAttribute`.

**Examples**

```csharp
[TableList]
public List<SomeType> TableList = new List<SomeType>();

[Serializable]
public class SomeType
{
    [LabelWidth(30)]
    [TableColumnWidth(130, false)]
    [VerticalGroup("Combined")]
    public string A;

    [LabelWidth(30)]
    [VerticalGroup("Combined")]
    public string B;

    [Multiline(2), Space(3)]
    public string fields;
}
```

**Constructors**

- `TableColumnWidthAttribute(int, bool)`
  - `width` — The width of the column in pixels.
  - `resizable` — If `true` then the column can be resized in the inspector.

**Fields / properties**

- `Width` — The width of the column.
- `Resizable` — Whether the column should be resizable. True by default.

### `TableListAttribute`

*Full name:* `Sirenix.OdinInspector.TableListAttribute`

Renders lists and arrays in the inspector as tables.

**Fields / properties**

- `NumberOfItemsPerPage` — If ShowPaging is enabled, this will override the default setting specified in the Odin Preferences window.
- `IsReadOnly` — Mark the table as read-only. This removes all editing capabilities from the list such as Add and delete, but without disabling GUI for each element drawn as otherwise would be the case if the `ReadOnlyAttribute` was used.
- `DefaultMinColumnWidth` — The default minimum column width - 40 by default. This can be overwriten by individual columns using the `TableColumnWidthAttribute`.
- `ShowIndexLabels` — If true, a label is drawn for each element which shows the index of the element.
- `DrawScrollView` — Whether to draw all rows in a scroll-view.
- `MinScrollViewHeight` — The number of pixels before a scroll view appears. 350 by default.
- `MaxScrollViewHeight` — The number of pixels before a scroll view appears. 0 by default.
- `AlwaysExpanded` — If true, expanding and collapsing the table from the table title-bar is no longer an option.
- `HideToolbar` — Whether to hide the toolbar containing the add button and pagin etc.s
- `CellPadding` — The cell padding.
- `ShowPaging` — Whether paging buttons should be added to the title bar. The default value of this, can be customized from the Odin Preferences window.
- `ShowPagingHasValue` — Whether the ShowPaging property has been set.
- `ScrollViewHeight` — Sets the Min and Max ScrollViewHeight.

### `TableMatrixAttribute`

*Full name:* `Sirenix.OdinInspector.TableMatrixAttribute`

The TableMatrix attribute is used to further specify how Odin should draw two-dimensional arrays.

**Examples**

```csharp
// Inheriting from SerializedMonoBehaviour is only needed if you want Odin to serialize the multi-dimensional arrays for you.
// If you prefer doing that yourself, you can still make Odin show them in the inspector using the ShowInInspector attribute.
public class TableMatrixExamples : SerializedMonoBehaviour
{
    [InfoBox("Right-click and drag column and row labels in order to modify the tables."), PropertyOrder(-10), OnInspectorGUI]
    private void ShowMessageAtOP() { }

    [BoxGroup("Two Dimensional array without the TableMatrix attribute.")]
    public bool[,] BooleanTable = new bool[15, 6];

    [BoxGroup("ReadOnly table")]
    [TableMatrix(IsReadOnly = true)]
    public int[,] ReadOnlyTable = new int[5, 5];

    [BoxGroup("Labled table")]
    [TableMatrix(HorizontalTitle = "X axis", VerticalTitle = "Y axis")]
    public GameObject[,] LabledTable = new GameObject[15, 10];

    [BoxGroup("Enum table")]
    [TableMatrix(HorizontalTitle = "X axis")]
    public InfoMessageType[,] EnumTable = new InfoMessageType[4,4];

    [BoxGroup("Custom table")]
    [TableMatrix(DrawElementMethod = "DrawColoredEnumElement", ResizableColumns = false)]
    public bool[,] CustomCellDrawing = new bool[30,30];

    #if UNITY_EDITOR

        private static bool DrawColoredEnumElement(Rect rect, bool value)
        {
            if (Event.current.type == EventType.MouseDown && rect.Contains(Event.current.mousePosition))
            {
                value = !value;
                GUI.changed = true;
                Event.current.Use();
            }

            UnityEditor.EditorGUI.DrawRect(rect.Padding(1), value ? new Color(0.1f, 0.8f, 0.2f) : new Color(0, 0, 0, 0.5f));

            return value;
        }

    #endif
}
```

**Fields / properties**

- `IsReadOnly` — If true, inserting, removing and dragging columns and rows will become unavailable. But the cells themselves will remain modifiable. If you want to disable everything, you can use the `!:ReadOnly` attribute.
- `ResizableColumns` — Whether or not columns are resizable.
- `VerticalTitle` — The vertical title label.
- `HorizontalTitle` — The horizontal title label.
- `DrawElementMethod` — Override how Odin draws each cell.

[TableMatrix(DrawElementMethod='DrawMyElement')]

public MyType[,] myArray;

private static MyType DrawElement(Rect rect, MyType value) { return GUI.DrawMyType(rect, value); }
- `RowHeight` — The height for all rows. 0 = default row height.
- `SquareCells` — If true, the height of each row will be the same as the width of the first cell.
- `HideColumnIndices` — If true, no column indices drawn.
- `HideRowIndices` — If true, no row indices drawn.
- `RespectIndentLevel` — Whether the drawn table should respect the current GUI indent level.
- `Transpose` — If true, tables are drawn with rows/columns reversed (C# initialization order).
- `Labels` — A resolved string that should evaluate to a tuple (string, LabelDirection) which will be used as the label for the rows and columns of the table.

### `TitleAttribute`

*Full name:* `Sirenix.OdinInspector.TitleAttribute`

Title is used to make a bold header above a property.

**Examples**

The following example shows how Title is used on different properties.

```csharp
public class TitleExamples : MonoBehaviour
{
    [Title("Titles and Headers")]
    [InfoBox(
        "The Title attribute has the same purpose as Unity's Header attribute," +
        "but it also supports properties, and methods." +
        "\n\nTitle also offers more features such as subtitles, options for horizontal underline, bold text and text alignment." +
        "\n\nBoth attributes, with Odin, supports either static strings, or refering to members strings by adding a $ in front.")]
    public string MyTitle = "My Dynamic Title";
    public string MySubtitle = "My Dynamic Subtitle";

    [Title("Static title")]
    public int C;
    public int D;

    [Title("Static title", "Static subtitle")]
    public int E;
    public int F;

    [Title("$MyTitle", "$MySubtitle")]
    public int G;
    public int H;

    [Title("Non bold title", "$MySubtitle", bold: false)]
    public int I;
    public int J;

    [Title("Non bold title", "With no line seperator", horizontalLine: false, bold: false)]
    public int K;
    public int L;

    [Title("$MyTitle", "$MySubtitle", TitleAlignments.Right)]
    public int M;
    public int N;

    [Title("$MyTitle", "$MySubtitle", TitleAlignments.Centered)]
    public int O;
    public int P;

    [Title("$Combined", titleAlignment: TitleAlignments.Centered)]
    public int Q;
    public int R;

    [ShowInInspector]
    [Title("Title on a Property")]
    public int S { get; set; }

    [Title("Title on a Method")]
    [Button]
    public void DoNothing()
    { }

    public string Combined { get { return this.MyTitle + " - " + this.MySubtitle; } }
}
```

**Constructors**

- `TitleAttribute(string, string, TitleAlignments, bool, bool)`
  - `title` — The title displayed above the property in the inspector.
  - `subtitle` — Optional subtitle
  - `titleAlignment` — Title alignment
  - `horizontalLine` — Horizontal line
  - `bold` — If `true` the title will be drawn with a bold font.

**Fields / properties**

- `Title` — The title displayed above the property in the inspector.
- `Subtitle` — Optional subtitle.
- `Bold` — If `true` the title will be displayed with a bold font.
- `HorizontalLine` — Gets a value indicating whether or not to draw a horizontal line below the title.
- `TitleAlignment` — Title alignment.

### `TitleGroupAttribute`

*Full name:* `Sirenix.OdinInspector.TitleGroupAttribute`

Groups properties vertically together with a title, an optional subtitle, and an optional horizontal line.

**Constructors**

- `TitleGroupAttribute(string, string, TitleAlignments, bool, bool, bool, float)`
  - `title` — The title-
  - `subtitle` — Optional subtitle.
  - `alignment` — The text alignment.
  - `horizontalLine` — Horizontal line.
  - `boldTitle` — Bold text.
  - `indent` — Whether or not to indent all group members.
  - `order` — The group order.

**Fields / properties**

- `Subtitle` — Optional subtitle.
- `Alignment` — Title alignment.
- `HorizontalLine` — Gets a value indicating whether or not to draw a horizontal line below the title.
- `BoldTitle` — If `true` the title will be displayed with a bold font.
- `Indent` — Gets a value indicating whether or not to indent all group members.

### `ToggleAttribute`

*Full name:* `Sirenix.OdinInspector.ToggleAttribute`

Toggle is used on any field or property, and allows to enable or disable the property in the inspector.

Use this to create a property that can be turned off or on.

**Remarks.** > **Note:** Toggle does current not support any static members for toggling.

**Examples**

The following example shows how Toggle is used to create a toggleable property.

```csharp
public class MyComponent : MonoBehaviour
   {
       [Toggle("Enabled")]
       public MyToggleable MyToggler = new MyToggleable();
   }

   public class MyToggleable
   {
       public bool Enabled;

       public int MyValue;
   }
```

**Constructors**

- `ToggleAttribute(string)`
  - `toggleMemberName` — Name of any bool field or property to enable or disable the object.

**Fields / properties**

- `ToggleMemberName` — Name of any bool field or property to enable or disable the object.
- `CollapseOthersOnExpand` — If true, all other open toggle groups will collapse once another one opens.

### `ToggleGroupAttribute`

*Full name:* `Sirenix.OdinInspector.ToggleGroupAttribute`

ToggleGroup is used on any field, and create a toggleable group of options.

Use this to create options that can be enabled or disabled.

**Remarks.** The `ToggleMemberName` functions as the ID for the ToggleGroup, and therefore all members of a toggle group must specify the same toggle member.

> **Note:** This attribute does not support static members!

**Examples**

The following example shows how ToggleGroup is used to create two separate toggleable groups.

```csharp
public class MyComponent : MonoBehaviour
   {
       // This attribute has a title specified for the group. The title only needs to be applied to a single attribute for a group.
       [ToggleGroup("FirstToggle", order: -1, groupTitle: "First")]
       public bool FirstToggle;

       [ToggleGroup("FirstToggle")]
       public int MyInt;

       // This group specifies a member string as the title of the group. A property or a function can also be used.
       [ToggleGroup("SecondToggle", titleStringMemberName: "SecondGroupTitle")]
       public bool SecondToggle { get; set; }

       [ToggleGroup("SecondToggle")]
       public float MyFloat;

       [HideInInspector]
       public string SecondGroupTitle = "Second";
   }
```

**Constructors**

- `ToggleGroupAttribute(string, float, string)`
  - `toggleMemberName` — Name of any bool field or property to enable or disable the ToggleGroup.
  - `order` — The order of the group.
  - `groupTitle` — Use this to name the group differently than toggleMemberName.
- `ToggleGroupAttribute(string, string)`
  - `toggleMemberName` — Name of any bool field or property to enable or disable the ToggleGroup.
  - `groupTitle` — Use this to name the group differently than toggleMemberName.
- `ToggleGroupAttribute(string, float, string, string)`
  - `toggleMemberName` — Obsolete overload.
  - `order` — Obsolete overload.
  - `groupTitle` — Obsolete overload.
  - `titleStringMemberName` — Obsolete overload.

**Fields / properties**

- `ToggleGroupTitle` — Title of the toggle group in the inspector. If `null` `ToggleMemberName` will be used instead.
- `CollapseOthersOnExpand` — If true, all other open toggle groups will collapse once another one opens.
- `ToggleMemberName` — Name of any bool field, property or function to enable or disable the ToggleGroup.
- `TitleStringMemberName` — Name of any string field, property or function, to title the toggle group in the inspector. If `null` `ToggleGroupTitle` will be used instead.

### `ToggleLeftAttribute`

*Full name:* `Sirenix.OdinInspector.ToggleLeftAttribute`

Draws the checkbox before the label instead of after.

**Remarks.** ToggleLeftAttribute can be used an all fields and properties of type boolean

**Examples**

```csharp
public class MyComponent : MonoBehaviour
{
    [ToggleLeft]
    public bool MyBoolean;
}
```

### `TypeInfoBoxAttribute`

*Full name:* `Sirenix.OdinInspector.TypeInfoBoxAttribute`

The TypeInfoBox attribute adds an info box to the very top of a type in the inspector.

Use this to add an info box to the top of a class in the inspector, without having to use neither the PropertyOrder nor the OnInspectorGUI attribute.

**Examples**

The following example demonstrates the use of the TypeInfoBox attribute.

```csharp
[TypeInfoBox("This is my component and it is mine.")]
public class MyComponent : MonoBehaviour
{
    // Class implementation.
}
```

**Constructors**

- `TypeInfoBoxAttribute(string)`
  - `message` — The message to display in the info box.

**Fields / properties**

- `Message` — The message to display in the info box.

### `ValidateInputAttribute`

*Full name:* `Sirenix.OdinInspector.ValidateInputAttribute`

ValidateInput is used on any property, and allows to validate input from inspector.

Use this to enforce correct values.

**Remarks.** > **Note:** ValidateInput refuses invalid values.

> **Note:** ValidateInput only works in the editor. Values changed through scripting will not be validated.

**Examples**

The following examples shows how a speed value can be forced to be above 0.

```csharp
public class MyComponent : MonoBehaviour
{
       [ValidateInput("ValidateInput")]
       public float Speed;

       // Specify custom output message and message type.
       [ValidateInput("ValidateInput", "Health must be more than 0!", InfoMessageType.Warning)]
       public float Health;

       private bool ValidateInput(float property)
       {
           return property > 0f;
       }
}
```

The following example shows how a static function could also be used.

```csharp
public class MyComponent : MonoBehaviour
{
       [ValidateInput("StaticValidateFunction")]
       public int MyInt;

       private static bool StaticValidateFunction(int property)
       {
           return property != 0;
       }
}
```

**Constructors**

- `ValidateInputAttribute(string, string, InfoMessageType)`
  - `condition` — A resolved string that should evaluate to a boolean value, and which should validate the input. Note that in expressions, the $value named parameter, and in methods, a parameter named value, can be used to get the validated value instead of referring to the value by its containing member. This makes it easier to reuse validation strings.
  - `defaultMessage` — Default message for invalid values.
  - `messageType` — Type of the message.
- `ValidateInputAttribute(string, string, InfoMessageType, bool)`
  - `condition` — Obsolete overload.
  - `message` — Obsolete overload.
  - `messageType` — Obsolete overload.
  - `rejectedInvalidInput` — Obsolete overload.

**Fields / properties**

- `DefaultMessage` — Default message for invalid values.
- `MemberName` — OBSOLETE; use the Condition member instead. A resolved string that should evaluate to a boolean value, and which should validate the input. Note that in expressions, the $value named parameter, and in methods, a parameter named value, can be used to get the validated value instead of referring to the value by its containing member. This makes it easier to reuse validation strings.
- `Condition` — A resolved string that should evaluate to a boolean value, and which should validate the input. Note that in expressions, the $value named parameter, and in methods, a parameter named value, can be used to get the validated value instead of referring to the value by its containing member. This makes it easier to reuse validation strings.
- `MessageType` — The type of the message.
- `IncludeChildren` — Whether to also trigger validation when changes to child values happen. This is true by default.
- `ContinuousValidationCheck` — If true, the validation method will not only be executed when the User has changed the value. It'll run once every frame in the inspector.

### `ValueDropdownAttribute`

*Full name:* `Sirenix.OdinInspector.ValueDropdownAttribute`

ValueDropdown is used on any property and creates a dropdown with configurable options.

Use this to give the user a specific set of options to select from.

**Remarks.** > **Note:** Due to a bug in Unity, enums will sometimes not work correctly. The last example shows how this can be fixed.

**Examples**

The following example shows a how the ValueDropdown can be used on an int property.

```csharp
public class MyComponent : MonoBehaviour
   {
       [ValueDropdown("myValues")]
       public int MyInt;

       // The selectable values for the dropdown.
       private int[] myValues = { 1, 2, 3 };
   }
```

The following example shows how ValueDropdownList can be used for objects, that do not implement a usable ToString.

```csharp
public class MyComponent : MonoBehaviour
{
       [ValueDropdown("myVectorValues")]
       public Vector3 MyVector;

       // The selectable values for the dropdown, with custom names.
       private ValueDropdownList<Vector3> myVectorValues = new ValueDropdownList<Vector3>()
       {
           {"Forward",    Vector3.forward    },
           {"Back",    Vector3.back    },
           {"Up",        Vector3.up        },
           {"Down",    Vector3.down    },
           {"Right",    Vector3.right    },
           {"Left",    Vector3.left    },
       };
}
```

The following example shows how the ValueDropdown can on any member that implements IList.

```csharp
public class MyComponent : MonoBehaviour
{
       // Member field of type float[].
       private float[] valuesField;

       [ValueDropdown("valuesField")]
       public float MyFloat;

       // Member property of type List<thing>.
       private List<string> ValuesProperty { get; set; }

       [ValueDropdown("ValuesProperty")]
       public string MyString;

       // Member function that returns an object of type IList.
       private IList<ValueDropdownItem<int>> ValuesFunction()
       {
           return new ValueDropdownList<int>
           {
               { "The first option",    1 },
               { "The second option",    2 },
               { "The third option",    3 },
           };
       }

       [ValueDropdown("ValuesFunction")]
       public int MyInt;
}
```

Due to a bug in Unity, enums member arrays will in some cases appear as empty. This example shows how you can get around that.

```csharp
public class MyComponent : MonoBehaviour
{
       // Make the field static.
       private static MyEnum[] MyStaticEnumArray = MyEnum[] { ... };

       // Force Unity to serialize the field, and hide the property from the inspector.
       [SerializeField, HideInInspector]
       private MyEnum MySerializedEnumArray = MyEnum[] { ... };
}
```

**Constructors**

- `ValueDropdownAttribute(string)`
  - `valuesGetter` — A resolved string that should evaluate to a value that is assignable to IList; e.g, arrays and lists are compatible.

**Fields / properties**

- `MemberName` — Name of any field, property or method member that implements IList. E.g. arrays or Lists. Obsolete; use the ValuesGetter member instead.
- `ValuesGetter` — A resolved string that should evaluate to a value that is assignable to IList; e.g, arrays and lists are compatible.
- `NumberOfItemsBeforeEnablingSearch` — The number of items before enabling search. Default is 10.
- `IsUniqueList` — False by default.
- `DrawDropdownForListElements` — True by default. If the ValueDropdown attribute is applied to a list, then disabling this, will render all child elements normally without using the ValueDropdown. The ValueDropdown will still show up when you click the add button on the list drawer, unless `DisableListAddButtonBehaviour` is true.
- `DisableListAddButtonBehaviour` — False by default.
- `ExcludeExistingValuesInList` — If the ValueDropdown attribute is applied to a list, and `IsUniqueList` is set to true, then enabling this, will exclude existing values, instead of rendering a checkbox indicating whether the item is already included or not.
- `ExpandAllMenuItems` — If the dropdown renders a tree-view, then setting this to true will ensure everything is expanded by default.
- `AppendNextDrawer` — If true, instead of replacing the drawer with a wide dropdown-field, the dropdown button will be a little button, drawn next to the other drawer.
- `DisableGUIInAppendedDrawer` — Disables the the GUI for the appended drawer. False by default.
- `DoubleClickToConfirm` — By default, a single click selects and confirms the selection.
- `FlattenTreeView` — By default, the dropdown will create a tree view.
- `DropdownWidth` — Gets or sets the width of the dropdown. Default is zero.
- `DropdownHeight` — Gets or sets the height of the dropdown. Default is zero.
- `DropdownTitle` — Gets or sets the title for the dropdown. Null by default.
- `SortDropdownItems` — False by default.
- `HideChildProperties` — Whether to draw all child properties in a foldout.
- `CopyValues` — Whether values selected by the value dropdown should be copies of the original or references (in the case of reference types). Defaults to true.
- `OnlyChangeValueOnConfirm` — If this is set to true, the actual property value will *only* be changed *once*, when the selection in the dropdown is fully confirmed.

### `VerticalGroupAttribute`

*Full name:* `Sirenix.OdinInspector.VerticalGroupAttribute`

VerticalGroup is used to gather properties together in a vertical group in the inspector.

This doesn't do much in and of itself, but in combination with other groups, such as `HorizontalGroupAttribute` it can be very useful.

**Examples**

The following example demonstrates how VerticalGroup can be used in conjunction with `HorizontalGroupAttribute`

```csharp
public class MyComponent : MonoBehaviour
{
    [HorizontalGroup("Split")]
    [VerticalGroup("Split/Left")]
    public Vector3 Vector;

    [VerticalGroup("Split/Left")]
    public GameObject First;

    [VerticalGroup("Split/Left")]
    public GameObject Second;

    [VerticalGroup("Split/Right", PaddingTop = 18f)]
    public int A;

    [VerticalGroup("Split/Right")]
    public int B;
}
```

**Constructors**

- `VerticalGroupAttribute(string, float)`
  - `groupId` — The group ID.
  - `order` — The group order.
- `VerticalGroupAttribute(float)`
  - `order` — The group order.

**Fields / properties**

- `PaddingTop` — Space in pixels at the top of the group.
- `PaddingBottom` — Space in pixels at the bottom of the group.

### `WrapAttribute`

*Full name:* `Sirenix.OdinInspector.WrapAttribute`

Wrap is used on most primitive property, and allows for wrapping the value when it goes out of the defined range.

Use this when you want a value that goes around in circle, like for example an angle.

**Remarks.** > **Note:** Currently unsigned primitives are not supported.

**Examples**

The following example show how Wrap is used on a property.

```csharp
public class MyComponent : MonoBehaviour
{
    [Wrap(-100, 100)]
    public float MyFloat;
}
```

**Constructors**

- `WrapAttribute(double, double)`
  - `min` — The lowest value for the property.
  - `max` — The highest value for the property.

**Fields / properties**

- `Min` — The lowest value for the property.
- `Max` — The highest value for the property.
