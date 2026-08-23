---
title: "Scripting API: SerializeReference"
page_title: "Unity - Scripting API: SerializeReference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# SerializeReference

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Marks a field to be serialized as a reference instead of as a value.

See the [serialization manual page](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html) for information about serialization and the complete serialization rules.  
  
Without the use of the `[SerializeReference]` attribute, Unity serializes each of the fields of an object by value or by reference, depending on the field's type, and according to these serialization rules:

-   **UnityEngine.Object fields, by reference:**  
    If the field type is derived from UnityEngine.Object, Unity serializes it as a reference to that object. For example, a [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) that defines a [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) field. Fields that reference a UnityEngine.Object like this do not require the SerializeReference attribute, because the serialization for the field always records the reference to an independently-serialized object.  
      
-   **Other field types, by value:**  
    If the field type is one that Unity can automatically serialize by value (simple field types, such as int, string, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html), etc), or if it is a custom serializable class or structure marked with the `[Serializable]` attribute, it is serialized as a value.

In the case of a custom serializable class, this means it serializes only the *data belonging to the object* assigned to the field, rather than a reference to the object itself. To force Unity to serialize these field types as a reference, use the `[SerializeReference]` attribute.  
  
You might want to serialize as a reference rather than a value when:  

-   **You want multiple references to the same instance of a custom serializable class.**  
    For example, reference serialization is necessary for reference-based topologies based on custom serializable classes (such as linked lists, tree structures, or cyclical graphs). This is because the default value-based serialization stores each reference as a separate copy of the object, when fields originally shared a single reference to the same object. In particular, if you serialize a cyclical graph data structure, you must use SerializeReference to preserve the graph properly and to avoid potential freezes or crashes that can arise from the default serialization approach.  
      
-   **You want to use polymorphism on fields whose type is a custom serializable class.**  
    If you try to use [polymorphism](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/polymorphism) on custom serializable classes without the `[SerializeReference]` attribute, your derived classes' additional fields won't be preserved, and your object will instead be serialized as if it was the field's declared type. You can see polymorphism in the `SerializeReferencePolymorphismExample` class below.  
      
-   **You want to serialize null values.**  
    Value-based serialization can't represent null. Without the use of SerializeReference, null values are replaced with an inline object that has unassigned fields in the serialized data. Using SerializeReference allows you to store null references.

**Optimization**  
  
By-value serialization is more efficient than using SerializeReference in terms of storage, memory, and loading and saving time, so you should only use SerializeReference in situations which require it.  
  
**The host object and managed references**  
  
In the context of SerializeReference, your object which specializes [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html), [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html), [ScriptedImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetImporters.ScriptedImporter.html) or other UnityEngine class is called the **host object**. You can use SerializeReference directly on fields of the host object, or indirectly on fields of custom structures or classes that are serialized within the host object.  
  
The objects assigned to fields with the `[SerializeReference]` attribute in the host object are **managed references**. Each managed reference has a unique ID, which the MonoBehaviour, ScriptableObject or other host object that contains the `[SerializeReference]` fields associated with it. By default, Unity generates this ID automatically; to specify an ID, use [ManagedReferenceUtility.SetManagedReferenceIdForObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.ManagedReferenceUtility.SetManagedReferenceIdForObject.html).  
  
When you use SerializeReference, the managed reference objects are only available as shared references within the host object in which they are defined. When a host object is serialized, any managed reference objects are serialized in the "references" section of the serialized data, which is a list located after the serialization of the regular fields. Each managed reference object has an entry in the list, recording its ID, its fully qualified class name, and the value of its fields.  
  
You can see this serialized data for yourself if you're using the default "force text" [asset serialization mode](https://docs.unity3d.com/6000.3/Documentation/Manual/class-EditorManager.html). To do this, assign one of the sample scripts below to a GameObject, save the scene, then open the `.unity` scene file in a text editor. Each managed reference's data is stored in the `.unity` file, under the "references:" section of the serialized MonoBehaviour data.  
  
The managed references are not shared between other UnityEngine.Object instances. If you assign the same custom serializable class object to fields on two different host objects, the serialized references will become separate instances. In addition, if you clone a host object with managed references, this also creates separate copies of all the managed reference objects.  
  
To share referenced values between multiple host objects, use [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) instead of SerializeReference. ScriptableObject allows you to group a related set of data together as an asset. Because ScriptableObject is derived from UnityEngine.Object, you can share references to them outside of an individual host object. The serialization rules still apply to the fields on the ScriptableObject however, so you may need to use the `[SerializeReference]` attribute on fields within your ScriptableObject-derived class.  
  
