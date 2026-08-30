# 第三章语音资产清单（Chapter 03 Voice Lines）

> 55 条已录制的第三章（温室内部）语音，按录音时间戳排序放在
> `Assets/RootsDance/Audio/Voice/Chapter03/<说话人>/`。
> 命名 `VO_C3_<说话人>_<序号>_<英文片段>.mp3`；`_Alt` 是同一句的备选条。
> 表中「台词片段」还原自录音文件名，**是截断的片段，不是全文**——
> 生成第三章 `DialogueSO` 需要策划案的完整双语文本。

接入方式：`DialogueLine` / `DialogueChoice` 的 `Voice` 字段直接拖入 clip。带语音的行至少停留到
录音放完（加 0.35 s 尾距），跳过台词会一并打断语音；选项的语音在选中后、回应之前播出。
**逐句映射已写进 `Build Chapter 02 Dialogue` 生成器**——48 条挂进 DLG-001..009（不含 DLG-005），
未挂的 7 条：`MrsDavid_06_HowDidYouKnow`（无对应台词行）、`MrsDavid_07_IsThisOurPast`（内心独白，
等独白播放节拍）、`MrsDavid_08_WhatMeaningDoSt` 与 `Verity_19_ThatSignStre`（**弃用**，牌子交互点
已从策划案删除）、`Verity_14_OhWeEmph`（疑似 DLG-003 的多余 take）、`Verity_25__Alt`（备选条）、
三条 `Unsorted`（源文件名损坏）。见
[对话与场景序列](../../architecture/systems/对话与场景序列.md)。

## 女主 Mrs. David（对话 + 内心独白）

| # | 录音时间 | 情绪标注 | 台词片段（截断） | 文件 |
|---|---|---|---|---|
| 01 | 18:09 | startled, confused tone | ...What the hell | `VO_C3_MrsDavid_01_WhatTheHell.mp3` |
| 02 | 18:10 | emphasis, short pause | You can speak | `VO_C3_MrsDavid_02_YouCanSpeak.mp3` |
| 03 | 18:10 | with a wary, uncertain tone | ...What are you | `VO_C3_MrsDavid_03_WhatAreYou.mp3` |
| 04 | 18:12 | neutral, curious tone | Who is she | `VO_C3_MrsDavid_04_WhoIsShe.mp3` |
| 05 | 18:12 | with a cautious, alert tone | Is anyone else her | `VO_C3_MrsDavid_05_IsAnyoneElseHer.mp3` |
| 06 | 18:13 | with a curious, startled tone | How did you know | `VO_C3_MrsDavid_06_HowDidYouKnow.mp3` |
| 07 | 18:18 | 内心独白；with a quiet, searching tone | 内心独白 Is this our past | `VO_C3_MrsDavid_07_IsThisOurPast.mp3` |
| 08 | 18:20 | **弃用**（牌子交互点已删）；curious, contemplative tone | What meaning do st | `VO_C3_MrsDavid_08_WhatMeaningDoSt.mp3` |
| 09 | 18:20 | with a surprised, questioning tone | She | `VO_C3_MrsDavid_09_She.mp3` |
| 10 | 18:24 | with a wary, uncertain tone | She wasn't there. | `VO_C3_MrsDavid_10_SheWasntThere.mp3` |
| 11 | 18:26 | sarcastic, emphasis | Weren't you here the whol | `VO_C3_MrsDavid_11_WerentYouHereTheWhol.mp3` |
| 12 | 18:27 | with a puzzled, hesitant tone | Then... where di | `VO_C3_MrsDavid_12_ThenWhereDi.mp3` |

## 小花 Verity

