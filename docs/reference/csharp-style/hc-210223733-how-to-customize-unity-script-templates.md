---
title: "How to customize Unity script templates (Unity Support)"
page_title: "How to customize Unity script templates"
source_url: "https://support.unity.com/hc/en-us/articles/210223733-How-to-customize-Unity-script-templates"
final_url: "https://support.unity.com/hc/en-us/articles/210223733-How-to-customize-Unity-script-templates"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to customize Unity script templates

**<u>Symptoms:</u>**

 

-   When I create a new script, the Unity Editor generates its content. For C# scripts, it uses the file name as the class name.

**<u>Cause:</u>**

 

Script templates are stored in %EDITOR_PATH%\\Data\\Resources\\ScriptTemplates.

 

**<u>Resolution:</u>**

 

When you are creating a new script, the Unity Editor generates its content. For C# scripts it uses the file name as the class name. Please see the example below:

    using UnityEngine;
    using System.Collections;

    public class MyCustomScript : MonoBehaviour 
        // Update is called once per framevoid Update () 
If you want to change the initial script, you can modify the script templates stored here:

 

-   Windows: C:\\Program Files\\Unity\\Editor\\Data\\Resources\\ScriptTemplates
-   Mac: /Applications/Unity/Editor/Data/Resources/ScriptTemplates
-   Mac (since 5.2.1f1): /Applications/Unity/Unity.app/Contents/Resources/ScriptTemplates

 

In this directory you will find several template files:

    81-C# Script-NewBehaviourScript.cs.txt
    82-Javascript-NewBehaviourScript.js.txt
    83-Shader__Standard Surface Shader-NewSurfaceShader.shader.txt
    84-Shader__Unlit Shader-NewUnlitShader.shader.txt
    ...

 

If you want a different C# script template, edit the 81-C# Script-NewBehaviourScript.cs.txt file and leave the rest.

The mentioned file content looks like this (by default):

    using UnityEngine;
    using System.Collections;
     
    public class #SCRIPTNAME# : MonoBehaviour 
        // Update is called once per framevoid Update () 
    }

 

You can change anything you want within the script, but remember to leave *#SCRIPTNAME#* where it is. Without it, your template class name will not change, and a new script file will be generated with an incorrect class name.

Here is an example how the modified C# template may look: 

    /* * Modified template by Unity Support. */using UnityEngine;
     
    public class #SCRIPTNAME# : MonoBehaviour
    
        void Update()
        
        #endregion#region Private Methods#endregion
    }

 

After modifying the template files, please relaunch the Unity Editor to apply these changes.

 

Be sure to back up your original template files and the modified ones. You will need original files if your template is not recognized correctly. If your template isn't recognized, you will have to start again.

 

Be sure to make a copy of your modified template somewhere outside the Unity directory.

 

When you upgrade your Unity version, the template files will be overwritten, and you will need to copy and replace these again with your custom templates.

 

**<span class="ql-comment" comment-ids="121018172" comment-unresolved-ids="">Note:</span>**<span class="ql-comment" comment-ids="121018172" comment-unresolved-ids=""> you can allocate your scripting templates on a single project by creating a ScriptTemplates folder </span>on the Assets<span class="ql-comment" comment-ids="121018172" comment-unresolved-ids=""> and following the previous steps.</span>

 

**<u>More Information:</u>**

 

<a href="http://blog.theknightsofunity.com/customize-unity-script-templates/" class="ql-link"><span class="ql-comment ql-comment_active ql-comment_overlap" data-comment-ids="91071953" data-comment-unresolved-ids="91071953">How to customize Unity script templates</span></a>

<a href="https://support.unity.com/hc/en-us/articles/4403342550548-How-to-customize-Unity-script-templates-on-Unity-Project" class="ql-link"><span class="ql-comment ql-comment_active ql-comment_overlap" data-comment-ids="91071953" data-comment-unresolved-ids="91071953">How to customize Unity script templates on Unity Project</span></a>

## Related articles

