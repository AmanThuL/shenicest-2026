---
title: "Configure Unity Accelerator in the Editor"
page_title: "Unity - Manual: Configure Unity Accelerator in the Editor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-configure.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-configure.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure Unity Accelerator in the Editor

To configure your Unity Editor to use Unity Accelerator, perform the following steps:

1.  Open the **Project Settings** window (**Edit** > **Project Settings**) and select **Editor** from the left panel.
2.  Under the **Accelerator Cache Server** section, set **Mode** to **Enabled**.
3.  Fill in the **IP address** with the cache server address (hostname/IP and port). The setup wizard displays the server address at the end of setup in this format: `[Hostname]:[Port]`. You can also find this information in the `unity-accelerator.log` file. The default port for secure access is `10443`. For insecure access, it is `10080`.
4.  Select the **Check Connection** button to test connectivity.

If the Check Connection test fails, check the hostname/IP and port values are correct and that the hostname/IP is accessible from your current machine.

## Customize settings

You can configure further settings such as a different namespace prefix, and upload and download preferences in the Project Settings window. Note that the namespace prefix is used as the prefix to 3 different namespaces, one for metadata, one for import artifacts and one for shader compilation artifacts.

It’s best practice to set a different namespace prefix from the default, so that you can ensure isolation from other projects and can help prevent cache corruption. You could use a namespace prefix that includes your project name, and the Unity version you’re using, for example `GameProjectX_6000.1`. To set the namespace, edit the **Namespace prefix** field.

You can also individually disable uploading or downloading. For example, for larger teams it is often good practice to only allow developers to pull from the cache, and only allow a single user or a build machine to upload. When used in combination with source control, the single user or build machine would check out the latest source, and perform a full import of any new asset data and upload the resulting artifacts to the Accelerator. Developers would then be able to pull from source control and pull the import artifacts from the Accelerator saving them the time importing them. This might help mitigate any issues with corrupted assets, ensuring that everyone recieves the same import data from a single source of truth.

You can also configure Unity Accelerator to use the global settings (**Unity** \> **Settings** \> **Asset Pipeline**) which is used by default for all projects unless overridden in the Project Settings.

For more information on the settings refer to [Cache Server Project Settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/cache-server-project-settings.html).

## Connectivity status

The status of the Unity Accelerator’s connectivity is displayed in the bottom right corner of the Unity Editor window.

![Unity Accelerator connectivity](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AcceleratorConnect.png)

## Additional resources

-   [Install Unity Accelerator with the installer](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-install-installer.html)
-   [Install Unity Accelerator with Docker Hub](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-install-docker.html)
-   [Cache Server Project Settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/cache-server-project-settings.html)
