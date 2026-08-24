---
title: "Odin Inspector 4.0.2.3: enums and helper types used by attributes"
source_files: ["Assets/Plugins/Sirenix/Assemblies/Sirenix.OdinInspector.Attributes.xml"]
odin_version: "4.0.2.3"
publisher: "Sirenix (Odin Inspector XML documentation shipped with the DLLs)"
generated: "2026-08-24"
generator: "docs/reference/_tools/build_odin_reference.py"
topic: "third-party/odin-inspector"
---

> Generated file — do not edit by hand. Re-run the generator after an Odin upgrade.


# Odin Inspector 4.0.2.3 — enums and helper types in `Sirenix.OdinInspector`

Types referenced by attribute parameters (`TitleAlignments`, `ButtonSizes`, `InfoMessageType`, `ValueDropdownList<T>` …).

### `AttributeTargetFlags`

*Full name:* `Sirenix.OdinInspector.AttributeTargetFlags`

Not yet documented.

**Fields / properties**

- `Default` — Not yet documented.

### `ButtonSizes`

*Full name:* `Sirenix.OdinInspector.ButtonSizes`

Various built-in button sizes.

**Fields / properties**

- `Small` — Small button size, fits well with properties in the inspector.
- `Medium` — A larger button.
- `Large` — A very large button.
- `Gigantic` — A gigantic button. Twice as big as Large

### `ButtonStyle`

*Full name:* `Sirenix.OdinInspector.ButtonStyle`

Button style for methods with parameters.

**Fields / properties**

- `CompactBox` — Draws a foldout box around the parameters of the method with the button on the box header itself. This is the default style of a method with parameters.
- `FoldoutButton` — Draws a button with a foldout to expose the parameters of the method.
- `Box` — Draws a foldout box around the parameters of the method with the button at the bottom of the box.

### `DictionaryDisplayOptions`

*Full name:* `Sirenix.OdinInspector.DictionaryDisplayOptions`

Various display modes for the dictionary to draw its items.

**Fields / properties**

- `OneLine` — Draws all dictionary items in two columns. The left column contains all key values, the right column displays all values.
- `Foldout` — Draws each dictionary item in a box with the key in the header and the value inside the box. Whether or not the box is expanded or collapsed by default, is determined by the "Expand Foldout By Default" setting found in the preferences window "Tools > Odin > Inspector > Preferences > Drawers > Settings".
- `CollapsedFoldout` — Draws each dictionary item in a collapsed foldout with the key in the header and the value inside the box.
- `ExpandedFoldout` — Draws each dictionary item in an expanded foldout with the key in the header and the value inside the box.

### `DictionaryDrawerSettings`

*Full name:* `Sirenix.OdinInspector.DictionaryDrawerSettings`

Customize the behavior for dictionaries in the inspector.

**Fields / properties**

- `KeyLabel` — Specify an alternative key label for the dictionary drawer.
- `ValueLabel` — Specify an alternative value label for the dictionary drawer.
- `DisplayMode` — Specify how the dictionary should draw its items.
- `IsReadOnly` — Gets or sets a value indicating whether this instance is read only.
- `KeyColumnWidth` — Gets or sets a value indicating the default key column width of the dictionary.

### `ISearchFilterable`

*Full name:* `Sirenix.OdinInspector.ISearchFilterable`

Implement this interface to create custom matching logic for search filtering in the inspector.

**Examples**

The following example shows how you might do this:

```csharp
public class MyCustomClass : ISearchFilterable
{
    public bool SearchEnabled;
    public string MyStr;

    public bool IsMatch(string searchString)
    {
        if (SearchEnabled)
        {
            return MyStr.Contains(searchString);
        }

        return false;
    }
}
```

### `ISelfValidator`

*Full name:* `Sirenix.OdinInspector.ISelfValidator`

Any type implementing this interface will be considered to be validating itself using the implemented logic, as if a custom validator had been written for it.

### `IValueDropdownItem`

*Full name:* `Sirenix.OdinInspector.IValueDropdownItem`

**Methods**

- `GetText()` — Gets the label for the dropdown item.
- `GetValue()` — Gets the value of the dropdown item.

### `ImageDrawPosition`

*Full name:* `Sirenix.OdinInspector.ImageDrawPosition`

Where the image is drawn relative to the original property.

**Fields / properties**

- `BeforeProperty` — Draw the image before the original property.
- `AfterProperty` — Draw the image after the original property.

### `ImageScaleMode`

*Full name:* `Sirenix.OdinInspector.ImageScaleMode`

The scale mode used by `ImageAttribute`.

**Fields / properties**

- `StretchToFill` — Stretch the image to fill the whole image rect.
- `ScaleToFit` — Scale the image proportionally so it fits inside the image rect.
- `ScaleAndCrop` — Scale the image proportionally so it covers the whole image rect, cropping as needed.

### `InfoMessageType`

*Full name:* `Sirenix.OdinInspector.InfoMessageType`

Type of info message box. This enum matches Unity's MessageType enum which could not be used since it is located in the UnityEditor assembly.

**Fields / properties**

- `None` — Generic message box with no type.
- `Info` — Information message box.
- `Warning` — Warning message box.
- `Error` — Error message box.

