#ifndef BOSS_PULSE_INCLUDED
#define BOSS_PULSE_INCLUDED

// 植物 Boss 的顶点动画。两项**相加**:
//   ① 全身摆动场 —— 三组固定方向的长波行波
//   ② 刺沿顶点法线鼓胀 —— 像肿瘤一样只鼓不缩
//
// 逐顶点数据在 Blender 里烘死(SourceArt/Boss/scripts/organize2.py):
//   UV2.x = 摆动权重(离「躯干+腿」的距离做成的全身连续场)
//   UV2.y = 鼓胀增益; > 0.5 是刺, 增益 mS = 2y-1 = 相对尺寸 x 根部淡出
//   顶点色 A = 相位(黄金比分布, 每根刺错开)
//
// 常数与 SourceArt/Boss/scripts/gn_preview.py 的几何节点逐字对齐 ——
// 那份 Blender 节点图是这段代码的规格书, 改一边必须改另一边。
//
// 两条硬约束(踩过坑):
//  - 位移必须是**位置**的连续函数。任何依赖「部件中心/部件相位」的位移,
//    在焊缝两侧取值不同 -> 缝张开 -> 视觉上脱节。
//  - 刺只能沿**法线**鼓, 不能「绕烘死的根部坐标等比缩放」。上了蒙皮之后
//    根部坐标还钉在静止姿态, 腿一抬鼓胀方向就乱指, 刺会朝地面甩。
//    法线是随蒙皮一起转的局部量, 蒙皮怎么动都对。

#define BP_TAU 6.28318530718

// 所有常数按「模型高 1.0」标定, 而 Unity 里 Boss 高 7 米,
// 所以先把位置除以 ModelScale 进标定空间算, 算完位移再乘回去。
#define BOSS_PULSE_BODY(T)                                                                          \
    T  scl   = max(ModelScale, (T)1e-4);                                                            \
    T3 p     = PositionOS / scl;                                                                    \
    T  sway  = AnimData.x;                                                                          \
    T  mS    = saturate(AnimData.y * (T)2.0 - (T)1.0);                                              \
    T  phase = VertexColor.a;                                                                       \
                                                                                                    \
    T  amp = SwayAmp * sway * sway;                                                                 \
    T3 d   = (T3)0;                                                                                 \
    d += sin((TimeSec * SwayFreq * (T)1.000 + dot(p, T3( 0.52,  0.33,  0.40))) * BP_TAU) * amp      \
       * T3( 0.96,  0.29,  0.00);                                                                   \
    d += sin((TimeSec * SwayFreq * (T)0.618 + dot(p, T3(-0.40,  0.49,  0.31))) * BP_TAU) * amp      \
       * T3(-0.31,  0.94,  0.14);                                                                   \
    d += sin((TimeSec * SwayFreq * (T)0.379 + dot(p, T3( 0.26, -0.55,  0.47))) * BP_TAU) * amp      \
       * T3( 0.42, -0.55,  0.72);                                                                   \
                                                                                                    \
    T av    = frac(phase * (T)7.3) * (T)0.85 + (T)0.15;                                             \
    T pulse = sin((TimeSec * BulgeFreq + phase) * BP_TAU) * (T)0.5 + (T)0.5;                        \
    d += normalize(NormalOS) * (BulgeAmp * av * pulse * mS);                                        \
                                                                                                    \
    OutPositionOS = PositionOS + d * scl;

void BossPulse_float(
    float3 PositionOS, float3 NormalOS, float4 AnimData, float4 VertexColor, float TimeSec,
    float BulgeAmp, float BulgeFreq, float SwayAmp, float SwayFreq, float ModelScale,
    out float3 OutPositionOS)
{
    #define T  float
    #define T3 float3
    BOSS_PULSE_BODY(float)
    #undef T
    #undef T3
}

void BossPulse_half(
    half3 PositionOS, half3 NormalOS, half4 AnimData, half4 VertexColor, half TimeSec,
    half BulgeAmp, half BulgeFreq, half SwayAmp, half SwayFreq, half ModelScale,
    out half3 OutPositionOS)
{
    #define T  half
    #define T3 half3
    BOSS_PULSE_BODY(half)
    #undef T
    #undef T3
}

#endif
