using System.Text.RegularExpressions;

namespace RootsDance.Data
{
    /// <summary>
    /// Content IDs are PREFIX-NNN or DOMAIN-PREFIX-NNN: each prefix is 2-8 upper-case letters and the
    /// numeric suffix is 2-4 digits (FL-001, SO-001, BOT-FL-041).
    /// </summary>
    public static class ContentId
    {
        private static readonly Regex k_Pattern = new Regex(
            "^[A-Z]{2,8}(?:-[A-Z]{2,8})?-[0-9]{2,4}$", RegexOptions.Compiled);

        public static bool IsValid(string id)
        {
            return !string.IsNullOrEmpty(id) && k_Pattern.IsMatch(id);
        }

        /// <summary>
        /// Asset files are named "&lt;Id&gt;_&lt;Label&gt;" (e.g. "SO-001_Soil"); this takes the id
        /// prefix before the first underscore, or the whole name if there is none.
        /// </summary>
        public static string FromAssetName(string assetName)
        {
            if (string.IsNullOrEmpty(assetName))
            {
                return string.Empty;
            }

            int separatorIndex = assetName.IndexOf('_');
            string candidate = separatorIndex >= 0 ? assetName.Substring(0, separatorIndex) : assetName;

            return candidate.Trim().ToUpperInvariant();
        }
    }
}