-   [How can I modify built-in packages?](https://support.unity.com/hc/en-us/related/click?data=BAh7CjobZGVzdGluYXRpb25fYXJ0aWNsZV9pZGwrCJRtl%2BRJCDoYcmVmZXJyZXJfYXJ0aWNsZV9pZGkEdcKHDDoLbG9jYWxlSSIKZW4tdXMGOgZFVDoIdXJsSSJIL2hjL2VuLXVzL2FydGljbGVzLzkxMTM0NjA3NjQwNTItSG93LWNhbi1JLW1vZGlmeS1idWlsdC1pbi1wYWNrYWdlcwY7CFQ6CXJhbmtpBg%3D%3D--cc56ab7c7bd7ecbc963b0b4db4b2ca4ba43c1617)
-   [Billing FAQ Unity Gaming Services](https://support.unity.com/hc/en-us/related/click?data=BAh7CjobZGVzdGluYXRpb25fYXJ0aWNsZV9pZGwrCBSpmD80BjoYcmVmZXJyZXJfYXJ0aWNsZV9pZGkEdcKHDDoLbG9jYWxlSSIKZW4tdXMGOgZFVDoIdXJsSSJHL2hjL2VuLXVzL2FydGljbGVzLzY4MjE0NzUwMzU0MTItQmlsbGluZy1GQVEtVW5pdHktR2FtaW5nLVNlcnZpY2VzBjsIVDoJcmFua2kH--14368b54b5b45cb987f7b776cc5df0634f1bc0db)
-   [How do I remove the Splash Screen from my build?](https://support.unity.com/hc/en-us/related/click?data=BAh7CjobZGVzdGluYXRpb25fYXJ0aWNsZV9pZGkEq2SlDDoYcmVmZXJyZXJfYXJ0aWNsZV9pZGkEdcKHDDoLbG9jYWxlSSIKZW4tdXMGOgZFVDoIdXJsSSJRL2hjL2VuLXVzL2FydGljbGVzLzIxMjE2NTgwMy1Ib3ctZG8tSS1yZW1vdmUtdGhlLVNwbGFzaC1TY3JlZW4tZnJvbS1teS1idWlsZAY7CFQ6CXJhbmtpCA%3D%3D--703b1a4f7e1016e0cce9af318c424aece090e17c)
-   [How do I build my Unity Project in Batchmode Locally?](https://support.unity.com/hc/en-us/related/click?data=BAh7CjobZGVzdGluYXRpb25fYXJ0aWNsZV9pZGwrCBTR6%2FybCDoYcmVmZXJyZXJfYXJ0aWNsZV9pZGkEdcKHDDoLbG9jYWxlSSIKZW4tdXMGOgZFVDoIdXJsSSJaL2hjL2VuLXVzL2FydGljbGVzLzk0NjYwNTYyNjYwMDQtSG93LWRvLUktYnVpbGQtbXktVW5pdHktUHJvamVjdC1pbi1CYXRjaG1vZGUtTG9jYWxseQY7CFQ6CXJhbmtpCQ%3D%3D--2cc4cfa68837819cb995425a27288bb6426a29a3)
-   [How do I activate or return my Unity Industry/ Enterprise/ Pro license?](https://support.unity.com/hc/en-us/related/click?data=BAh7CjobZGVzdGluYXRpb25fYXJ0aWNsZV9pZGwrCBRHHO5JCDoYcmVmZXJyZXJfYXJ0aWNsZV9pZGkEdcKHDDoLbG9jYWxlSSIKZW4tdXMGOgZFVDoIdXJsSSJqL2hjL2VuLXVzL2FydGljbGVzLzkxMTM2MjA0NjU0MjgtSG93LWRvLUktYWN0aXZhdGUtb3ItcmV0dXJuLW15LVVuaXR5LUluZHVzdHJ5LUVudGVycHJpc2UtUHJvLWxpY2Vuc2UGOwhUOglyYW5raQo%3D--069b4101e5339ee2902f6b78ef47e0c44fc02184)
