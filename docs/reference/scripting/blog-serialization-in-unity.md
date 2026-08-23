---
title: "Serialization in Unity (Unity Blog)"
page_title: "Serialization in Unity"
source_url: "https://unity.com/blog/engine-platform/serialization-in-unity"
final_url: "https://unity.com/blog/engine-platform/serialization-in-unity"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Serialization in Unity

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Serialization in Unity

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">LUCAS MEIJER / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Contributor</span>

<span class="mr-2">Jun 24, 2014</span><span class="mr-2">\|</span><span class="mr-2">11 Min</span>

Programming and DevOps

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the spirit of sharing more of the tech behind the scenes, and reasons why some things are the way they are, this post contains an overview of Unity's serialization system. Understanding this system very well can have a big impact on the effectiveness of your development, and the performance of the things you make. Here we go.

Serialization of “things” is at the very core of Unity. Many of our features build ontop of the serialization system:

-   **Storing data stored in your scripts.** This one most people are probably somewhat familiar with.
-   Inspector window. The inspector window doesn’t talk to the C# api to figure out what the values of the properties of whatever it is inspecting is. It asks the object to serialize itself, and then displays the serialized data.
-   **Prefabs.** Internally, a prefab is the serialized data stream of one (or more) game objects and components. A prefab instance is a list of modifications that should be made on the serialized data for this instance. The concept prefab actually only exists at editor time. The prefab modifications get baked into a normal serialization stream when Unity makes a build, and when that gets instantiated, the instantiated gameobjects have no idea they were a prefab when they lived in the editor.
-   **Instantiation.** When you call Instantiate() on either a prefab, or a gameobject that lives in the scene, or on anything else for that matter (everything that derives from UnityEngine.Object can be serialized), we serialize the object, then create a new object, and then we “deserialize” the data onto the new object. (We then run the same serialization code again in a different variant, where we use it to report which other UnityEngine.Object’s are being referenced. We then check for all referenced UnityEngine.Object’s if they are part of the data being Instantiated(). If the reference is pointing to something “external” (like a texture) we keep that reference as it is, if it is pointing to something "internal" (like a child gameobject), we patch the reference to the corresponding copy).
-   **Saving.** If you open a .unity scene file with a text editor, and have set unity to “force text serialization”, we run the serializer with a yaml backend.
-   **Loading.** Might not seem surprising, but backwards compatible loading is a system that is built on top of serialization as well. In-editor yaml loading uses the serialization system, as well as the runtime loading of scenes and assets. Assetbundles also make use of the serialization system.
-   **Hot reloading of editor code.** When you change an editor script, we serialize all editor windows (they derive from UnityEngine.Object!), we then destroy all the windows, unload the old c# code, load the new c# code, recreate the windows, and finally deserialize the datastreams of the windows back onto the new windows.
-   **Resource.GarbageCollectSharedAssets().** This is our native garbage collector and is different to the C# garbage collector. It is the thing that we run after you load a scene to figure out which things from the previous scene are no longer referenced, so we can unload them. The native garbage collector runs the serializer in a mode where we use it to have objects report all references to external UnityEngine.Objects. This is what makes textures that were used by scene1, get unloaded when you load scene2.

The serialization system is written in C++, we use it for all our internal object types (Textures, AnimationClip, Camera, etc). Serialization happens at the UnityEngine.Object level, each UnityEngine.Object is always serialized as a whole. They can contain references to other UnityEngine.Objects and those references get serialized properly.

Now you may say that none of this concerns you very much, you’re just happy that it works and want to get on with actually creating some content. However, this will concern you, as we use this same serializer to serialize MonoBehaviour components, which are backed by your scripts. Because of the very high performance requirements that the serializer has, it does not in all cases behave exactly like what a C# developer would expect from a serializer. Here we’ll describe how the serializer works and some best practices on how to make the best use of it.

**What does a field of my script need to be in order to be serialized?**

-   Be public, or have \[SerializeField\] attribute
-   Not be static
-   Not be const
-   Not be readonly
-   The fieldtype needs to be of a type that we can serialize.

**Which fieldtypes can we serialize?**

-   Custom non abstract classes with \[Serializable\] attribute.
-   Custom structs with \[Serializable\] attribute. (new in Unity4.5)
-   References to objects that derive from UntiyEngine.Object
-   Primitive data types (int,float,double,bool,string,etc)
-   Array of a fieldtype we can serialize
-   List\<T> of a fieldtype we can serialize

**So far so good. So what are these situations where the serializer behaves differently from what I expect?**

**Custom classes behave like structs**

\[Serializable\]  
class Animal  

class MyScript : MonoBehaviour  

If you populate the animals array with three references to a single Animal object, in the serializationstream you will find 3 objects. When it’s deserialized, there are now three different objects. If you need to serialize a complex object graph with references, you cannot rely on Unity’s serializer doing that all automagically for you, and have to do some work to get that object graph serialized yourself. See the example below on how to serialize things Unity doesn't serialize by itself.

Note that this is only true for custom classes, as they are serialized “inline” because their data becomes part of the complete serializationdata for the MonoBehaviour they are used in. When you have fields that have a reference to something that is a UnityEngine.Object derived class, like a “public Camera myCamera”, the data from that camera are not serialized inline, and an actual reference to the camera UnityEngine.Object is serialized.

**No support for null for custom classes**

Pop quiz. How many allocations are made when deserializing a MonoBehaviour that uses this script:

class Test : MonoBehaviour  

