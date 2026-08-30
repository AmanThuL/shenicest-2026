using System;
using System.Diagnostics;
using Debug = UnityEngine.Debug;

namespace RootsDance.Core
{
    /// <summary>
    /// The project's only logging entry point. <see cref="Info"/> and <see cref="Warning"/> compile
    /// out of release builds; <see cref="Error"/> and <see cref="Exception"/> are unconditional.
    /// </summary>
    public static class Log
    {
        [Conditional("UNITY_EDITOR"), Conditional("DEVELOPMENT_BUILD")]
        public static void Info(string message, UnityEngine.Object context)
        {
            Debug.Log(message, context);
        }

        [Conditional("UNITY_EDITOR"), Conditional("DEVELOPMENT_BUILD")]
        public static void Warning(string message, UnityEngine.Object context)
        {
            Debug.LogWarning(message, context);
        }

        public static void Error(string message, UnityEngine.Object context)
        {
            Debug.LogError(message, context);
        }

        public static void Exception(Exception exception, UnityEngine.Object context)
        {
            Debug.LogException(exception, context);
        }
    }
}