### `InlineEditorModes`

*Full name:* `Sirenix.OdinInspector.InlineEditorModes`

Editor modes for `InlineEditorAttribute`

**Fields / properties**

- `GUIOnly` — Draws only the editor GUI
- `GUIAndHeader` — Draws the editor GUI and the editor header.
- `GUIAndPreview` — Draws the editor GUI to the left, and a small editor preview to the right.
- `SmallPreview` — Draws a small editor preview without any GUI.
- `LargePreview` — Draws a large editor preview without any GUI.
- `FullEditor` — Draws the editor header and GUI to the left, and a small editor preview to the right.

### `InlineEditorObjectFieldModes`

*Full name:* `Sirenix.OdinInspector.InlineEditorObjectFieldModes`

How the InlineEditor attribute drawer should draw the object field.

**Fields / properties**

- `Boxed` — Draws the object field in a box.
- `Foldout` — Draws the object field with a foldout.
- `Hidden` — Hides the object field unless it's null.
- `CompletelyHidden` — Hidden the object field also when the object is null.

### `NonDefaultConstructorPreference`

*Full name:* `Sirenix.OdinInspector.NonDefaultConstructorPreference`

Specifies how non-default constructors are handled.

**Fields / properties**

- `Exclude` — Excludes types with non default constructors from the Selector.
- `ConstructIdeal` — Attempts to find the most straightforward constructor to call, prioritizing default values.
- `PreferUninitialized` — Uses `Type)` if no default constructor is found.
- `LogWarning` — Logs a warning instead of constructing the object, indicating that an attempt was made to construct an object without a default constructor.

### `ObjectFieldAlignment`

*Full name:* `Sirenix.OdinInspector.ObjectFieldAlignment`

How the square object field should be aligned.

**Fields / properties**

- `Left` — Left aligned.
- `Center` — Aligned to the center.
- `Right` — Right aligned.

### `PrefabKind`

*Full name:* `Sirenix.OdinInspector.PrefabKind`

The prefab kind returned by `GetPrefabKind`

**Fields / properties**

- `None` — None.
- `InstanceInScene` — Instances of prefabs in scenes.
- `InstanceInPrefab` — Instances of prefabs nested inside other prefabs.
- `Regular` — Regular prefab assets.
- `Variant` — Prefab variant assets.
- `NonPrefabInstance` — Non-prefab component or gameobject instances in scenes.
- `PrefabInstance` — Instances of regular prefabs, and prefab variants in scenes or nested in other prefabs.
- `PrefabAsset` — Prefab assets and prefab variant assets.
- `PrefabInstanceAndNonPrefabInstance` — Prefab Instances, as well as non-prefab instances.
- `All` — All kinds

### `SearchFilterOptions`

*Full name:* `Sirenix.OdinInspector.SearchFilterOptions`

Options for filtering search.

### `TitleAlignments`

*Full name:* `Sirenix.OdinInspector.TitleAlignments`

Title alignment enum used by various attributes.

**Fields / properties**

- `Left` — Title and subtitle left aligned.
- `Centered` — Title and subtitle centered aligned.
- `Right` — Title and subtitle right aligned.
- `Split` — Title on the left, subtitle on the right.

### `TypeInclusionFilter`

*Full name:* `Sirenix.OdinInspector.TypeInclusionFilter`

Specifies the types to include based on certain criteria.

**Fields / properties**

- `IncludeConcreteTypes` — Represents types that are not interfaces, abstracts, or generics.

### `Units`

*Full name:* `Sirenix.OdinInspector.Units`

Units for use with `UnitAttribute` and `UnitNumberUtility`.

### `ValueDropdownItem`

*Full name:* `Sirenix.OdinInspector.ValueDropdownItem`

**Constructors**

- `ValueDropdownItem(string, object)`
  - `text` — The text to display for the dropdown item.
  - `value` — The value for the dropdown item.

**Fields / properties**

- `Text` — The name of the item.
- `Value` — The value of the item.

**Methods**

- `ToString()` — The name of this item.
- `Sirenix#OdinInspector#IValueDropdownItem#GetText()` — Gets the text.
- `Sirenix#OdinInspector#IValueDropdownItem#GetValue()` — Gets the value.

### `ValueDropdownItem<T>`

*Full name:* `Sirenix.OdinInspector.ValueDropdownItem`1`

**Constructors**

- `ValueDropdownItem<T>(string, `0)`
  - `text` — The text to display for the dropdown item.
  - `value` — The value for the dropdown item.

**Fields / properties**

- `Text` — The name of the item.
- `Value` — The value of the item.

**Methods**

- `Sirenix#OdinInspector#IValueDropdownItem#GetText()` — Gets the text.
- `Sirenix#OdinInspector#IValueDropdownItem#GetValue()` — Gets the value.
- `ToString()` — The name of this item.

### `ValueDropdownList<T>`

*Full name:* `Sirenix.OdinInspector.ValueDropdownList`1`

Use this with `ValueDropdownAttribute` to specify custom names for values.

**Methods**

- `Add(string, `0)` — Adds the specified value with a custom name.
- `Add(`0)` — Adds the specified value.
