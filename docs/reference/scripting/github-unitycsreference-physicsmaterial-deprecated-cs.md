---
title: "UnityCsReference 6000.3: PhysicsMaterial.deprecated.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/PhysicsMaterial.deprecated.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/PhysicsMaterial.deprecated.cs"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# UnityCsReference 6000.3: PhysicsMaterial.deprecated.cs

```cs
// Unity C# reference source
// Copyright (c) Unity Technologies. For terms of use, see
// https://unity3d.com/legal/licenses/Unity_Reference_Only_License

using System;

namespace UnityEngine
{
    // Describes how physics materials of colliding objects are combined.
    [Obsolete("PhysicMaterialCombine has been renamed to PhysicsMaterialCombine. Please use PhysicsMaterialCombine instead. (UnityUpgradable) -> PhysicsMaterialCombine", true)]
    public enum PhysicMaterialCombine
    {
        Average = 0,
        Minimum = 2,
        Multiply = 1,
        Maximum = 3
    }

    [Obsolete("PhysicMaterial has been renamed to PhysicsMaterial. Please use PhysicsMaterial instead. (UnityUpgradable) -> PhysicsMaterial", true)]
    [NativeClass(null)]
    public class PhysicMaterial : UnityEngine.Object
    {
        public PhysicMaterial() { }
        public PhysicMaterial(string name) { }

        public float bounciness { get; set; }
        public float dynamicFriction { get; set; }
        public float staticFriction { get; set; }
        public PhysicMaterialCombine frictionCombine { get; set; }
        public PhysicMaterialCombine bounceCombine { get; set; }

        [Obsolete("Use PhysicMaterial.bounciness instead (UnityUpgradable) -> bounciness")]
        public float bouncyness { get; set; }
    }
}
```
