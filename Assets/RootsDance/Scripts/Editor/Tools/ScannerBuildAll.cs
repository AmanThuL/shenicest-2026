using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Runs the scanner's four builders in dependency order — themes, materials, report content,
    /// screen, prop — so the whole feature can be regenerated from the shell in one batch run.
    /// Each step is idempotent on its own; this only fixes the order, because the prop needs the
    /// screen prefab and the screen needs the section assets and the theme.
    /// </summary>
    public static class ScannerBuildAll
    {
        [MenuItem("RootsDance/Build Scanner (all steps)")]
        public static void Run()
        {
            ElectronicUIKitBuilder.BuildThemesOnly();
            ScannerMaterialBuilder.Build();
            ScannerReportContentBuilder.Build();
            AssetDatabase.Refresh();
            ScannerReportScreenBuilder.Build();
            ScannerPropBuilder.Build();
            AssetDatabase.SaveAssets();
            Debug.Log("ScannerBuildAll: done.");
        }
    }
}
