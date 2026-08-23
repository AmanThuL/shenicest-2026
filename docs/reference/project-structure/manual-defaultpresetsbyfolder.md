---
title: "Apply default presets to assets by folder"
page_title: "Unity - Manual: Apply default presets to assets by folder"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DefaultPresetsByFolder.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DefaultPresetsByFolder.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Apply default presets to assets by folder

For large projects, you might use several presets for importing the same type of asset. For example, you might have a preset for importing default textures and another for lightmap textures. You can have separate subfolders in the `Assets` folder for each texture type and each subfolder can have its own preset that applies for its contents. The following screenshot illustrates this setup:

![The *TexturesDefault* and *TexturesLighting* folders each have a Preset](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/PresetsByFolder.png)

The following example applies a preset based on an asset’s location, with the following logic:

-   Apply the preset that is in the same folder as the asset.
-   If there is no preset in the folder, apply the preset from a parent folder.
-   If there are no presets in parent folders, apply the default preset configured in the [Preset Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PresetManager.html) window.

To use this example, create a new folder named `Editor` in the Project window, create a new C# Script in this folder, then copy and paste the code:

``` lang-cs
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.Experimental;
using UnityEditor.Presets;
using UnityEngine;
namespace PresetsPerFolder

        }
        void ApplyPresetsFromFolderRecursively(string folder)
        {
            // Apply Presets in order starting from the parent folder to the Asset so that the Preset closest to the Asset is applied last.
            var parentFolder = Path.GetDirectoryName(folder);
            if (!string.IsNullOrEmpty(parentFolder))
                ApplyPresetsFromFolderRecursively(parentFolder);
            // Add a dependency to the folder Preset custom key
            // so whenever a Preset is added to or removed from this folder, the Asset is re-imported.
            context.DependsOnCustomDependency($"PresetPostProcessor_{folder}");
            // Find all Preset Assets in this folder. Use the System.Directory method instead of the AssetDatabase
            // because the import may run in a separate process which prevents the AssetDatabase from performing a global search.
            var presetPaths =
                Directory.EnumerateFiles(folder, "*.preset", SearchOption.TopDirectoryOnly)
                    .OrderBy(a => a);
            foreach (var presetPath in presetPaths)
            
            }
        }
        /// <summary>
        /// This method with the didDomainReload argument will be called every time the project is being loaded or the code is compiled.
        /// It is very important to set all of the hashes correctly at startup
        /// because Unity does not apply the OnPostprocessAllAssets method to previously imported Presets
        /// and the CustomDependencies are not saved between sessions and need to be rebuilt every time.
        /// </summary>
        private static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets,
            string[] movedFromAssetPaths, bool didDomainReload)
        {
            if (didDomainReload)
            {
                // AssetDatabase.FindAssets uses a glob filter to avoid importing all objects in the project.
                // This glob search only looks for .preset files.
                var allPaths = AssetDatabase.FindAssets("glob:\"**.preset\"")
                    .Select(AssetDatabase.GUIDToAssetPath)
                    .OrderBy(a => a)
                    .ToList();
                bool atLeastOnUpdate = false;
                string previousPath = string.Empty;
                Hash128 hash = new Hash128();
                for (var index = 0; index < allPaths.Count; index++)
                {
                    var path = allPaths[index];
                    var folder = Path.GetDirectoryName(path);
                    if (folder != previousPath)
                    {
                        // When a new folder is found, create a new CustomDependency with the Preset name and the Preset type.
                        if (previousPath != string.Empty)
                        {
                            AssetDatabase.RegisterCustomDependency($"PresetPostProcessor_{previousPath}", hash);
                            atLeastOnUpdate = true;
                        }
                        hash = new Hash128();
                        previousPath = folder;
                    }
                    // Append both path and Preset type to make sure Assets get re-imported whenever a Preset type is changed.
                    hash.Append(path);
                    hash.Append(AssetDatabase.LoadAssetAtPath<Preset>(path).GetTargetFullTypeName());
                }
                // Register the last path.
                if (previousPath != string.Empty)
                {
                    AssetDatabase.RegisterCustomDependency($"PresetPostProcessor_{previousPath}", hash);
                    atLeastOnUpdate = true;
                }
                // Only trigger a Refresh if there is at least one dependency updated here.
                if (atLeastOnUpdate)
                    AssetDatabase.Refresh();
            }
        }
    }
    /// <summary>
    /// InitPresetDependencies:
    /// This method is called when the project is loaded. It finds every imported Preset in the project.
    /// For each folder containing a Preset, create a CustomDependency from the folder name and a hash from the list of Preset names and types in the folder.
    ///
    /// OnAssetsModified:
    /// Whenever a Preset is added, removed, or moved from a folder, the CustomDependency for this folder needs to be updated
    /// so Assets that may depend on those Presets are reimported.
    ///
    /// TODO: Ideally each CustomDependency should also be dependent on the PresetType,
    /// so Textures are not re-imported by adding a new FBXImporterPreset in a folder.
    /// This makes the InitPresetDependencies and OnPostprocessAllAssets methods too complex for the purpose of this example.
    /// Unity suggests having the CustomDependency follow the form "Preset_{presetType}_{folder}",
    /// and the hash containing only Presets of the given presetType in that folder.
    /// </summary>
    public class UpdateFolderPresetDependency : AssetsModifiedProcessor
    
            }
            foreach (var asset in addedAssets)
            
            }
            foreach (var asset in deletedAssets)
            
            }
            foreach (var movedAsset in movedAssets)
            
                if (movedAsset.sourceAssetPath.EndsWith(".preset"))
                
            }
            // Do not add a dependency update for no reason.
            if (folders.Count != 0)
            {
                // The dependencies need to be updated outside of the AssetPostprocessor calls.
                // Register the method to the next Editor update.
                EditorApplication.delayCall += () =>
                {
                    DelayedDependencyRegistration(folders);
                };
            }
        }
        /// <summary>
        /// This method loads all Presets in each of the given folder paths
        /// and updates the CustomDependency hash based on the Presets currently in that folder.
        /// </summary>
        static void DelayedDependencyRegistration(HashSet<string> folders)
        {
            foreach (var folder in folders)
            {
                var presetPaths =
                    AssetDatabase.FindAssets("glob:\"**.preset\"", new[] { folder })
                        .Select(AssetDatabase.GUIDToAssetPath)
                        .Where(presetPath => Path.GetDirectoryName(presetPath) == folder)
                        .OrderBy(a => a);
                Hash128 hash = new Hash128();
                foreach (var presetPath in presetPaths)
                
                AssetDatabase.RegisterCustomDependency($"PresetPostProcessor_{folder}", hash);
            }
            // Manually trigger a Refresh
            // so that the AssetDatabase triggers a dependency check on the updated folder hash.
            AssetDatabase.Refresh();
        }
    }
}
```

## Additional resources

-   [Creating and using presets](https://docs.unity3d.com/6000.3/Documentation/Manual/presets-creating-using.html)
-   [Supporting presets for custom types](https://docs.unity3d.com/6000.3/Documentation/Manual/SupportingPresets.html)
