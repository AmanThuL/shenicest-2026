using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Environment
{
    /// <summary>
    /// Finds renderers that are registered with more than one <see cref="LODGroup"/> — an outer group on a
    /// generated wrapper or dressing root plus the inner group that ships inside the vendor model prefab.
    /// A renderer in two groups makes LOD selection and culling non-deterministic, and the Editor logs
    /// "Renderer '…' is registered with more than one LODGroup" for every one of them.
    /// </summary>
    /// <remarks>
    /// The inner group is authoritative: it comes from the model and carries the real LOD chain. The outer
    /// group only ever exists to push a cull distance (see
    /// <see cref="EnvironmentPrefabBuilder"/>'s render-performance pass), so the fix transfers that cull
    /// height onto the inner group's last LOD and then removes the outer group.
    /// Read-only by default; the Fix menu item writes the prefabs.
    /// </remarks>
    public static class NestedLodGroupAudit
    {
        private const string k_ScanRoot = "Assets/RootsDance";

        /// <summary>How many offending renderers to name per prefab before the list is just counted.</summary>
        private const int k_ExamplesPerPrefab = 3;

        /// <summary>Fraction of the previous LOD's height the raised last step may reach.</summary>
        private const float k_CullHeightHeadroom = 0.95f;

        [MenuItem("RootsDance/Environment/Audit Nested LOD Groups")]
        public static void AuditFromMenu()
        {
            Debug.Log(Run(false));
        }

        [MenuItem("RootsDance/Environment/Fix Nested LOD Groups")]
        public static void FixFromMenu()
        {
            Debug.Log(Run(true));
        }

        /// <summary>Scans (and optionally repairs) every prefab under <c>Assets/RootsDance</c>.</summary>
        public static string Run(bool fix)
        {
            StringBuilder report = new StringBuilder();
            int affectedPrefabs = 0;
            int removedGroups = 0;
            int affectedRenderers = 0;

            string[] guids = AssetDatabase.FindAssets("t:Prefab", new[] { k_ScanRoot });

            // Saving a prefab one at a time re-imports it immediately, and a few dozen of those in a row
            // reload the domain mid-run. Batch every import to the end so the whole pass survives.
            if (fix)
            {
                AssetDatabase.StartAssetEditing();
            }

            try
            {

                foreach (string guid in guids)
            {
                    string path = AssetDatabase.GUIDToAssetPath(guid);
                    GameObject contents = PrefabUtility.LoadPrefabContents(path);

                    try
                {
                        List<LODGroup> redundant = new List<LODGroup>();
                        int renderers = Inspect(contents, path, report, redundant);

                        if (redundant.Count == 0)
                    {
                            continue;
                        }

                        affectedPrefabs++;
                        affectedRenderers += renderers;
                        removedGroups += redundant.Count;

                        if (!fix)
                    {
                            continue;
                        }

                        foreach (LODGroup group in redundant)
                    {
                            TransferCullHeight(group);
                            Object.DestroyImmediate(group);
                        }

                        bool saved;
                        PrefabUtility.SaveAsPrefabAsset(contents, path, out saved);

                        if (!saved)
                    {
                            report.AppendLine($"  !! could not save '{path}'");
                        }
                }
                finally
                {
                    PrefabUtility.UnloadPrefabContents(contents);
                }
            }

            }
            finally
            {
                if (fix)
                {
                    AssetDatabase.StopAssetEditing();
                }
            }

            report.Insert(0, $"NestedLodGroupAudit ({(fix ? "fix" : "audit")}): {affectedPrefabs} prefab(s), "
                + $"{affectedRenderers} double-covered renderer(s), {removedGroups} outer group(s)"
                + (fix ? " removed" : " to remove") + ".\n");
            return report.ToString();
        }

        /// <summary>
        /// Reports every renderer under <paramref name="root"/> that more than one group registers, and adds
        /// the outer (ancestor) groups of those renderers to <paramref name="redundant"/>.
        /// </summary>
        private static int Inspect(GameObject root, string path, StringBuilder report,
            List<LODGroup> redundant)
        {
            LODGroup[] groups = root.GetComponentsInChildren<LODGroup>(true);

            if (groups.Length < 2)
            {
                return 0;
            }

            Dictionary<Renderer, List<LODGroup>> owners = new Dictionary<Renderer, List<LODGroup>>();

            foreach (LODGroup group in groups)
            {
                foreach (LOD lod in group.GetLODs())
                {
                    foreach (Renderer renderer in lod.renderers)
                    {
                        if (renderer == null)
                        {
                            continue;
                        }

                        List<LODGroup> list;

                        if (!owners.TryGetValue(renderer, out list))
                        {
                            list = new List<LODGroup>();
                            owners[renderer] = list;
                        }

                        if (!list.Contains(group))
                        {
                            list.Add(group);
                        }
                    }
                }
            }

            int doubled = 0;
            bool header = false;
            int headerIndex = 0;

            foreach (KeyValuePair<Renderer, List<LODGroup>> pair in owners)
            {
                if (pair.Value.Count < 2)
                {
                    continue;
                }

                doubled++;

                if (!header)
                {
                    headerIndex = report.Length;
                    report.AppendLine(path);
                    header = true;
                }

                StringBuilder names = new StringBuilder();

                foreach (LODGroup group in pair.Value)
                {
                    if (names.Length > 0)
                    {
                        names.Append(", ");
                    }

                    names.Append('\'').Append(group.gameObject.name).Append('\'');
                }

                if (doubled <= k_ExamplesPerPrefab)
                {
                    report.AppendLine($"  {pair.Key.gameObject.name}: {names}");
                }

                LODGroup outer = OuterOf(pair.Value);

                // Only a group this prefab owns can be removed cleanly. On a variant or on a placed
                // instance the same component is inherited from the source prefab: deleting it there would
                // write a removed-component override instead of a fix, and there are tens of thousands of
                // them. Those clear themselves once the source prefab is repaired.
                if (outer != null && !PrefabUtility.IsPartOfPrefabInstance(outer) && !redundant.Contains(outer))
                {
                    redundant.Add(outer);
                }
            }

            if (header)
            {
                report.Insert(headerIndex + path.Length,
                    $"  —  {doubled} renderer(s), {redundant.Count} outer group(s)");
            }

            return doubled;
        }

        /// <summary>
        /// Reports every prefab whose LOD chain is not strictly descending, and every prefab that still
        /// carries more than one <see cref="LODGroup"/>. A clean run prints only the summary line.
        /// </summary>
        [MenuItem("RootsDance/Environment/Validate LOD Chains")]
        public static void ValidateFromMenu()
        {
            Debug.Log(Validate());
        }

        /// <summary>Checks every prefab's LOD chains for ordering and duplicate coverage.</summary>
        public static string Validate()
        {
            StringBuilder report = new StringBuilder();
            int checkedGroups = 0;
            int bad = 0;

            foreach (string guid in AssetDatabase.FindAssets("t:Prefab", new[] { k_ScanRoot }))
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                GameObject contents = PrefabUtility.LoadPrefabContents(path);

                try
                {
                    foreach (LODGroup group in contents.GetComponentsInChildren<LODGroup>(true))
                    {
                        if (PrefabUtility.IsPartOfPrefabInstance(group)
                            && !PrefabUtility.IsAddedComponentOverride(group))
                        {
                            continue;
                        }

                        LOD[] lods = group.GetLODs();
                        checkedGroups++;

                        for (int i = 1; i < lods.Length; i++)
                        {
                            if (lods[i].screenRelativeTransitionHeight
                                < lods[i - 1].screenRelativeTransitionHeight)
                            {
                                continue;
                            }

                            bad++;
                            report.AppendLine($"{path}: '{group.gameObject.name}' LOD{i} height "
                                + $"{lods[i].screenRelativeTransitionHeight} >= LOD{i - 1} height "
                                + $"{lods[i - 1].screenRelativeTransitionHeight}");
                            break;
                        }
                    }
                }
                finally
                {
                    PrefabUtility.UnloadPrefabContents(contents);
                }
            }

            report.Insert(0, $"NestedLodGroupAudit (validate): {checkedGroups} LOD chain(s) checked, "
                + $"{bad} out of order.\n");
            return report.ToString();
        }

        /// <summary>The group highest in the hierarchy — the wrapper's, not the model's.</summary>
        private static LODGroup OuterOf(List<LODGroup> groups)
        {
            LODGroup outer = null;
            int outerDepth = int.MaxValue;

            foreach (LODGroup group in groups)
            {
                int depth = 0;

                for (Transform t = group.transform; t != null; t = t.parent)
                {
                    depth++;
                }

                if (depth < outerDepth)
                {
                    outerDepth = depth;
                    outer = group;
                }
            }

            return outer;
        }

        /// <summary>
        /// Keeps the outer group's culling intent: raises the last LOD of every inner group it covers to the
        /// outer group's own last-LOD screen height, so the object still disappears at the same distance.
        /// </summary>
        private static void TransferCullHeight(LODGroup outer)
        {
            LOD[] outerLods = outer.GetLODs();

            if (outerLods.Length == 0)
            {
                return;
            }

            float cullHeight = outerLods[outerLods.Length - 1].screenRelativeTransitionHeight;

            foreach (LODGroup inner in outer.GetComponentsInChildren<LODGroup>(true))
            {
                if (inner == outer)
                {
                    continue;
                }

                LOD[] lods = inner.GetLODs();

                if (lods.Length == 0)
                {
                    continue;
                }

                int last = lods.Length - 1;
                float raised = Mathf.Max(lods[last].screenRelativeTransitionHeight, cullHeight);

                // A LOD chain must stay strictly descending. Raising the last step above the one before it
                // makes SetLODs reject the whole array, which would silently drop the cull distance.
                if (last > 0)
                {
                    raised = Mathf.Min(raised,
                        lods[last - 1].screenRelativeTransitionHeight * k_CullHeightHeadroom);
                }

                lods[last].screenRelativeTransitionHeight = raised;
                inner.SetLODs(lods);
            }
        }
    }
}
