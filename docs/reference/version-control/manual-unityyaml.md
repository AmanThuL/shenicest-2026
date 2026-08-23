---
title: "Unity Manual 6.3 LTS: UnityYAML"
page_title: "Unity - Manual: UnityYAML"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UnityYAML

Unity uses a custom-optimized YAML library called UnityYAML. The UnityYAML library does not support the [full YAML specification](https://yaml.org/spec/). This documentation outlines which parts of the YAML spec UnityYAML supports.

You cannot externally produce or edit UnityYAML files.

## Supported features

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Support</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Mappings</strong></td><td style="text-align: left;">UnityYAML supports both flow and block styles.</td></tr><tr class="even"><td style="text-align: left;"><strong>Scalars</strong></td><td style="text-align: left;">UnityYAML supports double and single quoted scalars as well as plain scalars. You can split them onto multiple lines. Be aware that multi-line scalars can create performance and memory overheads during parsing.<br />
<br />
Plain scalars split onto multiple lines must be indented more than the previous line. See below this table for an example.<br />
<br />
You can use UTF–8 characters in scalars, but UnityYAML only decodes them when they are part of a double quoted scalar.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Sequences</strong></td><td style="text-align: left;">UnityYAML supports mapping, block styles, and block sequences that contain block mappings.</td></tr></tbody></table>

### Example of indentation on multi-line plain scalars:

``` lang-yml
parent: This is a
  multi-line scalar
^
|
```

If there is no indentation, the scalar returns `This is a` and might trigger an Asset into further parsing.

## Unsupported features

<table><thead><tr class="header"><th style="text-align: left;"><strong>Feature</strong></th><th style="text-align: left;"><strong>Support</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Chomping indicators</strong></td><td style="text-align: left;">UnityYAML does not support using <code>+</code> and <code>|</code> characters to indicate how it should treat new lines within a multi-line string. If you use these characters, UnityYAML adds them to the scalar value.</td></tr><tr class="even"><td style="text-align: left;"><strong>Comments</strong></td><td style="text-align: left;">UnityYAML does not support comments.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Complex mapping keys</strong></td><td style="text-align: left;">UnityYAML does not support complex mapping keys.</td></tr><tr class="even"><td style="text-align: left;"><strong>Multiple documents</strong></td><td style="text-align: left;">The reader skips document and tag prefixes at the top of files, but does not handle YAML input that consists of multiple documents.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Raw block sequences</strong></td><td style="text-align: left;">Nearly all nodes are part of a mapping in UnityYAML, so all sequences must be values of a mapping to work correctly. See below this table for an example.<br />
<br />
Anonymous sequences increase the parser complexity. You cannot use indentation as a way of determining if a sequence element has finished in UnityYAML.</td></tr><tr class="even"><td style="text-align: left;"><strong>Tags</strong></td><td style="text-align: left;">UnityYAML does not support tags.</td></tr></tbody></table>

### Example of a raw block sequence

``` lang-yml
var:
  - 1
  - 2
  - 3
```

The sequence is designed for lookups upon `var`, so the following does not work:

``` lang-yml
- 1
- 2
- 3
```
