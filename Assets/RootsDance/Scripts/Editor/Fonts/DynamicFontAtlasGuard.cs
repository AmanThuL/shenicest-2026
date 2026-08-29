using System.Collections.Generic;
using System.IO;
using TMPro;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Fonts
{
    /// <summary>
    /// Keeps the runtime-populated atlas of a Dynamic TMP font asset from being written to disk.
    /// <para>
    /// A Dynamic font asset ships as a pointer: the atlas is rasterised on demand while the game
    /// runs and stripped again at build time, so nothing in it is worth keeping. The trouble is
    /// that <c>AssetDatabase.SaveAssets()</c> does not know that. Play mode fills the atlas, the
    /// next blanket save flushes it into the asset, and a 6 KB file becomes several megabytes —
    /// on an LFS-tracked path, where it stays for good. This project has around a hundred
    /// unscoped <c>SaveAssets()</c> calls across its builder tools, so the odds of hitting that
    /// are close to one every session.
    /// </para>
    /// <para>
    /// Rather than scope each of those calls, this drops the affected paths out of the save list
    /// before Unity writes them: the file on disk keeps whatever clean state it was committed in,
    /// and the in-memory atlas is left alone so nothing has to re-rasterise mid-session. Static
    /// font assets are untouched — their atlas is real content, not a cache.
    /// </para>
    /// Turn it off from RootsDance &gt; Fonts &gt; Guard Dynamic Font Atlases when a font asset's
    /// own settings genuinely need saving, then turn it back on.
    /// </summary>
    public class DynamicFontAtlasGuard : AssetModificationProcessor
    {
        private const string k_MenuPath = "RootsDance/Fonts/Guard Dynamic Font Atlases";
        private const string k_PrefKey = "RootsDance.Fonts.GuardDynamicAtlases";

        private static bool Enabled => EditorPrefs.GetBool(k_PrefKey, true);

        [MenuItem(k_MenuPath)]
        private static void ToggleGuard()
        {
            EditorPrefs.SetBool(k_PrefKey, !Enabled);
        }

        [MenuItem(k_MenuPath, isValidateFunction: true)]
        private static bool ToggleGuardValidate()
        {
            Menu.SetChecked(k_MenuPath, Enabled);
            return true;
        }

        public static string[] OnWillSaveAssets(string[] paths)
        {
            if (!Enabled || paths == null || paths.Length == 0)
            {
                return paths;
            }

            List<string> kept = null;
            List<string> skipped = null;

            for (int i = 0; i < paths.Length; i++)
            {
                if (!IsDynamicFontAsset(paths[i]))
                {
                    kept?.Add(paths[i]);
                    continue;
                }

                if (kept == null)
                {
                    kept = new List<string>(paths.Length);
                    skipped = new List<string>();
                    for (int j = 0; j < i; j++)
                    {
                        kept.Add(paths[j]);
                    }
                }

                skipped.Add(paths[i]);
            }

            if (kept == null)
            {
                return paths;
            }

            Debug.Log($"[Fonts] Kept the runtime atlas out of {string.Join(", ", skipped)}. " +
                      $"Uncheck {k_MenuPath} if you meant to save the font asset itself.");
            return kept.ToArray();
        }

        private static bool IsDynamicFontAsset(string path)
        {
            // A font asset that does not exist yet is being created — let that first write through,
            // or the asset would never reach disk at all.
            if (string.IsNullOrEmpty(path) || !path.EndsWith(".asset") || !File.Exists(path))
            {
                return false;
            }

            // Cheaper than loading every asset in the save list: this reads the type off the
            // database without bringing the object into memory.
            if (AssetDatabase.GetMainAssetTypeAtPath(path) != typeof(TMP_FontAsset))
            {
                return false;
            }

            TMP_FontAsset fontAsset = AssetDatabase.LoadAssetAtPath<TMP_FontAsset>(path);
            return fontAsset != null && fontAsset.atlasPopulationMode != AtlasPopulationMode.Static;
        }
    }
}
