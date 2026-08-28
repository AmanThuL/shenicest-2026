using System.IO;
using RootsDance.Core;
using RootsDance.Scanner;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Seeds the report's sections so the screen has something to show before a designer has
    /// written a word. Three sections, matching the shape the brief sketches: an authored overview,
    /// and two that grow with what the player has actually scanned.
    /// <para>
    /// Non-destructive by design. An existing asset is left completely alone — this only ever
    /// creates missing ones — because these are content assets and the writer owns them the moment
    /// they exist.
    /// </para>
    /// Menu: RootsDance > Build Scanner Report Content.
    /// </summary>
    public static class ScannerReportContentBuilder
    {
        private const string k_Folder = "Assets/RootsDance/Data/Scanner";

        [MenuItem("RootsDance/Build Scanner Report Content")]
        public static void Build()
        {
            Directory.CreateDirectory(k_Folder);
            AssetDatabase.Refresh();

            int created = 0;

            // The mark colour is picked out of the active theme's ramp by hand. TMP rich text has
            // no token syntax, so this is the one place the kit's "no literal colours" rule cannot
            // be enforced by construction; keep the value on a ramp step and it stays honest.
            created += Authored("01_Overview", "01", "调查概况",
                new[]
                {
                    Page("1.1", "遗迹环境总览",
                        "本区域位于旧观测站以南 <u>约 1.4 公里</u>。地表覆盖层以火山灰质壤土为主，"
                        + "含水量 <mark=#52320088>低于常年均值 37%</mark>。\n\n"
                        + "植被呈斑块状分布，未见连续冠层。夜间地表温度骤降，建议全程佩戴防护。",
                        new[] { "地形", "气候", "风险" }),
                    Page("1.2", "资源分布",
                        "可用水源仅见于遗迹东侧断层带。金属残件集中于西侧塌陷区，"
                        + "<mark=#52320088>回收价值中等</mark>，但结构不稳。",
                        new[] { "水源", "材料" })
                });

            created += Fed("02_Environment", "02", "环境采样", ReportCategory.EnvironmentSample);
            created += Fed("03_Biology", "03", "生物记录", ReportCategory.BiologicalRecord);

            AssetDatabase.SaveAssets();
            Debug.Log($"ScannerReportContentBuilder: {created} section asset(s) created in {k_Folder}. "
                + "Existing assets were left untouched.");
        }

        private static ScannerReportPage Page(string index, string title, string body, string[] tabs)
        {
            return ScannerReportPage.Create(index, title, body, tabs);
        }

        private static int Authored(string file, string number, string name, ScannerReportPage[] pages)
        {
            ScannerReportSectionSO section = Create(file);

            if (section == null)
            {
                return 0;
            }

            SerializedObject serialized = new SerializedObject(section);
            serialized.FindProperty("m_number").stringValue = number;
            serialized.FindProperty("m_displayName").stringValue = name;
            serialized.FindProperty("m_feedsFromReport").boolValue = false;

            SerializedProperty list = serialized.FindProperty("m_pages");
            list.arraySize = pages.Length;

            for (int i = 0; i < pages.Length; i++)
            {
                CopyPage(list.GetArrayElementAtIndex(i), pages[i]);
            }

            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(section);

            return 1;
        }

        private static int Fed(string file, string number, string name, ReportCategory category)
        {
            ScannerReportSectionSO section = Create(file);

            if (section == null)
            {
                return 0;
            }

            SerializedObject serialized = new SerializedObject(section);
            serialized.FindProperty("m_number").stringValue = number;
            serialized.FindProperty("m_displayName").stringValue = name;
            serialized.FindProperty("m_feedsFromReport").boolValue = true;
            serialized.FindProperty("m_category").enumValueIndex = (int)category;
            serialized.FindProperty("m_pages").arraySize = 0;
            serialized.ApplyModifiedPropertiesWithoutUndo();
            EditorUtility.SetDirty(section);

            return 1;
        }

        /// <summary>Creates the asset, or returns null when it already exists.</summary>
        private static ScannerReportSectionSO Create(string file)
        {
            string path = $"{k_Folder}/{file}.asset";

            if (AssetDatabase.LoadAssetAtPath<ScannerReportSectionSO>(path) != null)
            {
                return null;
            }

            ScannerReportSectionSO section = ScriptableObject.CreateInstance<ScannerReportSectionSO>();
            AssetDatabase.CreateAsset(section, path);

            return section;
        }

        private static void CopyPage(SerializedProperty element, ScannerReportPage page)
        {
            element.FindPropertyRelative("m_index").stringValue = page.Index;
            element.FindPropertyRelative("m_title").stringValue = page.Title;
            element.FindPropertyRelative("m_body").stringValue = page.Body;

            SerializedProperty tabs = element.FindPropertyRelative("m_functionTabs");
            string[] labels = page.FunctionTabs;
            tabs.arraySize = labels.Length;

            for (int i = 0; i < labels.Length; i++)
            {
                tabs.GetArrayElementAtIndex(i).stringValue = labels[i];
            }
        }
    }
}
