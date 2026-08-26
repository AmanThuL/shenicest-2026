using System;

namespace RootsDance.Editor.Pipeline
{
    /// <summary>
    /// Classification of a texture file name under the project naming convention
    /// (<c>&lt;Asset&gt;_&lt;Map&gt;.png</c>, guideline 02 "Naming").
    /// </summary>
    /// <remarks>
    /// Pure logic with no UnityEditor dependency so it can be covered by EditMode tests.
    /// The map names are the URP Lit shader's own slot names, which is what makes the
    /// mapping from file name to import settings deterministic.
    /// </remarks>
    public enum TextureMapKind
    {
        Unknown = 0,
        BaseMap,
        Normal,
        Metallic,
        Specular,
        Occlusion,
        Emission,
        Height,
    }

    /// <summary>Parses and classifies RootsDance texture file names.</summary>
    public static class TextureMapNaming
    {
        /// <summary>Folder every project-owned material texture must live under.</summary>
        public const string k_TextureRoot = "Assets/RootsDance/Textures/";

        /// <summary>
        /// Splits <c>HelmetShell_BaseMap.png</c> into its texture-set name and map kind.
        /// </summary>
        /// <returns><c>true</c> when the name follows the convention.</returns>
        public static bool TryParse(string fileName, out string textureSet, out TextureMapKind kind)
        {
            textureSet = null;
            kind = TextureMapKind.Unknown;

            if (string.IsNullOrEmpty(fileName))
            {
                return false;
            }

            int slash = fileName.LastIndexOfAny(new[] { '/', '\\' });
            if (slash >= 0)
            {
                fileName = fileName.Substring(slash + 1);
            }

            int dot = fileName.IndexOf('.');
            if (dot <= 0)
            {
                return false;
            }

            string stem = fileName.Substring(0, dot);
            int underscore = stem.IndexOf('_');
            if (underscore <= 0 || underscore == stem.Length - 1)
            {
                return false;
            }

            // Exactly one underscore: the convention reserves it for the map suffix.
            if (stem.IndexOf('_', underscore + 1) >= 0)
            {
                return false;
            }

            string setPart = stem.Substring(0, underscore);
            string mapPart = stem.Substring(underscore + 1);

            if (!IsPascalCase(setPart))
            {
                return false;
            }

            if (!Enum.TryParse(mapPart, false, out TextureMapKind parsed) || parsed == TextureMapKind.Unknown)
            {
                return false;
            }

            textureSet = setPart;
            kind = parsed;
            return true;
        }

        /// <summary>
        /// True for maps that carry colour and therefore must be imported as sRGB.
        /// Every other map is data: importing it as sRGB gamma-decodes it and shades wrong.
        /// </summary>
        public static bool IsColorMap(TextureMapKind kind)
        {
            return kind == TextureMapKind.BaseMap || kind == TextureMapKind.Emission;
        }

        /// <summary>
        /// True when the alpha channel is opacity rather than packed data.
        /// The metallic map's alpha is smoothness (URP Lit "Smoothness Source = Metallic
        /// Alpha"), so treating it as transparency would let Unity's alpha dilation
        /// rewrite the smoothness values around transparent texels.
        /// </summary>
        public static bool AlphaIsTransparency(TextureMapKind kind)
        {
            return kind == TextureMapKind.BaseMap;
        }

        private static bool IsPascalCase(string value)
        {
            if (value.Length == 0 || !char.IsUpper(value[0]))
            {
                return false;
            }

            for (int i = 0; i < value.Length; i++)
            {
                if (!char.IsLetterOrDigit(value[i]))
                {
                    return false;
                }
            }

            return true;
        }
    }
}
