---
title: "Create a list view runtime UI"
page_title: "Unity - Manual: Create a list view runtime UI"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a list view runtime UI

**Version**: 2022.3+

This example demonstrates how to create a list view runtime UI. This example uses the UXML and USS files directly to create the structure and style of the UI. If You’re new to UI Toolkit and want to use UI Builder to create the UI, refer to [Create an example UI with UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-getting-started.html).

## Example overview

This example creates a simple character selection screen. When you click the name of a character from a list on the left, the detail of the character appears on the right.

![Final view of the runtime UI](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-howto-runtimeUI-final.png)

You can find the completed files that this example creates in this [GitHub repository](https://github.com/Unity-Technologies/ui-toolkit-manual-code-examples/tree/master/create-listview-runtime-ui).

## Prerequisites

This guide is for developers familiar with the Unity Editor, UI Toolkit, and C# scripting. Before you start, get familiar with the following:

-   [UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [`ListView`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.ListView.html)
-   [`Label`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Label.html)
-   [`PanelSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.html)
-   [`UIDocument`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument.html)

## Create the main UI Document

Create the main view UI Document and a USS file to style the visual elements. Add two visual elements as containers in the UI Document: one that contains the list of character names and another that contains the selected character’s details.

![The UI layout setup for the main view](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-howto-runtimeUI-finalMainView.png)

1.  Create a project in Unity with any template.

2.  In the Project window, create a folder named `UI` to store all the UI Document and Style Sheet files.

3.  In the `UI` folder, create a UI Document named `MainView.uxml` with the following content:

    ``` lang-xml
    <ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
        <Style src="MainView.uss" />
        <ui:VisualElement name="background">
            <ui:VisualElement name="main-container">
                <ui:ListView focusable="true" name="character-list" />
                <ui:VisualElement name="right-container">
                    <ui:VisualElement name="details-container">
                        <ui:VisualElement name="details">
                            <ui:VisualElement name="character-portrait" />
                        </ui:VisualElement>
                        <ui:Label text="Label" name="character-name" />
                        <ui:Label text="Label" display-tooltip-when-elided="true" name="character-class" />
                    </ui:VisualElement>
                </ui:VisualElement>
            </ui:VisualElement>
        </ui:VisualElement>
    </ui:UXML>
    ```

4.  In the `UI` folder, create a USS style sheet named `MainView.uss` with the following content:

``` lang-css
#background 
#main-container 
#character-list 
#character-name 
#character-class 
#right-container 
#details-container 
#details 
#character-portrait 
.unity-collection-view__item 
/* "Normal" background color of the item */
.unity-collection-view__item

/* Background color of the item when it is being hovered */
.unity-collection-view__item:hover

/* Background color of the item when it is selected */
.unity-collection-view__item--selected

```

## Create a list entry UI Document

Create a UI Document and a Style Sheet for the individual entries in the list. The character list entry consists of a colored background frame and the character’s name.

![List entry that shows a character’s name](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-howto-runtimeUI-listEntryFinal.png)

1.  In the `UI` folder, create a UI Document named `ListEntry.uxml` with the following content:

    ``` lang-xml
    <ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
    <Style src="ListEntry.uss" />
    <ui:VisualElement name="list-entry">
        <ui:Label text="Label" display-tooltip-when-elided="true" name="character-name" />
    </ui:VisualElement>
    </ui:UXML>
    ```

2.  In the `UI` folder, create a Style Sheet file named `ListEntry.uss` with the following content:

``` lang-css
#list-entry 
#character-name 
```

## Create sample data to display

Create sample data to fill the character list in the UI. For the character list, create a class that holds a character name, class, and a portrait image.

1.  In the Asset folder, create a folder named `Scripts` to store your C# scripts.

2.  In the `Scripts` folder, create a C# script named `CharacterData.cs` with the following content:

    ``` lang-cs
    using UnityEngine;
        
    public enum ECharacterClass
    
    [CreateAssetMenu]
    public class CharacterData : ScriptableObject
    
    ```

    This creates a **Character Data** item in the **Assets** > **Create** menu.

3.  In the Assets folder, create a folder named `Resources`.

4.  In the `Resources` folder, create a folder named `Characters` to store all your sample character data.

5.  In the `Characters` folder, right-click and select **Create** > **Character Data** to create an instance of the `ScriptableObject`.

6.  Create more `CharacterData` instances and fill them with placeholder data.

## Set up the scene

Create a UIDocument GameObject in the SampleScene and add the UI Document as the source asset.

1.  In the SampleScene, select **GameObject** > **UI Toolkit** > **UI Document**.
2.  Select the **UIDocument** GameObject in the Hierarchy window.
3.  Drag **MainView.uxml** from your Project window to the **Source Asset** field of the UI Document component in the Inspector window. This references the source asset to the UXML file.

## Create controllers for the list entry and the main view

Create two C# scripts with the following classes:

-   A `CharacterListEntryController` class to display the data of a character instance in the UI of the list entry. It needs to access the label for the character name and set it to display the name of the given character instance.
-   A `CharacterListController` class for the character list in the main view, and a `MonoBehaviour` script that instantiates and assigns it to the visual tree.

**Note**: The `CharacterListEntryController` class isn’t a `MonoBehaviour`. Since the visual elements in UI Toolkit aren’t GameObjects, you can’t attach components to them. Instead, you attach the class to the `userData` property in the `CharacterListController` class.

1.  In the `Scripts` folder, create a C# script named `CharacterListEntryController.cs` with the following contents:

    ``` lang-cs
    using UnityEngine.UIElements;
        
    public class CharacterListEntryController
    
        // This function receives the character whose name this list 
        // element is supposed to display. Since the elements list 
        // in a `ListView` are pooled and reused, it's necessary to 
        // have a `Set` function to change which character's data to display.
        public void SetCharacterData(CharacterData characterData)
        
    }
    ```

2.  In the `Scripts` folder, create a C# script named `CharacterListController.cs` with the following content:

    ``` lang-cs
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.UIElements;
        
    public class CharacterListController
    
        void EnumerateAllCharacters()
        
        void FillCharacterList()
        {
            // Set up a make item function for a list entry
            m_CharacterList.makeItem = () =>
            {
                // Instantiate the UXML template for the entry
                var newListEntry = m_ListEntryTemplate.Instantiate();
        
                // Instantiate a controller for the data
                var newListEntryLogic = new CharacterListEntryController();
        
                // Assign the controller script to the visual element
                newListEntry.userData = newListEntryLogic;
        
                // Initialize the controller script
                newListEntryLogic.SetVisualElement(newListEntry);
        
                // Return the root of the instantiated visual tree
                return newListEntry;
            };
        
            // Set up bind function for a specific list entry
            m_CharacterList.bindItem = (item, index) =>
            {
                (item.userData as CharacterListEntryController)?.SetCharacterData(m_AllCharacters[index]);
            };
        
            // Set a fixed item height matching the height of the item provided in makeItem. 
            // For dynamic height, see the virtualizationMethod property.
            m_CharacterList.fixedItemHeight = 45;
        
            // Set the actual item's source list/array
            m_CharacterList.itemsSource = m_AllCharacters;
        }
        
        void OnCharacterSelected(IEnumerable<object> selectedItems)
        
            // Fill in character details
            m_CharClassLabel.text = selectedCharacter.Class.ToString();
            m_CharNameLabel.text = selectedCharacter.CharacterName;
            m_CharPortrait.style.backgroundImage = new StyleBackground(selectedCharacter.PortraitImage);
        }
    }
    ```

## Attach the controller script to the main view

The `CharacterListController` isn’t a `MonoBehaviour`, so you can’t directly attach it to a GameObject. To overcome this, create a `MonoBehaviour` script and attach it to the same GameObject as the UIDocument. In this script, you don’t need to instantiate the `MainView.uxml` as it’s already instantiated by the UIDocument component. Instead, access the UIDocument component to get a reference of the already instantiated visual tree. Then, create an instance of the `CharacterListController` and pass in the root element of the visual tree and the UXML template used for the individual list elements.

**Note**: When the UI reloads, any associated `MonoBehaviour` components on the same GameObject that contain the UIDocument component are disabled before the reload, and then re-enabled after the reload. Therefore, you must place your UI-related code within the `OnEnable` and `OnDisable` methods of this `MonoBehaviour`. For more information, refer to [Lifecycle of UI Document components](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-create-ui-document-component.html#lifecycle-of-ui-document-components).

1.  In the `Scripts` folder, create a C# script named `MainView.cs` with the following content:

    ``` lang-cs
    using UnityEngine;
    using UnityEngine.UIElements;
        
    public class MainView : MonoBehaviour
    
    }
    ```

2.  In the SampleScene, select **UIDocument**.

3.  Drag `MainView.cs` to **Add Component** in the Inspector window.

4.  Drag **ListEntry.uxml** to the **ListEntry Template** field.

5.  Enter Play mode to see your UI displayed in the game view.

## Additional resource

-   [UXML element ListView](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-ListView.html)
-   [Get started with runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html)
-   [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html)
-   [The Panel Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html)
-   [Runtime event system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html)