| # | 录音时间 | 情绪标注 | 台词片段（截断） | 文件 |
|---|---|---|---|---|
| 01 | 16:43 | with a sharp, startled tone | Ah! | `VO_C3_Verity_01_Ah.mp3` |
| 02 | 16:48 | with a casual, agreeable tone | Yeah | `VO_C3_Verity_02_Yeah.mp3` |
| 03 | 16:48 | with a startled, defensive tone, pause | Wait. | `VO_C3_Verity_03_Wait.mp3` |
| 04 | 16:49 | with a confident, casual tone | I'm pret | `VO_C3_Verity_04_ImPret.mp3` |
| 05 | 16:50 | with a tentative, uncertain tone | Or maybe it i | `VO_C3_Verity_05_OrMaybeItI.mp3` |
| 06 | 16:50 | with a thoughtful, measured tone | That's a very | `VO_C3_Verity_06_ThatsAVery.mp3` |
| 07 | 16:51 |  | I live here | `VO_C3_Verity_07_ILiveHere.mp3` |
| 08 | 16:52 | with a wistful, reflective tone | There used to | `VO_C3_Verity_08_ThereUsedTo.mp3` |
| 09 | 16:53 | with a flat, resigned tone | Then there wasn't | `VO_C3_Verity_09_ThenThereWasnt.mp3` |
| 10 | 16:54 |  | But the things are still here. And e | `VO_C3_Verity_10_ButTheThingsAreStillHereAndE.mp3` |
| 11 | 16:55 | with a quiet, certain tone | This is her | `VO_C3_Verity_11_ThisIsHer.mp3` |
| 12 | 16:55 |  | Her. I mean... her | `VO_C3_Verity_12_HerIMeanHer.mp3` |
| 13 | 16:56 | with a hesitant, resigned tone | Well. It was | `VO_C3_Verity_13_WellItWas.mp3` |
| 14 | 16:57 | with a bright, excited tone, gasp | Oh! We emph | `VO_C3_Verity_14_OhWeEmph.mp3` |
| 15 | 16:58 | with a questioning, expectant tone | Aren't you | `VO_C3_Verity_15_ArentYou.mp3` |
| 16 | 16:59 | with a warm, enthusiastic tone | We all | `VO_C3_Verity_16_WeAll.mp3` |
| 17 | 17:00 | with a wistful, reflective tone | It used to be | `VO_C3_Verity_17_ItUsedToBe.mp3` |
| 18 | 17:02 | with a sharp, agitated tone | But then! She stop | `VO_C3_Verity_18_ButThenSheStop.mp3` |
| 19 | 17:02 | **弃用**（牌子交互点已删）；with a wistful, reflective tone | That sign stre | `VO_C3_Verity_19_ThatSignStre.mp3` |
| 20 | 17:03 | with a wistful, subdued tone | She used to move | `VO_C3_Verity_20_SheUsedToMove.mp3` |
| 21 | 17:04 | with a soft, wistful tone | She was beau | `VO_C3_Verity_21_SheWasBeau.mp3` |
| 22 | 17:05 |  | Then one day, she stopped | `VO_C3_Verity_22_ThenOneDaySheStopped.mp3` |
| 23 | 17:05 |  | Yeah. Her. | `VO_C3_Verity_23_YeahHer.mp3` |
| 24 | 17:20 | with a wary, uncertain tone | I've never seen an | `VO_C3_Verity_24_IveNeverSeenAn.mp3` |
| 25 | 17:23 | with a devoted, urgent tone | Of course! I've em (1) | `VO_C3_Verity_25_OfCourseIveEm_Alt.mp3` |
| 26 | 17:23 | with a devoted, urgent tone | Of course! I've em | `VO_C3_Verity_26_OfCourseIveEm.mp3` |
| 27 | 17:25 | with a hesitant, sheepish tone, pause | Um I str | `VO_C3_Verity_27_UmIStr.mp3` |
| 28 | 17:25 | with a startled, breathless tone | Oh. Oh, | `VO_C3_Verity_28_OhOh.mp3` |
| 29 | 17:28 | with a cold, accusatory tone | You picked | `VO_C3_Verity_29_YouPicked.mp3` |
| 30 | 17:37 | pause | Wait | `VO_C3_Verity_30_Wait.mp3` |
| 31 | 17:44 |  | Stop it. | `VO_C3_Verity_31_StopIt.mp3` |
| 32 | 17:45 | urgent, astounded tone | They're not there | `VO_C3_Verity_32_TheyreNotThere.mp3` |
| 33 | 17:45 | with a tense, urgent tone | Make it stop | `VO_C3_Verity_33_MakeItStop.mp3` |
| 34 | 17:47 | with a firm, commanding tone | Take things. Stan | `VO_C3_Verity_34_TakeThingsStan.mp3` |
| 35 | 17:52 | forceful, clipped tone | Stop. | `VO_C3_Verity_35_Stop.mp3` |
| 36 | 17:52 | with a hesitant, uncertain tone | But | `VO_C3_Verity_36_But.mp3` |
| 37 | 17:54 |  | Stop! | `VO_C3_Verity_37_Stop.mp3` |
| 38 | 17:57 | with a startled, urgent tone | They're not there | `VO_C3_Verity_38_TheyreNotThere.mp3` |
| 39 | 17:59 | with a bitter, accusatory tone | Why do you alwa | `VO_C3_Verity_39_WhyDoYouAlwa.mp3` |
| 40 | 18:00 | with a calm, reassuring tone | They didn't do an | `VO_C3_Verity_40_TheyDidntDoAn.mp3` |
| 91 | ??:?? | (文件名损坏，顺序未知) | [with......eful_ | `VO_C3_Verity_91_Unsorted.mp3` |
| 92 | ??:?? | (文件名损坏，顺序未知) | [with......es... | `VO_C3_Verity_92_Unsorted.mp3` |
| 93 | ??:?? | (文件名损坏，顺序未知) | [with......slow_ | `VO_C3_Verity_93_Unsorted.mp3` |

