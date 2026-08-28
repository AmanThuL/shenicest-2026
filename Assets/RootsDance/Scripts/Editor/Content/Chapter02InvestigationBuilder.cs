using System.IO;
using RootsDance.Core;
using RootsDance.Investigation;
using UnityEditor;
using UnityEngine;

namespace RootsDance.Editor.Content
{
    /// <summary>
    /// Writes chapter 02's investigation targets — everything the scanner can be pointed at between
    /// the laboratory door and the circulation console — straight from the design document.
    /// <para>
    /// The copy already exists, written and proofed, in the chapter script. Typing it a second time
    /// into the Inspector is where bilingual content goes wrong: a missing line, a mismatched
    /// sample id, a Chinese block that no longer says what its English says. Generating it puts the
    /// script and the assets one edit apart.
    /// </para>
    /// <para>
    /// Non-destructive. An asset that already exists is left completely alone — the moment a
    /// designer has touched a target, it is theirs.
    /// </para>
    /// Menu: RootsDance &gt; Content &gt; Build Chapter 02 Investigation Targets.
    /// </summary>
    public static class Chapter02InvestigationBuilder
    {
        private const string k_Folder = "Assets/RootsDance/Data/Investigation";

        [MenuItem("RootsDance/Content/Build Chapter 02 Investigation Targets")]
        public static void Build()
        {
            Directory.CreateDirectory(k_Folder);
            AssetDatabase.Refresh();

            int created = 0;

            created += Target("ANM-002_UndergroundNetwork", "ANM-002", InvestigationKind.Identify,
                ReportCategory.AnomalyRecord, "地下根系网络", "识别",
                "检测对象：根系结构\n"
                + "状态：持续活跃\n"
                + "分布范围：超出当前扫描范围\n"
                + "检测到多种植物根系存在连接。\n"
                + "结构无法匹配现有数据库。\n\n"
                + "DETECTED OBJECT: Root System\n"
                + "STATUS: Persistently Active\n"
                + "DISTRIBUTION RANGE: Exceeds Current Scan Range\n"
                + "Interconnected root systems from multiple plant species detected.\n"
                + "STRUCTURE UNMATCHED IN EXISTING DATABASE.",
                new[] { "它们连在一起。不是挨着，是连着。" },
                WorldFlags.k_SawUndergroundNetwork) ? 1 : 0;

            created += Target("WA-001_GreenhouseWater", "WA-001", InvestigationKind.Sample,
                ReportCategory.EnvironmentSample, "水体样本", "采样",
                "样本编号：WA-001\n"
                + "样本类型：水体\n"
                + "区域：综合温室环境循环区\n"
                + "污染浓度：低于安全阈值\n"
                + "状态：活跃\n\n"
                + "SAMPLE ID: WA-001\n"
                + "SAMPLE TYPE: Water\n"
                + "LOCATION: Integrated Greenhouse Environmental Circulation Zone\n"
                + "CONTAMINATION LEVEL: Below Safety Threshold\n"
                + "STATUS: Active",
                new[] { "停了这么久，水还是活的。" },
                string.Empty) ? 1 : 0;

            created += Target("SO-002_GreenhouseSoil", "SO-002", InvestigationKind.Sample,
                ReportCategory.EnvironmentSample, "土壤样本", "采样",
                "样本编号：SO-002\n"
                + "样本类型：土壤\n"
                + "区域：综合温室\n"
                + "污染浓度：极低\n"
                + "状态：异常稳定\n"
                + "建议：扩大监测范围\n\n"
                + "SAMPLE ID: SO-002\n"
                + "SAMPLE TYPE: Soil\n"
                + "LOCATION: Integrated Greenhouse\n"
                + "CONTAMINATION LEVEL: Extremely Low\n"
                + "STATUS: Anomalously Stable\n"
                + "RECOMMENDATION: Expand Monitoring Range",
                new string[0], string.Empty) ? 1 : 0;

            created += Target("SO-003_OuterCultivationSoil", "SO-003", InvestigationKind.Sample,
                ReportCategory.EnvironmentSample, "土壤样本", "采样",
                "样本编号：SO-003\n"
                + "样本类型：土壤\n"
                + "区域：综合温室\n"
                + "污染浓度：极低\n"
                + "状态：低活性\n"
                + "建议：扩大监测范围\n\n"
                + "SAMPLE ID: SO-003\n"
                + "SAMPLE TYPE: Soil\n"
                + "LOCATION: Integrated Greenhouse\n"
                + "CONTAMINATION LEVEL: Extremely Low\n"
                + "STATUS: Low Activity\n"
                + "RECOMMENDATION: Expand Monitoring Range",
                new string[0], string.Empty) ? 1 : 0;

            created += Target("UNC-001_NoMatch", "UNC-001", InvestigationKind.Identify,
                ReportCategory.UnconfirmedSpecies, "匹配失败", "识别",
                "数据库索引：无\n"
                + "名称：匹配失败\n"
                + "分类：待确认\n"
                + "生长状态：稳定\n"
                + "备注：形态特征与历史记录存在偏差。\n"
                + "建议：采样\n\n"
                + "DATABASE INDEX: None\n"
                + "NAME: No Match Found\n"
                + "CLASSIFICATION: Pending Identification\n"
                + "GROWTH STATUS: Stable\n"
                + "NOTES: Morphological characteristics differ from historical records.\n"
                + "RECOMMENDATION: Sampling Recommended",
                new string[0], string.Empty) ? 1 : 0;

            created += Target("BOT-FL-089_CorkFern", "BOT-FL-089", InvestigationKind.Identify,
                ReportCategory.AnomalousSpecies, "软木蕨", "识别",
                "数据库索引：BOT-FL-089\n"
                + "名称：软木蕨\n"
                + "类别：蕨类植物\n"
                + "数据库匹配：匹配度较低 23%\n"
                + "形态偏差：显著\n"
                + "生长状态：休眠\n"
                + "区域：综合温室\n"
                + "建议：采样\n\n"
                + "DATABASE INDEX: BOT-FL-089\n"
                + "NAME: Cork Fern — Suberopteris dormans\n"
                + "CLASSIFICATION: Fern\n"
                + "DATABASE MATCH: Low Confidence — 23%\n"
                + "MORPHOLOGICAL DEVIATION: Significant\n"
                + "GROWTH STATUS: Dormant\n"
                + "LOCATION: Integrated Greenhouse\n"
                + "RECOMMENDATION: Sampling Recommended",
                new[] { "同一份档案，长成了另一个样子。" },
                string.Empty) ? 1 : 0;

            AssetDatabase.SaveAssets();

            Debug.Log($"[Content] Chapter 02: {created} investigation target(s) created in {k_Folder}. "
                + "Existing assets were left untouched.");
        }

