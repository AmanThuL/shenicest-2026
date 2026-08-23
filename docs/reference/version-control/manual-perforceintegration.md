---
title: "Unity Manual 6.3 LTS: Perforce integration"
page_title: "Unity - Manual: Perforce Integration"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/perForceIntegration.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/perForceIntegration.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Perforce Integration

For more information on Perforce, visit [www.perforce.com](https://www.perforce.com/downloads/helix).

## Setting up Perforce

Follow the setup process described in the [Version Control](https://docs.unity3d.com/6000.3/Documentation/Manual/Versioncontrolintegration.html) documentation. See [Perforce documentation](https://www.perforce.com/perforce/doc.current/manuals/p4v/) if you encounter any problems.

**Note**: If your Perforce workspace has multi-factor authentication enabled you will first need to login through the command line using *p4 login2* or by using a visual client like P4V to be able to login in the Unity Editor as well.

## Integration through the CLI

When you connect Perforce through the command line interface, the provider is enabled immediately but only becomes active after `Provider.UpdateSettings()` completes its asynchronous update.

**Note**: If your workflow requires the provider to be active immediately, call `Provider.UpdateSettings().Wait()` before you check the provider state.

## Working offline with Perforce

Only use this if you know how to work offline in Perforce without a Sandbox. Refer to the [Perforce documentation](https://www.perforce.com/manuals/p4v/Content/P4V/using.offline.html) for further information.

## Troubleshooting

If Unity cannot commit your changes to Perforce (for example, if the server is down, or you experience licensing issues), your changes are stored in a separate changeset. If the console doesn’t list any info about the issue, you can use the P4V client for Perforce to submit this changeset to see the exact error message.

You cannot submit changes if you are sharing a workspace with another user. A workspace should be dedicated to one user only.

## Automatic revert of unchanged files on submit

It’s possible to configure Perforce to revert unchanged files on submit. To do this in P4V, select **Connection** \> **Edit Current Workspace**, view the **Advanced** tab and set the value of **On submit** to **Revert unchanged files**.
