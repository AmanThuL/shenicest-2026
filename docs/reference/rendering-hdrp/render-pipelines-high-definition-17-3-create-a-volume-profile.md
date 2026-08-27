---
title: "Create a Volume Profile"
page_title: "Create a Volume Profile | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create a Volume Profile

To create a Volume Profile, create a GameObject from the **GameObject** \> **Volume** menu. You can select one of the following:

- [**Global Volume**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html)
- [**Sky and Fog Global Volume**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html)
- **Box Volume**
- **Sphere Volume**
- **Convex Mesh Volume**

Unity creates and links a Volume Profile automatically when you create one of these volumes.

You can also create a Volume Profile manually. To do this, navigate to **Assets** \> **Create** \> **Rendering** \> **Volume Profile**.

Open the Volume Profile in the Inspector to edit its properties. To do this, you can either:

- Select the Volume Profile in the Assets folder.
- Select a GameObject with a Volume component that has a Volume Profile set in its **Profile** field.

## Additional resources

- [Configure Volume Overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html)