        private static bool Target(string fileName, string id, InvestigationKind kind,
            ReportCategory category, string title, string prompt, string body, string[] monologue,
            string flagOnRecorded)
        {
            InvestigationTargetSO target = ContentAssetWriter.Ensure<InvestigationTargetSO>(
                $"{k_Folder}/{fileName}.asset", out bool created);

            if (!created)
            {
                return false;
            }

            SerializedObject serialized = new SerializedObject(target);
            ContentAssetWriter.SetString(serialized, "m_id", id);

            // Both enums number their members contiguously from 0, so the declared value and the
            // index into the member list are the same thing. ReportCategory says so in a comment,
            // because appending is exactly what keeps that true.
            ContentAssetWriter.SetEnum(serialized, "m_kind", (int)kind);
            ContentAssetWriter.SetEnum(serialized, "m_category", (int)category);
            ContentAssetWriter.SetString(serialized, "m_title", title);
            ContentAssetWriter.SetString(serialized, "m_promptText", prompt);
            ContentAssetWriter.SetString(serialized, "m_resultBody", body);
            ContentAssetWriter.SetStringArray(serialized, "m_monologueLines", monologue);
            ContentAssetWriter.SetString(serialized, "m_flagOnRecorded", flagOnRecorded);
            serialized.ApplyModifiedPropertiesWithoutUndo();

            EditorUtility.SetDirty(target);

            return true;
        }
    }
}
