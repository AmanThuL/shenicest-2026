using System;
using NUnit.Framework;
using RootsDance.Interaction;

namespace RootsDance.Tests.EditMode.Interaction
{
    public class RuneKeypadSequenceTests
    {
        private static readonly RuneSymbol[] k_Password =
        {
            RuneSymbol.Ansuz,
            RuneSymbol.Raidho,
            RuneSymbol.Berkana,
            RuneSymbol.Dagaz,
        };

        [Test]
        public void Constructor_NullPassword_ThrowsArgumentNullException()
        {
            // Arrange
            RuneSymbol[] password = null;

            // Act
            TestDelegate construct = () => new RuneKeypadSequence(password);

            // Assert
            Assert.That(construct, Throws.TypeOf<ArgumentNullException>());
        }

        [TestCase(0)]
        [TestCase(3)]
        [TestCase(5)]
        public void Constructor_PasswordLengthIsNotFour_ThrowsArgumentException(int length)
        {
            // Arrange
            RuneSymbol[] password = new RuneSymbol[length];

            // Act
            TestDelegate construct = () => new RuneKeypadSequence(password);

            // Assert
            Assert.That(construct, Throws.TypeOf<ArgumentException>());
        }

        [Test]
        public void Enter_FirstThreeCorrectRunes_AcceptsWithoutSolving()
        {
            // Arrange
            var sequenceUnderTest = new RuneKeypadSequence(k_Password);

            // Act
            RuneKeypadInputResult first = sequenceUnderTest.Enter(RuneSymbol.Ansuz);
            RuneKeypadInputResult second = sequenceUnderTest.Enter(RuneSymbol.Raidho);
            RuneKeypadInputResult third = sequenceUnderTest.Enter(RuneSymbol.Berkana);

            // Assert
            Assert.That(first, Is.EqualTo(RuneKeypadInputResult.Accepted));
            Assert.That(second, Is.EqualTo(RuneKeypadInputResult.Accepted));
            Assert.That(third, Is.EqualTo(RuneKeypadInputResult.Accepted));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(3));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Entering));
        }

        [Test]
        public void Enter_CorrectFourthRune_SolvesAndKeepsFullEntry()
        {
            // Arrange
            var sequenceUnderTest = new RuneKeypadSequence(k_Password);
            sequenceUnderTest.Enter(RuneSymbol.Ansuz);
            sequenceUnderTest.Enter(RuneSymbol.Raidho);
            sequenceUnderTest.Enter(RuneSymbol.Berkana);

            // Act
            RuneKeypadInputResult result = sequenceUnderTest.Enter(RuneSymbol.Dagaz);

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Solved));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(4));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Solved));
        }

        [Test]
        public void Enter_IncorrectFourthRune_ShowsErrorAndClearsEntry()
        {
            // Arrange
            var sequenceUnderTest = new RuneKeypadSequence(k_Password);
            sequenceUnderTest.Enter(RuneSymbol.Ansuz);
            sequenceUnderTest.Enter(RuneSymbol.Raidho);
            sequenceUnderTest.Enter(RuneSymbol.Berkana);

            // Act
            RuneKeypadInputResult result = sequenceUnderTest.Enter(RuneSymbol.Nauthiz);

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Incorrect));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(0));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.ShowingError));
        }

        [Test]
        public void Enter_WhileShowingError_IsIgnoredUntilAcknowledged()
        {
            // Arrange
            var sequenceUnderTest = CreateIncorrectSequence();

            // Act
            RuneKeypadInputResult result = sequenceUnderTest.Enter(RuneSymbol.Ansuz);

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Ignored));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(0));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.ShowingError));
        }

        [Test]
        public void AcknowledgeError_AfterIncorrectAttempt_AllowsFreshEntry()
        {
            // Arrange
            var sequenceUnderTest = CreateIncorrectSequence();

            // Act
            sequenceUnderTest.AcknowledgeError();
            RuneKeypadInputResult result = sequenceUnderTest.Enter(RuneSymbol.Ansuz);

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Accepted));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(1));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Entering));
        }

        [Test]
        public void Clear_PartialEntry_ClearsAndAccepts()
        {
            // Arrange
            var sequenceUnderTest = new RuneKeypadSequence(k_Password);
            sequenceUnderTest.Enter(RuneSymbol.Ansuz);
            sequenceUnderTest.Enter(RuneSymbol.Raidho);

            // Act
            RuneKeypadInputResult result = sequenceUnderTest.Clear();

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Accepted));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(0));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Entering));
        }

        [Test]
        public void Clear_EmptyEntry_IsIgnored()
        {
            // Arrange
            var sequenceUnderTest = new RuneKeypadSequence(k_Password);

            // Act
            RuneKeypadInputResult result = sequenceUnderTest.Clear();

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Ignored));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(0));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Entering));
        }

        [Test]
        public void Enter_AfterSolved_RemainsSolvedAndIgnoresFurtherChanges()
        {
            // Arrange
            var sequenceUnderTest = CreateSolvedSequence();

            // Act
            RuneKeypadInputResult enterResult = sequenceUnderTest.Enter(RuneSymbol.Nauthiz);
            RuneKeypadInputResult clearResult = sequenceUnderTest.Clear();
            sequenceUnderTest.AcknowledgeError();

            // Assert
            Assert.That(enterResult, Is.EqualTo(RuneKeypadInputResult.Ignored));
            Assert.That(clearResult, Is.EqualTo(RuneKeypadInputResult.Ignored));
            Assert.That(sequenceUnderTest.EnteredCount, Is.EqualTo(4));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Solved));
        }

        [Test]
        public void Enter_PasswordSourceChangesAfterConstruction_UsesCopiedPassword()
        {
            // Arrange
            RuneSymbol[] source = (RuneSymbol[])k_Password.Clone();
            var sequenceUnderTest = new RuneKeypadSequence(source);
            source[0] = RuneSymbol.Nauthiz;

            // Act
            RuneKeypadInputResult result = EnterCorrectPassword(sequenceUnderTest);

            // Assert
            Assert.That(result, Is.EqualTo(RuneKeypadInputResult.Solved));
            Assert.That(sequenceUnderTest.State, Is.EqualTo(RuneKeypadState.Solved));
        }

        private static RuneKeypadSequence CreateIncorrectSequence()
        {
            var sequence = new RuneKeypadSequence(k_Password);
            sequence.Enter(RuneSymbol.Ansuz);
            sequence.Enter(RuneSymbol.Raidho);
            sequence.Enter(RuneSymbol.Berkana);
            sequence.Enter(RuneSymbol.Nauthiz);
            return sequence;
        }

        private static RuneKeypadSequence CreateSolvedSequence()
        {
            var sequence = new RuneKeypadSequence(k_Password);
            EnterCorrectPassword(sequence);
            return sequence;
        }

        private static RuneKeypadInputResult EnterCorrectPassword(RuneKeypadSequence sequence)
        {
            sequence.Enter(RuneSymbol.Ansuz);
            sequence.Enter(RuneSymbol.Raidho);
            sequence.Enter(RuneSymbol.Berkana);
            return sequence.Enter(RuneSymbol.Dagaz);
        }
    }
}
