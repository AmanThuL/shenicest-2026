---
title: "Odin Inspector 4.0.2.3: Odin serializer types (not used in this project)"
source_files: ["Assets/Plugins/Sirenix/Assemblies/Sirenix.Serialization.xml"]
odin_version: "4.0.2.3"
publisher: "Sirenix (Odin Inspector XML documentation shipped with the DLLs)"
generated: "2026-08-24"
generator: "docs/reference/_tools/build_odin_reference.py"
topic: "third-party/odin-inspector"
---

> Generated file — do not edit by hand. Re-run the generator after an Odin upgrade.


# Odin Inspector 4.0.2.3 — Odin serializer types

Documented so that agents recognise them. **This project does not use the Odin serializer** — guideline 12 forbids `SerializedMonoBehaviour`, `SerializedScriptableObject`, `[OdinSerialize]` and everything in `Sirenix.Serialization`; Unity's own serializer is the source of truth.

### `SerializedMonoBehaviour`

*Full name:* `Sirenix.OdinInspector.SerializedMonoBehaviour`

A Unity MonoBehaviour which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `SerializedScriptableObject`

*Full name:* `Sirenix.OdinInspector.SerializedScriptableObject`

A Unity ScriptableObject which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `SerializedBehaviour`

*Full name:* `Sirenix.OdinInspector.SerializedBehaviour`

A Unity Behaviour which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `SerializedComponent`

*Full name:* `Sirenix.OdinInspector.SerializedComponent`

A Unity Component which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `SerializedStateMachineBehaviour`

*Full name:* `Sirenix.OdinInspector.SerializedStateMachineBehaviour`

A Unity StateMachineBehaviour which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `SerializedUnityObject`

*Full name:* `Sirenix.OdinInspector.SerializedUnityObject`

A Unity ScriptableObject which is serialized by the Sirenix serialization system.

**Methods**

- `OnAfterDeserialize()` — Invoked after deserialization has taken place.
- `OnBeforeSerialize()` — Invoked before serialization has taken place.

### `OdinSerializeAttribute`

*Full name:* `Sirenix.Serialization.OdinSerializeAttribute`

Indicates that an instance field or auto-property should be serialized by Odin.

### `PreviouslySerializedAsAttribute`

*Full name:* `Sirenix.Serialization.PreviouslySerializedAsAttribute`

Indicates that an instance field or auto-property was previously serialized with a different name, so that values serialized with the old name will be properly deserialized into this member.

This does the same as Unity's FormerlySerializedAs attribute, except it can also be applied to properties.

**Constructors**

- `PreviouslySerializedAsAttribute(string)`
  - `name` — The former name.

**Fields / properties**

- `Name` — The former name.

### `SerializationUtility`

*Full name:* `Sirenix.Serialization.SerializationUtility`

Provides an array of utility wrapper methods for easy serialization and deserialization of objects of any type.

**Methods**