**The SerializeReference attribute is supported on fields whose type is any of the following:**

-   A regular class
-   An abstract class
-   An interface
-   System.Object

**The value assigned to a field with the SerializeReference attribute must, unless it is null, follow these rules:**

-   Must be an instance of a custom class, with the \[Serializable\] attribute.
-   Must be an instance of the field's type, or a type that derives from that type.
-   Must not derive from UnityEngine.Object. For example it cannot be a GameObject, MonoBehaviour, ScriptableObject or Transform.
-   Must not be a C# [Value type](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-types). Therefore simple types like integers, as well as structures are not supported, and should be serialized without the `[SerializeReference]` attribute instead.
-   Must not be a C# Dictionary, or other type that is not supported by Unity serialization

**Notes on the use of SerializeReference with arrays and lists:**

-   Unity supports serializing arrays and lists of objects by reference.
-   For array and `List<T>` fields, the SerializeReference attribute applies to the elements of the array or list and not to the array or list object itself.
-   You cannot assign an array or list to a field of type System.Object. Instead the field type needs to be explicitly declared as an array or list.  
    This is demonstrated in this example:  
      
    `[SerializeReference] public System.Object a = new List<MyCustomClass>(); // UNSUPPORTED`  
    `[SerializeReference] public List<MyCustomClass> a = new List<MyCustomClass>(); // VALID`

**Other Notes:**

-   Animation is not supported on fields of referenced objects when the host object derives from ScriptableObject or ScriptedImporter.
-   When types referred to by SerializeReference are no longer available when deserializing, Unity replaces the instance with null, but the serialized information is preserved. for more information see [SerializationUtility.HasManagedReferencesWithMissingTypes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializationUtility.HasManagedReferencesWithMissingTypes.html)

See Also: [SerializedProperty.managedReferenceValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty-managedReferenceValue.html), [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html), [SerializationUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializationUtility.html), [ManagedReferenceUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.ManagedReferenceUtility.html).  
  

``` codeExampleCS
using System;
using UnityEngine;

public class SerializeReferencePolymorphismExample : MonoBehaviour

    [Serializable]
    public class Apple : Base
    
    [Serializable]
    public class Orange : Base
    
    // Use SerializeReference if this field needs to hold both
    // Apples and Oranges.  Otherwise only m_Data from Base object would be serialized
    [SerializeReference]
    public Base m_Item = new Apple();

    [SerializeReference]
    public Base m_Item2 = new Orange();

    // Use by-value instead of SerializeReference, because
    // no polymorphism and no other field needs to share this object
    public Apple m_MyApple = new Apple();
}
```

``` codeExampleCS
using System;
using System.Text;
using UnityEngine;

public class SerializeReferenceLinkedListExample : MonoBehaviour

    [SerializeReference]
    public Node m_Front = null;

    // Points to the last node in the list.  This is an
    // example of a having more than one field pointing to a single Node
    // object, which cannot be done with "by-value" serialization
    [SerializeReference]
    public Node m_End = null;

    SerializeReferenceLinkedListExample()
    
    private void AddEntry(int data)
    {
        if (m_Front == null)
        {
            m_Front = new Node() {m_Data = data};
            m_End = m_Front;
        }
        else
        {
            m_End.m_Next = new Node() {m_Data = data};
            m_End = m_End.m_Next;
        }
    }

    private void PrintList()
    
        Debug.Log(sb.ToString());
    }
}
```

``` codeExampleCS
using System;
using System.Collections.Generic;
using UnityEngine;

public interface IShape 
[Serializable]
public class Cube : IShape

[Serializable]
public class Thing

[ExecuteInEditMode]
public class BuildingBlocks : MonoBehaviour

            };
            Debug.Log("Created list");
        }
        else
            Debug.Log("Read list");

        if (bins == null)
        {
            // This is supported, the 'bins' serialized field is declared as a collection, with each entry as a reference.
            bins = new List<System.Object>() { new Cube(), new Thing() };
        }

        if (bin == null)
        {
            // !! DO NOT USE !!
            // Although this is syntactically correct, it is not supported as a valid serialization construct because the 'bin' serialized field is declared as holding a single reference type.
            bin = new List<System.Object>() { new Cube() };
        }
    }
}
```