\[Serializable\]  
class Trouble  

It wouldn’t be strange to expect 1 allocation, that of the Test object. It also wouldn’t be strange to expect 2 allocations, one for the Test object and one for a Trouble object. The correct answer is 729. The serializer does not support null. If it serializes an object and a field is null, we just instantiate a new object of that type and serialize that. Obviously this could lead to infinite cycles, so we have a relatively magical depth limit of 7 levels. At that point we just stop serializing fields that have types of custom classes/structs and lists and arrays. \[1\]

Since so many of our subsystems build on top of the serialization system, this unexpectedly big serializationstream for the Test monobehaviour will cause all these subsystems to perform more slowly than necessary. When we investigate performance problems in customer projects, we almost always find this problem and we added a warning for this situation in Unity 4.5. We actually messed up the warning implementation in such a way that it gives you so many warnings, you have no other option but to fix them right away. We'll soon ship a fix for this in a patch release, the warning is not gone, but you will only get one per "entering playmode", so you don't get spammed crazy. You'd still want to fix your code, but you should be able to do it at a time where it suits you.

**No support for polymorphism**

If you have a

public Animal\[\] animals

and you put in an instance of a dog, a cat and a giraffe, after serialization, you will have three instances of Animal.

One way to deal with this limitation is to realize that it only applies to “custom classes”, which get serialized inline. References to other UnityEngine.Object’s get serialized as actual references and for those, polymorphism does actually work. You’d make a ScriptableObject derived class or another MonoBehaviour derived class, and reference that. The downside of doing this, is that you need to store that monobehaviour or scriptable object somewhere and cannot serialize it inline nicely.

The reason for these limitations is that one of the core foundations of the serialization system is that the layout of the datastream for an object is known ahead of time, and depends on the types of the fields of the class, instead of what happens to be stored inside the fields.

**I want to serialize something that Unity's serializer doesn't support. What do I do?**

In many cases the best approach is to use serialization callbacks. They allow you to be notified before the serializer reads data from your fields and after it is done writing to them. You can use this to have a different representation of your hard-to-serialize data at runtime than when you actually serialize. You’d use these to transform your data into something Unity understands right before Unity wants to serialize it, you also use it to transform the serialized form back into the form you'd like to have your data in at runtime, right after Unity has written the data to your fields.

Let’s say you want to have a tree datastructure. If you let Unity directly serialize the data structure, the “no support for null” limitation would cause your datastream to become very big, leading to performance degradations in many systems:

using UnityEngine;  
using System.Collections.Generic;  
using System;  
  
public class VerySlowBehaviourDoNotDoThis : MonoBehaviour  

//this gets serialized  
public Node root = new Node();  
  
void OnGUI()  

void Display(Node node)  

}  

Instead, you tell Unity not to serialize the tree directly, and you make a seperate field to store the tree in a serialized format, suited for Unity’s serializer:

using UnityEngine;  
using System.Collections.Generic;  
using System;  
  
public class BehaviourWithTree : MonoBehaviour, ISerializationCallbackReceiver  

//node class that we will use for serialization  
\[Serializable\]  
public struct SerializableNode  

//the root of what we use at runtime. not serialized.  
Node root = new Node();  
  
//the field we give unity to serialize.  
public List\<SerializableNode> serializedNodes;  
  
public void OnBeforeSerialize()  

void AddNodeToSerializedNodes(Node n)  
{  
var serializedNode = new SerializableNode () {  
interestingValue = n.interestingValue,  
childCount = n.children.Count,  
indexOfFirstChild = serializedNodes.Count+1  
};  
  
serializedNodes.Add (serializedNode);  
foreach (var child in n.children)  
AddNodeToSerializedNodes (child);  
}  
  
public void OnAfterDeserialize()  

Node ReadNodeFromSerializedNodes(int index)  
{  
var serializedNode = serializedNodes \[index\];  
var children = new List\<Node> ();  
for(int i=0; i!= serializedNode.childCount; i++)  
children.Add(ReadNodeFromSerializedNodes(serializedNode.indexOfFirstChild + i));  
  
return new Node() {  
interestingValue = serializedNode.interestingValue,  
children = children  
};  
}  
  
void OnGUI()  

void Display(Node node)  

}  

Beware that the serializer, including these callbacks coming from the serializer, usually do not run on the main thread, so you are very limited in what you can do in terms of invoking Unity API. (Serialization happening as part of loading a scene happens on a loading thread. Serialization happening as part of you invoking Instantiate() from script happens on the main thread). You can however do the necessary data transformations do get your data from a non-unity-serializer-friendly format to a unity-serializer-friendly-format.

You made it to the end!

Thanks for reading this far, hope you can put some of this information to good use in your projects.

Bye, Lucas. ([@lucasmeijer](https://twitter.com/lucasmeijer))

PS: We'll add all this information to the documentation as well.

\[1\] I lied, the correct answer isn't actually 729. This is because in the very very old days before we had this 7 level depth limit, Unity would just endless loop, and then run out of memory if you created a script like the Trouble one I just wrote. Our very first fix for that 5 years ago was to just not serialize fieldtypes that were of the same type as the class itself. Obviously, this was not the most robust fix, as it's easy to create a cycle using Trouble1->Trouble2->Trouble1->Trouble2 class. So shortly afterwards we actually implemented the 7 level depth limit to catch those cases too. For the point I'm trying to make however it doesn't matter, what matters is that you realize that if there is a cycle you are in trouble.
