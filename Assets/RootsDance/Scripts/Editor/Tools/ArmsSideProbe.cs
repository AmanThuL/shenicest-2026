using System.Text;
using UnityEditor;
using UnityEngine;

namespace RootsDance.EditorTools
{
    /// <summary>
    /// Answers one question with numbers: which side of the player's view each arm is on, and which
    /// hand actually carries the helmet. Blender's rig faces −Y with the left hand at +X; Unity is
    /// left-handed with +X to the right, and the rig is anchored with a 180° turn on top — so the
    /// only trustworthy check is where a bone lands in the player's own space after import.
    /// </summary>
    public static class ArmsSideProbe
    {
        private const string k_Gameplay =
            "Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity";

        public static void Report()
        {
            UnityEditor.SceneManagement.EditorSceneManager.OpenScene(
                k_Gameplay, UnityEditor.SceneManagement.OpenSceneMode.Single);

            var offset = Object.FindFirstObjectByType<RootsDance.Player.ArmsViewOffset>(
                FindObjectsInactive.Include);

            if (offset == null)
            {
                Debug.LogError("ArmsSideProbe: no arms in the scene.");
                return;
            }

            Transform arms = offset.transform;
            Transform player = arms;

            while (player.parent != null)
            {
                player = player.parent;
            }

            var sb = new StringBuilder("ARMS SIDE PROBE\n");
            sb.AppendLine("  player-space X: negative = the player's LEFT, positive = their RIGHT");

            Sample(sb, arms, player, "Assets/RootsDance/Meshes/Characters/Arms_Neutral.fbx", "Arms_Neutral", 0f);
            Sample(sb, arms, player, "Assets/RootsDance/Meshes/Characters/Arms.fbx", "Arms_HelmetOff", 0f);
            Sample(sb, arms, player, "Assets/RootsDance/Meshes/Characters/Arms.fbx", "Arms_HelmetOff", 0.5f);
            Sample(sb, arms, player, "Assets/RootsDance/Meshes/Characters/Arms.fbx", "Arms_HelmetOff", 0.99f);
            Sample(sb, arms, player, "Assets/RootsDance/Meshes/Characters/Arms_ScannerRaise.fbx", "Arms_ScannerRaise", 0.99f);

            Debug.Log(sb.ToString());
        }

        private static void Sample(StringBuilder sb, Transform arms, Transform player,
            string modelPath, string clipName, float normalized)
        {
            AnimationClip clip = null;

            foreach (Object o in AssetDatabase.LoadAllAssetsAtPath(modelPath))
            {
                if (o is AnimationClip candidate && candidate.name == clipName)
                {
                    clip = candidate;
                    break;
                }
            }

            if (clip == null)
            {
                sb.Append("  ").Append(clipName).AppendLine(": clip not found");
                return;
            }

            clip.SampleAnimation(arms.gameObject, clip.length * normalized);

            Transform left = FindDeep(arms, "hand.L");
            Transform right = FindDeep(arms, "hand.R");
            Transform socket = FindDeep(arms, "helmet_socket");

            sb.Append("  ").Append(clipName).Append(" @ ").Append(normalized.ToString("F2")).AppendLine();
            Report(sb, player, "hand.L", left);
            Report(sb, player, "hand.R", right);

            if (socket != null && left != null && right != null)
            {
                sb.Append("      helmet_socket -> hand.L ")
                    .Append(Vector3.Distance(socket.position, left.position).ToString("F3"))
                    .Append(" m,  hand.R ")
                    .Append(Vector3.Distance(socket.position, right.position).ToString("F3"))
                    .AppendLine(" m");
            }
        }

        private static void Report(StringBuilder sb, Transform player, string label, Transform bone)
        {
            if (bone == null)
            {
                sb.Append("      ").Append(label).AppendLine(" MISSING");
                return;
            }

            Vector3 local = player.InverseTransformPoint(bone.position);
            sb.Append("      ").Append(label.PadRight(8))
                .Append("playerSpace=").Append(local.ToString("F3"))
                .Append("   side=").AppendLine(local.x < 0f ? "LEFT" : "RIGHT");
        }

        private static Transform FindDeep(Transform root, string name)
        {
            foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
            {
                if (t.name == name)
                {
                    return t;
                }
            }

            return null;
        }
    }
}
