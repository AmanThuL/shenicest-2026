---
title: "Unity 6.3 Manual: Manage Asset Store packages in the Editor"
page_title: "Manage Asset Store packages in the Editor • Unity Asset Store • Unity Docs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html"
final_url: "https://docs.unity.com/en-us/asset-store/downloads/asset-store-packages"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Manage Asset Store packages in the Editor

Asset Store packages are collections of files and data from Unity projects, or elements of projects.

<span class="MuiTypography-root MuiTypography-caption mui-1vxjoe2" sentry-element="Typography" sentry-source-file="content-renderer.tsx">Read time 2 minutes</span>

<span class="MuiTypography-root MuiTypography-caption mui-1vxjoe2">Last updated 2 months ago</span>

------------------------------------------------------------------------

An Asset Store package type is either <a href="https://docs.unity3d.com/en-us/asset-store/publishing/upm-packages" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">a UPM package</a> or an asset package (

    .unitypackage

format). When you add an Asset Store

<span class="MuiTypography-root MuiTypography-body1 mui-1an8jmi" sentry-element="Typography" sentry-source-file="glossary-term.tsx" tabindex="0">package</span>

?

to your

<span class="MuiTypography-root MuiTypography-body1 mui-1an8jmi" sentry-element="Typography" sentry-source-file="glossary-term.tsx" tabindex="0">project</span>

?

, the <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Unity Package Manager</a> unpacks the package and maintains its directory structure and metadata about assets. This metadata includes information such as import settings and links to other assets.

## <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html#using-asset-store-packages" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Using Asset Store packages

To use an Asset Store package, perform the following steps:

1.  

    Open the <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Unity Package Manager window</a>

    

2.  

    Select the <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-nav.html#contexts" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">My Assets</a> context to view the <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-list.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">list of available Asset Store packages</a>. You can also <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-search.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">search by name</a> for Asset Store packages.

    

3.  

    The method to add the package to your project depends on the type you've downloaded:

    

    -   For asset packages (
        

            .unitypackage

        

        ), refer to <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-import.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Download and import an asset package</a>.
    -   For UPM packages, refer to <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-install2.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Install a UPM package from Asset Store</a>.

If the Asset Store package has a newer version available, you can also update it directly in the Package Manager window. To update an asset package (

    .unitypackage

), refer to <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-update2.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Updating an asset package</a>, and to update a UPM package, refer to <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-ui-update.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Switch to another version of a UPM package</a>.

<span class="MuiBox-root mui-9cdfe5" anchor="asset-location" sentry-component="ScrollPoint" sentry-element="Box" sentry-source-file="scroll-point.tsx"></span>

## <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html#location-of-downloaded-asset-package-files" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Location of downloaded asset package files

Note

<span class="MuiTypography-root MuiTypography-body1 mui-wdm2sh" sentry-element="Typography" sentry-source-file="admonition.tsx"></span>

This information applies only to asset packages (

    .unitypackage

) you get from the Asset Store. It doesn’t apply to UPM packages you get from the Asset Store.

You can use the Package Manager window to manage your Asset Store packages within your project. However, if you need to access files from an asset package directly, you can find them in the cache for asset packages. This cache, which is separate from the <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-cache.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">global cache</a>, makes reusing and sharing asset packages more efficient. You can find the cache for asset packages in the following paths (which might be within hidden folders depending on your computer settings):

-   macOS:
    

        ~/Library/Unity/Asset Store-5.x

    
-   Windows:
    

        C:\Users\accountName\AppData\Roaming\Unity\Asset Store-5.x

    
-   Linux:
    

        ~/.local/share/unity3d/Asset Store-5.x

    

These folders contain subfolders that correspond to particular Asset Store vendors and are available after download and import. The Package Manager stores asset files inside the subfolders using a structure defined by the Asset Store package publisher.

You can override the default location of the cache for asset packages. For information, refer to <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-config-cache-as.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Customize the asset package cache location</a>.

## <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html#additional-resources" class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeExtraSmall mui-wvyjuu"></a>Additional resources

-   <a href="https://docs.unity3d.com/6000.6/Documentation/Manual/upm-package-types.html" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Package types</a>
-   <a href="https://docs.unity3d.com/en-us/asset-store/downloads/organize-asset-packages" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Manage packages in the Asset Store</a>
-   <a href="https://docs.unity3d.com/en-us/asset-store/publishing" class="MuiTypography-root MuiTypography-inherit MuiLink-root MuiLink-underlineNone mui-tb7bs8">Publishing Asset Store packages</a>

------------------------------------------------------------------------
