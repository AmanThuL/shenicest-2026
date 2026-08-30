using System.IO;
using UnityEditor;
using UnityEditor.TestTools.TestRunner.Api;
using UnityEngine;

namespace RootsDance.Editor.Tools
{
    [InitializeOnLoad]
    public static class CodexSelectedTestRunner
    {
        private const string k_MarkerPath = "/tmp/shenicest-codex-run-selected-tests";
        private const string k_ResultPath = "/tmp/shenicest-codex-selected-tests.xml";
        private const string k_SummaryPath = "/tmp/shenicest-codex-selected-tests.txt";

        static CodexSelectedTestRunner()
        {
            if (!File.Exists(k_MarkerPath))
            {
                return;
            }

            File.Delete(k_MarkerPath);
            EditorApplication.delayCall += Run;
        }

        private static void Run()
        {
            TestRunnerApi api = ScriptableObject.CreateInstance<TestRunnerApi>();
            api.RegisterCallbacks(new Callbacks());
            api.Execute(new ExecutionSettings(new Filter
            {
                testMode = TestMode.EditMode,
                testNames = new[]
                {
                    "RootsDance.Tests.EditMode.Dialogue.DialoguePresenterTests."
                        + "ShowChoices_PlayerCursorWasLocked_ReleasesAndRestoresCursor",
                    "RootsDance.Tests.EditMode.Companion.CompanionFollowStepTests."
                        + "Appear_PlayerRootIsAboveFloor_KeepsAuthoredGroundOffset"
                }
            }));
        }

        private sealed class Callbacks : ICallbacks
        {
            public void RunStarted(ITestAdaptor testsToRun)
            {
            }

            public void RunFinished(ITestResultAdaptor result)
            {
                TestRunnerApi.SaveResultToFile(result, k_ResultPath);
                File.WriteAllText(k_SummaryPath,
                    $"status={result.TestStatus} passed={result.PassCount} failed={result.FailCount} "
                    + $"skipped={result.SkipCount}\n");
            }

            public void TestStarted(ITestAdaptor test)
            {
            }

            public void TestFinished(ITestResultAdaptor result)
            {
            }
        }
    }
}
