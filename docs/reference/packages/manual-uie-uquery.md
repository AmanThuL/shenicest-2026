---
title: "Find visual elements with UQuery"
page_title: "Unity - Manual: Find visual elements with UQuery"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Find visual elements with UQuery

You can use [UQuery](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQuery.html) to find elements from a [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html). UQuery was inspired by JQuery and Linq, and is designed to limit dynamic memory allocation. This allows for optimal performance on mobile platforms.

## Query methods

You can use UQuery through the following extension methods:

-   [`Q`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryExtensions.Q.html)
-   [`Query`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryExtensions.Query.html)

Internally, the `Q` and `Query` methods use [`UQueryBuilder`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.html) to construct a query. These extension methods reduce the verbosity of creating a `UQueryBuilder`.

To use UQuery to find elements, you must [load](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html) and [instantiate](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LoadingUXMLcsharp.html) the UXML first, and then use `Query` or `Q` to construct selection rules on a root visual element.

`Query` returns a list of elements that match the selection rules. You can filter the return results of `Query` with the public methods of [`UQueryBuilder`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.html), such as [First](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.First.html), [Last](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.Last.html), [AtIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.AtIndex.html), [Children](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.Children.html), and [Where](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.Where.html).

`Q` is the shorthand for `Query<T>.First()`. It returns the first element that matches the selection rules.

## Query elements

You can query elements by their [name](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html#name), their [USS class](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html#class), or their [element type (C# type)](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html#type). You can also query with a [predicate](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html#predicate) or make [complex hierarchical queries](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html#complex).

The following sections use this example UXML to demonstrate how to find elements:

``` lang-xml
<UXML xmlns="UnityEngine.UIElements">
    <VisualElement name="container1">
      <Button name="OK" text="OK" />
      <Button name="Cancel" text="Cancel" />
    </VisualElement>
     <VisualElement name="container2">
      <Button name="OK" class="yellow" text="OK" />
      <Button name="Cancel" text="Cancel" />
    </VisualElement>
    <VisualElement name="container3">
      <Button name="OK" class="yellow" text="OK" />
      <Button name="Cancel" class="yellow" text="Cancel" />
    </VisualElement>
</UXML>
```

<span id="name"></span>

### Query by name

To find elements by their [name](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-name.html), use `Query(name: "element-name")` or `Q(name: "element-name")`. You can omit the `name` as it’s the first argument. For example:

The following example finds a list of elements named `OK`:

``` lang-cs
List<VisualElement> result = root.Query("OK").ToList();
```

The following example uses `Query` to find the first element named `OK`:

``` lang-cs
VisualElement result = root.Query("OK").First(); //or VisualElement result = root.Q("OK");
```

The following example uses `Q` to find the first element named `OK`:

``` lang-cs
VisualElement result = root.Q("OK");
```

The following example finds the second element named `OK`:

``` lang-cs
VisualElement result3 = root.Query("OK").AtIndex(1);
```

The following example finds the last element named `OK`:

``` lang-cs
VisualElement result4 = root.Query("OK").Last();
```

<span id="class"></span>

### Query by USS class

To find elements by a [USS class](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-class.html), use `Query(className: "class-name")` or `Q(className: "class-name")`.

The following example finds all the elements that have the class `yellow` and assigns them to a list:

``` lang-cs
List<VisualElement> result = root.Query(className: "yellow").ToList();
```

The following example finds the first element that has the class `yellow`:

``` lang-cs
VisualElement result = root.Q(className: "yellow");
```

<span id="type"></span>

### Query by element type

To find elements by their [element type](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-type.html)(C# type), use `Query<Type>` or `Q<Type>`.

The following example finds the first button and adds a tooltip for it:

``` lang-cs
VisualElement result = root.Q<Button>();
result.tooltip = "This is a tooltip!";
```

The following example finds the third button:

``` lang-cs
VisualElement result = root.Query<Button>().AtIndex(2);
```

**Note**: You can only query by the actual type of the element, not base classes.

<span id="predicate"></span>

### Query with a predicate

Other than to query elements by name, class, and type, you can also use the `Where` method to select all elements that satisfy a predicate. The predicate must be a function callback that takes a single `VisualElement` argument.

The following example finds all the elements with the `yellow`USS class that have no tooltips:

``` lang-cs
List<VisualElement> result = root.Query(className: "yellow").Where(elem => elem.tooltip == "").ToList();
```

<span id="complex"></span>

### Complex hierarchical queries

You can combine name, class, and type to make complex hierarchical queries.

The following example finds the first button named `OK` that has a class of `yellow`:

``` lang-cs
VisualElement result = root.Query<Button>(className: "yellow", name: "OK").First();
```

The following example finds the child cancel button of the `container2`:

``` lang-cs
VisualElement result = root.Query<VisualElement>("container2").Children<Button>("Cancel").First();
```

**Note**: UQuery includes the queried element itself in the search results if it matches the criteria. For example:

``` lang-cs
var list = myElement.Query<VisualElement>("nameOrClass").ToList();
```

It might return `myElement` itself if it fits the selector. This behavior differs from `Element.querySelectorAll()` on the web, which explicitly returns only descendant nodes.

### Operate on results

You can use the [ForEach](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UQueryBuilder_1.ForEach.html) method to operate directly on the query results.

The following example adds a tooltip for any elements that have no tooltips:

``` lang-cs
root.Query().Where(elem => elem.tooltip == "").ForEach(elem => elem.tooltip="This is a tooltip!");
```

## Best practices

Consider the following when you use UQuery:

-   UQuery traverses through the hierarchy to find elements by name, class or type. Cache results from UQuery at initialization.
-   To find ancestor elements or check parent-child relationships, manually traverse up the `.parent` chain until you find the target element or reach null.
-   If you need to retrieve multiple elements, use the `QueryState` struct (returned by the `element.Query()` method) and enumerate it to avoid creating lists. You can also construct a query once and execute it on different elements.
-   UI Toolkit doesn’t destroy visual elements that are no longer needed, it uses C# garbage collector to collect them. Be mindful to not accidentally retain references to visual elements in a class that outlives the UIDocuments or Window where the elements came from.
-   When you create or release lots of elements, enable [incremental garbage collection](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html) to avoid garbage collector spikes.
-   Capture `VisualElement` variables inside closures. When you use event callbacks or delegates with visual elements, capture the specific elements you need in local variables before creating the closure. This prevents the closure from capturing a larger scope (like the entire `this` reference) which can lead to memory leaks. For example:

``` lang-cs
  // Good: Capture only what you need.
  var button = root.Q<Button>("myButton");
  button.clicked += () => Debug.Log($"Button {button.name} clicked");
  
  // Avoid: This captures the entire 'this' reference.
  button.clicked += () => Debug.Log($"Button {this.myButton.name} clicked");
```

## Additional resources

-   [USS selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors.html)
-   [Introduction to visual elements and visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html)
-   [Load UXML and USS from C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html)
-   [Instantiate UXML with C#](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LoadingUXMLcsharp.html)
