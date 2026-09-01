# ObservationDeckCollapse.blend

温室内景的场景级 Blender 镜像，用来做观景台坍塌的破碎与动画。

温室内景只有这一个场景镜像文件。`GreenHouse1*/`、`_TilingJigs/` 下的 .blend 是
单件资产源，不承担与场景的对应关系，不要拿它们做坍塌。

## 与 Unity 的对应

- 对应场景：
  `Assets/RootsDance/Scenes/Levels/GreenhouseInterior/GreenhouseInterior_Environment.unity`，
  取场景里实际启用并渲染的几何，烘到世界空间。
- 坐标一一对应：Unity `(x, y, z)` 等于 Blender `(x, z, y)`；米制，unit scale 1.0；
  物体上不再叠加场景的旋转或缩放。
- 每个物体的原点在自身几何中心，破碎块绕自己旋转。
- `GH_interior_geometry` 是唯一有效集合，131 个物体：`Briggs_Greenhouse/` 56、
  `GreenHouse1_Textured/` 73、`GreenhouseSpiralStair/` 1、
  `WalkableFloor/WalkableFloor_BoxCollider` 1（给碎块落地用的地面盒）。
- `OLD_outdated_no_unity_rotation` 是缺场景旋转的旧导入，已 exclude；不参与导出、
  对拍和任何计算，也不要重新启用。

## 规则

- 几何以 Unity 场景为准。场景改了几何，就重新从场景导出覆盖本文件；不要在 Blender
  里单独改几何再往回倒进 Unity。
- 导出和对拍只取场景里 active 且 renderer 开着的物体。被关掉的那批是被
  `GreenHouse1_Textured` 顶替的旧圆厅，带上就会多出一份重复的圆厅。
- 重建后逐物体和场景对拍数量、顶点数、世界包围盒，差值应在 1e-5 m 量级；对不上就不
  是镜像，不要拿去做坍塌。
