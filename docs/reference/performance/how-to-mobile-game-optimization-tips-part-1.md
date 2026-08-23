---
title: "Art optimization tips for mobile game developers part 1"
page_title: "Art optimization tips for mobile game developers part 1"
source_url: "https://unity.com/how-to/mobile-game-optimization-tips-part-1"
final_url: "https://unity.com/how-to/mobile-game-optimization-tips-part-1"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Mobile optimization tips for technical artists - Part I

***What you will get from this page:*** *Tips for optimizing art assets, for mobile game developers working in Unity. This is the first of* [*two articles*](https://unity.com/how-to/mobile-game-optimization-tips-part-2) *on optimizing art for mobile games.*

*You can find many other mobile optimization tips in* [*this comprehensive e-book*](https://create.unity3d.com/optimize-mobile-game-eBook) *and this Unity Learn course on* *[3D Art Optimization for Mobile Applications](https://learn.unity.com/course/3d-art-optimization-for-mobile-gaming-5474?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-elevate-your-game&utm_content=optimize-mobile-game-performance-ebook).*

Focus on the silhouette

Use Level of Detail (LOD)

Combine meshes and hide objects

Importing models

Texture sizes and color space

Bake details into the texture

Tinted grayscale textures

Texture filtering

Texture sizes and color space

Compress textures

Use Texture channels to pack multiple Textures into one

UV unwrapping

## Focus on the silhouette

Both polygons and vertices are computationally expensive on mobile platforms. Place polygons in areas that really contribute to the visual quality of the application, so you don’t waste your processing budget.

Due to the small screen size on most mobile devices and the location of 3D objects in your application, many small triangle details on a 3D object might not be visible. This means that you should focus on large shapes and parts that contribute to the silhouette of the object, rather than small details that might not be visible. Use textures and normal maps for fine detail.

## Use Level of Detail (LOD)

As objects move into the distance, [Level of Detail](https://docs.unity3d.com/Manual/LevelOfDetail.html) (LOD) can adjust or switch them to use simpler meshes with simpler materials and shaders to refine GPU performance.

More LOD preparation tips

-   Remove more polygons on flatter areas, and don’t use dense areas of triangles on objects with a lower LOD.
-   LOD can also apply to shader complexity. The shader and material can be optimized for 3D objects that are farther away. For example, you can reduce the number of Textures an object uses as it moves farther from the camera.
-   It’s often worth reducing the number of triangles between each LOD level by 50%.
-   Check what the LOD looks like at different distances from the camera.
-   Clean topology is essential for characters and objects that are deforming or animated.
-   Don’t obsess over having perfect topology. The player or end user won’t see the wireframe of a 3D model once you’ve applied a Texture and material.

When not to use LOD

LOD is not suitable in every situation. For example, avoid using it in an application where both the camera view and objects are static, or where the object is already using a low polygon count. LOD comes with a memory overhead and a larger file size because mesh data must be saved so it can be used in real-time.

## Combine meshes and hide objects

You can combine several meshes into one to reduce the number of draw calls required for rendering. To apply this technique, create an empty GameObject in the Hierarchy and make it the parent of the meshes that you want to combine, then attach a script implementing the method [Mesh.CombineMeshes()](https://docs.unity3d.com/ScriptReference/Mesh.CombineMeshes.html) onto the parent GameObject.

Use Occlusion Culling

Objects hidden behind other objects can potentially still render and cost resources. Use Occlusion Culling to discard them.

While frustum culling outside the camera view is automatic, occlusion culling is a baked process. Simply mark your objects as **Static Occluders** or **Static Occludees**, then bake through the **Window \> Rendering \> Occlusion Culling** dialog. While it’s not necessary for every scene, culling can improve performance in many cases. Check out the [Working with Occlusion Culling](https://learn.unity.com/tutorial/working-with-occlusion-culling) tutorial for more information.

## Importing models

Here are a few good tips to keep in mind when you import your models.

-   **Animation Type:** When importing an FBX Mesh that doesn’t contain any animation data, set Animation Type to None in the Rig tab of the Import Settings. When you place your mesh into the hierarchy, this setting will ensure Unity doesn’t generate an unused Animator component.
-   **Disable rigs and BlendShapes:** If your mesh doesn’t need skeletal or blendshape animation, disable these options wherever possible.
-   **Disable normals and tangents:** If you are absolutely certain that the mesh material will not need normals or tangents, uncheck these options for extra savings.
-   **Import settings:** If your model is not modified at runtime, disable the Read/Write Enabled option from the Model tab of the Import Settings to prevent a copy from being created in memory.
-   **Static/Dynamic Batching:** Static Batching is a common optimization technique that reduces the number of draw calls. It’s ideal for objects made up of a large number of vertices that don’t move, rotate, or scale during rendering. Check Static in the Inspector containing the Mesh Renderer of your target model.

## Texture sizes and color space

Textures can be different sizes. Reducing the size of Textures that require less detail will help reduce bandwidth. For example, a diffuse Texture can be set to 1024 x 1024, and the related roughness/metallic map can be set to 512 x 512. Do your best to selectively reduce the Texture size, and always check to see if any visuals have been degraded afterwards.

Most texturing software works with and exports Textures using the sRGB color space.

We recommend that you use diffuse Textures in the sRGB color space. Textures that are not processed as color must not be in the sRGB color space. Examples of these Textures include metallic, roughness, and normal maps, since maps are used as data rather than color. Using sRGB in these maps will result in the wrong visual on the material.

Note: Make sure the sRGB (color Texture) setting in the Inspector window doesn’t have checks next to roughness, specular, normal maps, or similar items.

## Bake details into the texture

Elements such as ambient occlusion and small specular highlights can be baked in and then added to the diffuse Texture. This approach means that you don’t have to rely too much on computationally expensive shaders and Unity features to get specular highlights and ambient occlusion.

## Tinted grayscale textures

Whenever possible, use grayscale Textures that allow color tinting in the shader. This saves Texture memory at the cost of creating a custom shader to perform the tinting. Be selective with this technique, because not all objects look good using this method. It’s easier to apply this to an object that has a uniform color.

## Texture filtering

Texture filtering often improves Texture quality in a scene, but it can also degrade performance because achieving better Texture quality often requires more processing. Texture filtering can sometimes account for up to half of GPU energy consumption. Choosing simpler and more appropriate Texture filters can help reduce the energy demands of an application.

-   **Nearest/Point filtering:** This is the simplest and least computationally intense form of Texture filtering, although when it’s seen up close, this filtering can make Textures appear blocky.
-   **Bilinear filtering:** Bilinear filtering samples and averages neighboring texels to color pixels in a Texture. Unlike nearest filtering, bilinear filtering results in less-blocky pixels, as the pixels have a smooth gradient. A side effect of bilinear filtering is that Textures will look blurry when viewed up close.

## Texture sizes and color space

Most of your memory will likely go to textures, so the import settings here are critical. In general, try to follow these guidelines when importing your assets.

-   **Lower the Max Size:** Use the minimum settings that produce visually acceptable results. This is nondestructive and can quickly reduce your texture memory.
-   **Use powers of two (POT):** Unity requires POT texture dimensions for mobile texture compression formats (PVRCT or ETC).
-   **Atlas your textures:** Placing multiple textures into a single texture can reduce draw calls and speed up rendering. Use the [Unity Sprite Atlas](https://docs.unity3d.com/Manual/class-SpriteAtlas.html) or the third-party [TexturePacker](https://www.codeandweb.com/texturepacker)to atlas your textures.
-   **Toggle off the Read/Write Enabled option:** When enabled, this option creates a copy in both CPU- and GPU-addressable memory, doubling the texture’s memory footprint. In most cases, keep this disabled. If you are generating textures at runtime, enforce this via **Texture2D. Apply**, passing in **makeNoLongerReadable** set to **true**.
-   **Disable unnecessary mipmaps:** Mipmaps are not needed for Textures that remain at a consistent size on screen, such as 2D sprites and UI graphics. Leave mipmaps enabled for 3D models with varying distance from the camera.
-   **Use bilinear filtering:** This will help to strike a balance between performance and visual quality.
-   **Use trilinear filtering selectively:** It requires more memory bandwidth than bilinear filtering.
-   **Use bilinear and 2x anisotropic filtering:** Choose these instead of trilinear and 1x anisotropic, to improve both appearance and performance.
-   **Keep the anisotropic level low:** Only use a level higher than 2 for critical game assets.

## Compress textures

Use Adaptive Scalable Texture Compression (ATSC) for both iOS and Android. The vast majority of games in development tend to target min-spec devices that support ATSC compression. The only exceptions are:

-   **iOS games targeting A7 devices or lower (e.g., iPhone 5, 5S, etc.):** Use PVRTC
-   **Android games targeting devices prior to 2016:** UseEricsson Texture Compression (ETC2)

## Use Texture channels to pack multiple Textures into one

Texture channel packing helps to save Texture memory because you can get three maps into one Texture. This means fewer Texture samplers. This approach is commonly used to pack roughness, smoothness, and/or metallic into one Texture. It can also be applied to any Texture mask. For example, you can also store the alpha mask. Images with transparencies can have a larger memory footprint since they require a 32-bit format, but by using the free channel to store the alpha mask, you can keep the diffuse Texture at 16-bit and effectively halve the file size.

Use the green channel to store the most important mask. The green channel usually has more bits since our eyes are more sensitive to green and less sensitive to blue.

## UV unwrapping

A UV map projects 2D Textures onto the surface of a 3D model. UV unwrapping is the process of creating a UV map.

-   It’s best practice to keep UV islands, the individual units of an unwrapped Texture, as straight as possible in order to make packing UV islands easier and reduce wasted space. A straight UV also helps prevent the staircase effect on Textures.
-   On mobile platforms, Texture space is limited. As such, the Texture size is usually smaller than on a console or PC. Good UV packing ensures that you get the most resolution from your Textures.
-   Consider having a slightly distorted UV by keeping the UV straight for better-quality Textures.
-   In certain cases, you will need to exaggerate and highlight the edges and shading to improve shape readability. Since mobile platforms generally use smaller Textures, it might be hard to capture all of the detail that’s needed within that small space.
-   For mobile applications, use fewer Textures and bake any extra details into one Texture. This is important because some details are better off baked onto the diffuse Texture itself to make sure that those details are visible in the small mobile screens.
