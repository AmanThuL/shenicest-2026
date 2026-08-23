---
title: "Custom serialization"
page_title: "Unity - Manual: Custom serialization"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom serialization

When you want to serialize something that Unity’s serializer doesn’t support (for example, a C# Dictionary) you can implement the [ISerializationCallbackReceiver](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.html) interface in your class. This allows you to implement callbacks that Unity invokes at key points during serialization and deserialization.

You can use serialization callbacks to give your hard-to-serialize data a different representation at runtime than at serialization time. You can transform your data into something Unity understands just before Unity serializes it. After Unity has written the data to your fields, you can transform the serialized data back into the form you want it to have at runtime.

1.  When an object is about to be serialized, Unity invokes the `OnBeforeSerialize()` callback. In this callback you can transform your data into something Unity understands. For example, to serialize a C# Dictionary, copy the data from the Dictionary into an array of keys and an array of values.
2.  After the `OnBeforeSerialize()` callback is complete, Unity serializes the arrays.
3.  Later, when the object is deserialized, Unity invokes the `OnAfterDeserialize()` callback. In this callback you can transform the data back into a form that’s convenient for the object in memory. For example, use the key and value arrays to repopulate the C# Dictionary.

## Performance issues with Unity’s default serialization

If you want to have a tree data structure and you let Unity serialize the data structure directly, the missing support for null limitation causes your data stream to become large. This leads to performance degradations in many systems:

``` lang-cs
using UnityEngine;
using System.Collections.Generic;
using System;

// This example demonstrates why directly serializing a tree
// can lead to performance issues due to Unity's serializer limitations (e.g., no null support, deep copying).
// It's provided to illustrate a problematic pattern, not a recommended one.
public class ProblematicTreeSerialization : MonoBehaviour

    // This root node will be serialized by Unity.
    public Node root = new Node();

}
```

To resolve this issue, you can tell Unity not to serialize the tree directly and create a separate serializable representation of the tree that Unity understands. You can then use the `ISerializationCallbackReceiver` interface to convert between your runtime tree and this serializable format.

``` lang-csharp
using UnityEngine;
using System.Collections.Generic;
using System;

// This example demonstrates how to use ISerializationCallbackReceiver to custom serialize
// a tree structure, avoiding the performance issues of direct serialization shown in ProblematicTreeSerialization.
public class CustomTreeSerialization : MonoBehaviour, ISerializationCallbackReceiver

    // Serializable struct that represents a node for Unity's serializer.
    [Serializable]
    public struct SerializableNode
    
    // The root node used for runtime tree representation. Not directly serialized by Unity.
    private Node root = new Node();

    // This list is the only data Unity will serialize for the tree.
    // It's marked [SerializeField] so Unity's serializer can access it.
    [SerializeField] private List<SerializableNode> serializedNodes = new List<SerializableNode>();

    // Called just before Unity serializes the object.
    public void OnBeforeSerialize()
    
        serializedNodes.Clear(); 
        AddNodeToSerializedNodes(root); 
    }

    // Recursively adds nodes to the 'serializedNodes' list in depth-first order.
    private void AddNodeToSerializedNodes(Node n)
    {
        var serializedNode = new SerializableNode
        {
            interestingValue = n.interestingValue,
            childCount = n.children.Count,
            // The index of the first child will be the current size of 'serializedNodes' + 1
            // (since the current node is added next, and then its children).
            indexOfFirstChild = serializedNodes.Count + 1
        };

        serializedNodes.Add(serializedNode);

        foreach (var child in n.children)
        
    }

    // Called just after Unity deserializes the object.
    public void OnAfterDeserialize()
    
        else
        
    }

    // Recursively reads nodes from 'serializedNodes' and reconstructs the runtime tree.
    // Returns the next index to read from.
    private int ReadNodeFromSerializedNodes(int index, out Node node)
    {
        var serializedNode = serializedNodes[index];

        // Create a new runtime node and transfer data.
        Node newNode = new Node()
        {
            interestingValue = serializedNode.interestingValue,
            children = new List<Node>()
        };

        // The children were serialized immediately after their parent (depth-first).
        // Increment the index and recursively read children.
        int currentIndex = index + 1; 
        for (int i = 0; i < serializedNode.childCount; i++)
        
        node = newNode;
        return currentIndex;
    }

}
```

## Directly serializing a Dictionary

Unity’s default serializer doesn’t support `Dictionary<TKey, TValue>`. By implementing [`ISerializationCallbackReceiver`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ISerializationCallbackReceiver.html), you can convert the dictionary into two `List` instances (one for keys, one for values) before serialization, and then reconstruct the dictionary from these lists after deserialization.

``` lang-csharp
using UnityEngine;
using System;
using System.Collections.Generic;

public class SerializationCallbackScript : MonoBehaviour, ISerializationCallbackReceiver
{
    public List<int> keys = new List<int> { 3, 4, 5 };
    public List<string> values = new List<string> { "I", "Love", "Unity" };

    // Create a Dictionary. The Unity serializer doesn't support Dictionary types.
    public Dictionary<int, string>  myDictionary = new Dictionary<int, string>();

    public void OnBeforeSerialize()
    
    }

    public void OnAfterDeserialize()
    
    void OnGUI()
    
}
```

## Polymorphic deserialization

Unity’s default serializer has limited support for polymorphism with plain C# classes. To serialize a list of objects that inherit from a common base class, you often need to manually store type information and the specific data for each derived type. This example shows how to achieve this using `ISerializationCallbackReceiver`.

``` lang-csharp
using UnityEngine;
using System.Collections.Generic;
using System;

// Base class for polymorphic objects. Not directly serializable by Unity.
public abstract class Animal

    public abstract string GetSound();
}

// Derived class
public class Dog : Animal

    public Dog(string name, int barkVolume)
    
    public override string GetSound() => $"Woof! (Volume: {BarkVolume})";
}

// Derived class
public class Cat : Animal

    public Cat(string name, bool isCute)
    
    public override string GetSound() => $"Meow! (Cute: {IsCute})";
}

// Serializable wrapper struct for Dog's data.
// Marked [Serializable] for Unity.
[Serializable]
public struct SerializableDog

// Serializable wrapper struct for Cat's data.
// Marked [Serializable] for Unity.
[Serializable]
public struct SerializableCat

// Enum to identify the type of animal for deserialization.
public enum AnimalType

// Example demonstrating polymorphic deserialization using ISerializationCallbackReceiver.
// This approach requires manual management of type information during serialization.
public class PolymorphicAnimalSerialization : MonoBehaviour, ISerializationCallbackReceiver
{
    // The runtime list of polymorphic Animal objects. Not directly serialized by Unity.
    public List<Animal> animals = new List<Animal>();

    // These lists store the serializable data for each derived type,
    // along with a list of types to reconstruct the original order.
    // Marked [SerializeField] to be saved by Unity.
    [SerializeField] private List<AnimalType> _animalTypes = new List<AnimalType>();
    [SerializeField] private List<SerializableDog> _dogs = new List<SerializableDog>();
    [SerializeField] private List<SerializableCat> _cats = new List<SerializableCat>();

    // Called just before Unity serializes the object.
    public void OnBeforeSerialize()
    {
        _animalTypes.Clear();
        _dogs.Clear();
        _cats.Clear();

        foreach (var animal in animals)
        {
            if (animal is Dog dog)
            {
                _animalTypes.Add(AnimalType.Dog);
                _dogs.Add(new SerializableDog { name = dog.Name, barkVolume = dog.BarkVolume });
            }
            else if (animal is Cat cat)
            {
                _animalTypes.Add(AnimalType.Cat);
                _cats.Add(new SerializableCat { name = cat.Name, isCute = cat.IsCute });
            }
        }
    }

    // Called just after Unity deserializes the object.
    public void OnAfterDeserialize()
    
                    else
                    
                    break;
                case AnimalType.Cat:
                    if (catIndex < _cats.Count)
                    
                    else
                    
                    break;
            }
        }
    }
}
```

## Additional resources

-   [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html)
-   [How Unity uses serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html)
-   [JSONSerialization](https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html)
-   [Serialization best practices](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html)
