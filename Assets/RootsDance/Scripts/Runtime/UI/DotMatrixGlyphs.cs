namespace RootsDance.UI
{
    /// <summary>
    /// The 3x5 dot-matrix face the reference sequence actually uses, measured off it rather than
    /// chosen: caption line 2 steps 12.3 px per character at ~20 px cap height, which is a three-dot
    /// glyph plus a one-dot gap. No vector font reaches this — at the size the screen renders text,
    /// a glyph is three dots wide, so the letterforms have to be authored as dots.
    /// <para>
    /// Rows read top to bottom, each row three characters wide: '1' is a lit dot.
    /// </para>
    /// </summary>
    public static class DotMatrixGlyphs
    {
        public const int Width = 3;

        public const int Height = 5;

        /// <summary>Characters this face covers, in the same order as <see cref="Rows"/>.</summary>
        public const string Charset = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,-:/";

        /// <summary>Five rows per character, indexed by position in <see cref="Charset"/>.</summary>
        public static readonly string[][] Rows =
        {
            new[] { "000", "000", "000", "000", "000" }, // space
            new[] { "010", "101", "111", "101", "101" }, // A
            new[] { "110", "101", "110", "101", "110" }, // B
            new[] { "011", "100", "100", "100", "011" }, // C
            new[] { "110", "101", "101", "101", "110" }, // D
            new[] { "111", "100", "110", "100", "111" }, // E
            new[] { "111", "100", "110", "100", "100" }, // F
            new[] { "011", "100", "101", "101", "011" }, // G
            new[] { "101", "101", "111", "101", "101" }, // H
            new[] { "111", "010", "010", "010", "111" }, // I
            new[] { "001", "001", "001", "101", "010" }, // J
            new[] { "101", "101", "110", "101", "101" }, // K
            new[] { "100", "100", "100", "100", "111" }, // L
            new[] { "101", "111", "111", "101", "101" }, // M
            new[] { "110", "101", "101", "101", "101" }, // N
            new[] { "010", "101", "101", "101", "010" }, // O
            new[] { "110", "101", "110", "100", "100" }, // P
            new[] { "010", "101", "101", "011", "001" }, // Q
            new[] { "110", "101", "110", "101", "101" }, // R
            new[] { "011", "100", "010", "001", "110" }, // S
            new[] { "111", "010", "010", "010", "010" }, // T
            new[] { "101", "101", "101", "101", "011" }, // U
            new[] { "101", "101", "101", "010", "010" }, // V
            new[] { "101", "101", "111", "111", "101" }, // W
            new[] { "101", "101", "010", "101", "101" }, // X
            new[] { "101", "101", "010", "010", "010" }, // Y
            new[] { "111", "001", "010", "100", "111" }, // Z
            new[] { "111", "101", "101", "101", "111" }, // 0
            new[] { "010", "110", "010", "010", "111" }, // 1
            new[] { "110", "001", "010", "100", "111" }, // 2
            new[] { "110", "001", "110", "001", "110" }, // 3
            new[] { "101", "101", "111", "001", "001" }, // 4
            new[] { "111", "100", "110", "001", "110" }, // 5
            new[] { "011", "100", "110", "101", "010" }, // 6
            new[] { "111", "001", "010", "010", "010" }, // 7
            new[] { "010", "101", "010", "101", "010" }, // 8
            new[] { "010", "101", "011", "001", "110" }, // 9
            new[] { "000", "000", "000", "000", "010" }, // .
            new[] { "000", "000", "000", "010", "100" }, // ,
            new[] { "000", "000", "111", "000", "000" }, // -
            new[] { "000", "010", "000", "010", "000" }, // :
            new[] { "001", "001", "010", "100", "100" }  // /
        };

        /// <summary>
        /// Index of <paramref name="character"/> in the face, or 0 (space) when it has no glyph.
        /// Lower case folds to upper: this screen has no lower case, exactly like the reference.
        /// </summary>
        public static int IndexOf(char character)
        {
            if (character >= 'a' && character <= 'z')
            {
                character = (char)(character - 'a' + 'A');
            }

            int index = Charset.IndexOf(character);

            return index < 0 ? 0 : index;
        }
    }
}