- `CreateWriter(Stream, SerializationContext, DataFormat)` — Creates an `IDataWriter` for a given format.
- `CreateReader(Stream, DeserializationContext, DataFormat)` — Creates an `IDataReader` for a given format.
- `SerializeValueWeak(object, IDataWriter)` — Serializes the given value using the given writer.
- `SerializeValueWeak(object, IDataWriter, Object}@)` — Serializes the given value, using the given writer.
- `SerializeValue``1(``0, IDataWriter)` — Serializes the given value using the given writer.
- `SerializeValue``1(``0, IDataWriter, Object}@)` — Serializes the given value, using the given writer.
- `SerializeValueWeak(object, Stream, DataFormat, SerializationContext)` — Serializes the given value to a given stream in the specified format.
- `SerializeValueWeak(object, Stream, DataFormat, Object}@, SerializationContext)` — Serializes the given value to a given stream in the specified format.
- `SerializeValue``1(``0, Stream, DataFormat, SerializationContext)` — Serializes the given value to a given stream in the specified format.
- `SerializeValue``1(``0, Stream, DataFormat, Object}@, SerializationContext)` — Serializes the given value to a given stream in the specified format.
- `SerializeValueWeak(object, DataFormat, SerializationContext)` — Serializes the given value using the specified format, and returns the result as a byte array.
- `SerializeValueWeak(object, DataFormat, Object}@)` — Serializes the given value using the specified format, and returns the result as a byte array.
- `SerializeValue``1(``0, DataFormat, SerializationContext)` — Serializes the given value using the specified format, and returns the result as a byte array.
- `SerializeValue``1(``0, DataFormat, Object}@, SerializationContext)` — Serializes the given value using the specified format and returns the result as a byte array.
- `DeserializeValueWeak(IDataReader)` — Deserializes a value from the given reader. This might fail with primitive values, as they don't come with metadata.
- `DeserializeValueWeak(IDataReader, Object})` — Deserializes a value from the given reader, using the given list of Unity objects for external index reference resolution. This might fail with primitive values, as they don't come with type metadata.
- `DeserializeValue``1(IDataReader)` — Deserializes a value from the given reader.
- `DeserializeValue``1(IDataReader, Object})` — Deserializes a value of a given type from the given reader, using the given list of Unity objects for external index reference resolution.
- `DeserializeValueWeak(Stream, DataFormat, DeserializationContext)` — Deserializes a value from the given stream in the given format. This might fail with primitive values, as they don't come with type metadata.
- `DeserializeValueWeak(Stream, DataFormat, Object}, DeserializationContext)` — Deserializes a value from the given stream in the given format, using the given list of Unity objects for external index reference resolution. This might fail with primitive values, as they don't come with type metadata.
- `DeserializeValue``1(Stream, DataFormat, DeserializationContext)` — Deserializes a value of a given type from the given stream in the given format.
- `DeserializeValue``1(Stream, DataFormat, Object}, DeserializationContext)` — Deserializes a value of a given type from the given stream in the given format, using the given list of Unity objects for external index reference resolution.
- `DeserializeValueWeak(Byte[], DataFormat, DeserializationContext)` — Deserializes a value from the given byte array in the given format. This might fail with primitive values, as they don't come with type metadata.
- `DeserializeValueWeak(Byte[], DataFormat, Object})` — Deserializes a value from the given byte array in the given format, using the given list of Unity objects for external index reference resolution. This might fail with primitive values, as they don't come with type metadata.
- `DeserializeValue``1(Byte[], DataFormat, DeserializationContext)` — Deserializes a value of a given type from the given byte array in the given format.
- `DeserializeValue``1(Byte[], DataFormat, Object}, DeserializationContext)` — Deserializes a value of a given type from the given byte array in the given format, using the given list of Unity objects for external index reference resolution.
- `CreateCopy(object)` — Creates a deep copy of an object. Returns null if null. All Unity objects references will remain the same - they will not get copied. Similarly, strings are not copied, nor are reflection types such as System.Type, or types derived from System.Reflection.MemberInfo, System.Reflection.Assembly or System.Reflection.Module.

### `UnitySerializationUtility`

*Full name:* `Sirenix.Serialization.UnitySerializationUtility`

Provides an array of utility wrapper methods for easy serialization and deserialization of Unity objects of any type. Note that, during serialization, it is always assumed that we are running on Unity's main thread. Deserialization can happen on any thread, and all API's interacting with deserialization are thread-safe.

Note that setting the IndexReferenceResolver on contexts passed into methods on this class will have no effect, as it will always be set to a UnityReferenceResolver.

**Fields / properties**

- `SBP_ContentPipelineType` — From the new scriptable build pipeline package
- `ForceEditorModeSerialization` — Whether to always force editor mode serialization. This member only exists in the editor.

**Methods**

- `GetRegisteredPrefabModifications(Object)` — Not yet documented.
- `OdinWillSerialize(MemberInfo, bool, ISerializationPolicy)` — Checks whether Odin will serialize a given member.
- `GuessIfUnityWillSerialize(MemberInfo)` — Guesses whether or not Unity will serialize a given member. This is not completely accurate.
- `GuessIfUnityWillSerialize(Type)` — Guesses whether or not Unity will serialize a given type. This is not completely accurate.
- `SerializeUnityObject(Object, SerializationData@, bool, SerializationContext)` — Not yet documented.
- `SerializeUnityObject(Object, String@, Object}@, DataFormat, bool, SerializationContext)` — Not yet documented.
- `SerializeUnityObject(Object, Byte[]@, Object}@, DataFormat, bool, SerializationContext)` — Not yet documented.
- `SerializeUnityObject(Object, IDataWriter, bool)` — Not yet documented.
- `DeserializeUnityObject(Object, SerializationData@, DeserializationContext)` — Not yet documented.
- `DeserializeUnityObject(Object, String@, Object}@, DataFormat, DeserializationContext)` — Not yet documented.
- `DeserializeUnityObject(Object, Byte[]@, Object}@, DataFormat, DeserializationContext)` — Not yet documented.
- `DeserializeUnityObject(Object, IDataReader)` — Not yet documented.
- `SerializePrefabModifications(PrefabModification}, Object}@)` — Not yet documented.
- `DeserializePrefabModifications(String}, Object})` — Not yet documented.
- `RegisterPrefabModificationsChange(Object, PrefabModification})` — Not yet documented.
- `CreateDefaultUnityInitializedObject(Type)` — Creates an object with default values initialized in the style of Unity; strings will be "", classes will be instantiated recursively with default values, and so on.
