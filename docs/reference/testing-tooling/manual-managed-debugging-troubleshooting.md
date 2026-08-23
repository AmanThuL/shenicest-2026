---
title: "Troubleshooting debugging"
page_title: "Unity - Manual: Troubleshooting debugging"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-debugging-troubleshooting.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-debugging-troubleshooting.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Troubleshooting debugging

Most problems with the debugger occur because the IDE is unable to locate the Unity Editor or the Unity Player. This means that the Unity Editor or Player can’t attach the debugger properly. Because the debugger uses a TCP connection to the Editor or Player, connection issues are often caused by the network. Below are a few steps you can take to troubleshoot basic connection issues.

## Ensure you attach the debugger to the correct Unity instance

You can attach your IDE to any instance of the Unity Editor or Unity Player on the local network that has debugging enabled. When you attach the debugger, ensure that you attach it to the correct Unity instance. If you know the IP address or machine name of the device you’re running the Unity Player on, this helps to locate the correct instance.

## Verify the network connection to the Unity instance

The IDE uses the same mechanism to locate a Unity instance to debug as the Unity Profiler. If the IDE can’t find the Unity instance you expect, try [to attach the Profiler to that instance](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-profiling-applications.html). If the Profiler can’t find the Unity instance either, there might be a firewall on the machine you’re running the IDE or Unity instance on. If a firewall is in place, refer to [Check the firewall settings](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-debugging-troubleshooting.html#Firewall).

## Ensure the device only has one active network interface

Many devices have multiple network interfaces. For example, a mobile phone might have both an active cellular connection and an active Wi-Fi connection. To properly connect the debugger to the Unity instance using TCP, the IDE needs to make a network connection to the correct interface on the device. If you plan to debug over Wi-Fi, for example, make sure you put the device in airplane mode to disable all other interfaces, then enable Wi-Fi.

You can determine which IP address the Unity Player tells the IDE to use by looking in the Player Log. Look for a part of the log like this:

`Multi-casting "[IP] 10.0.1.152 [Port] 55000 [Flags] 3 [Guid] 2575380029 [EditorId] 4264788666 [Version] 1048832 [Id] iPhonePlayer(Example-iPhone):56000 [Debug] 1 [PackageName] iPhonePlayer" to [225.0.0.222:54997]...`

This message indicates the IDE will try to use the IP address 10.0.1.152 and port 56000 to connect to the device. This IP address and port must be reachable from the computer running the IDE.

## <span id="Firewall"></span> Check the firewall settings

The Unity instance communicates with the IDE using a TCP connection. On most Unity platforms, this TCP connection occurs on an arbitrarily chosen port. Normally, you don’t need to know this port, because the IDE should detect it automatically. If that doesn’t work, use a network analysis tool to determine which ports might be blocked either on the machine you’re running the IDE on, or the machine or device you’re running the Unity instance on. When you find the ports, make sure your firewall allows access to the port on both the machine running the IDE, and the machine running the Unity instance.

## Verify the managed debugging information is available

If the debugger attaches to the Unity instance but breakpoints don’t load, the debugger might not be able to locate the managed debugging information for the code. Managed code debugging information is stored in files named .pdb, next to the managed assembly (.dll file) on disk.

When you enable the [correct preferences and build options](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html), Unity generates this debugging information automatically. However, Unity cannot generate debugging information for managed plug-ins in your project. You can only debug code from managed plug-ins if the associated .pdb files are next to the managed plug-ins in the Unity project on disk.

## Prevent the device from locking

Disable any screen locks on the device you’re using to debug your application. Screen locks cause the debugger to disconnect, and prevent it from re-connecting. Don’t lock the screen during managed code debugging. If the screen locks, restart the application on the device so the debugger can connect again.

## Memory and thread leaks due to the debugger

The managed debugger allocates memory for operating system thread handles to handle any race conditions related to thread startup and shutdown. This creates small memory leaks which usually don’t impact the resource usage of an application. However, when many threads are created and destroyed, the memory leaks might be noticeable and make it difficult to track down other memory leaks in your application. It’s therefore recommended to disable script debugging when troubleshooting memory leaks.

## Additional resources

-   [Debug C# code in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html)
