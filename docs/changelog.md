# 地圖說明與改版總覽 (Map Documentation & Version History)

本專區收錄每張地圖檔案的設計說明、特化機制與改版歷程。

---

## 🗺️ 地圖系列分類

目前專案收錄兩大核心戰術地圖系列：
1. **Stromguarde-Gemini_enhanced 系列**（原生 JASS 反塔防龜縮偵測、攻城行軍拉扯、空軍側翼繞後突襲戰術引擎）
2. **Stromguarde-Rifel_fast 系列**（人類步槍兵數值與 AI 極限特化對戰圖）

---

## 📌 系列一：Stromguarde-Gemini_enhanced 系列

- **地圖檔案**：
  - `maps/Stromguarde-Gemini_enhanced_V3.w3m`（**攻城防卡死與基地出征優化版**，推薦）
  - `maps/Stromguarde-Gemini_enhanced_V2.w3m`（JASS 語法修正版）
  - `maps/Stromguarde-Gemini_enhanced.w3m`（初代對照基準圖）
- **遊戲內名稱**：與檔名一致
- **地圖類型**：經典 6 人對戰圖 (`.w3m` 混亂之治/寒冰霸權相容格式)
- **核心戰術機制**：
  1. **動態塔防龜縮偵測 (`ScanPlayerTowerDefense`)**：
     - JASS 底層計時器定期掃描各敵對玩家基地箭塔密度。
     - 若敵方箭塔數超過門檻（`TOWER_THRESHOLD = 3`），標記其為龜縮狀態。
  2. **攻城數量動態控管（V3 防卡死核心）**：
     - 加入 `MAX_SIEGE_UNITS = 2` 嚴格限制，徹底消除電腦因過度生產大型攻城車（投石車/絞肉車）導致擠死在建築群狹縫動彈不得的問題。
  3. **基地出征推進引導 (`Siege March`)**：
     - 攻城車在自家基地附近（周圍無敵方防禦塔時）不再原地踱步發呆，而是強制下達主動推進指令，引導其離開基地開赴前線。
  4. **攻城武器距離微控 (`Siege Micro`)**：
     - 抵達前線且偵測到箭塔群時，強制攻城部隊維持在 **750 ~ 1150 碼** 安全射程邊緣定點點殺防禦塔。
  5. **空軍側翼繞後突襲 (`ExecuteAirFlankTactics`)**：
     - 當前門被大量箭塔封鎖時，戰術引擎動態計算側翼迂迴座標（`flankX, flankY`，偏移 2400 碼路徑點）。
     - 強制命令空軍部隊繞開正門重防，直接切入後方金礦農民採集點進行精準屠殺。

---

## 📌 系列二：Stromguarde-Rifel_fast 系列

- **地圖基底**：經典暴雪 6 人對戰地圖 **(6)Stromguarde**
- **支援玩家數**：6 人（支援 FFA、2v2、3v3）
- **核心設計概念**：
  針對**人類聯盟（Human）的步槍兵（Rifleman）**進行極限特化，將原本偏向輔助的遠程部隊改造為具備超遠狙擊距離、極高射速、快速前搖的主力打擊部隊；同時內嵌專屬的 `human.ai` 戰略腳本，讓電腦玩家能夠發揮這項特化優勢。

### 📊 步槍兵特化數值總表（相較於原版）

| 屬性項目 | 原始數值 | Rifel_fast 系列 (特化) | 差異與影響 |
| :--- | :---: | :---: | :--- |
| **基礎防禦力 (`udef`)** | 0 | **3** | 前期面對小怪與衝臉部隊生存力顯著提高 |
| **攻擊距離 (`ua1r`)** | 400 | **1000** | 超遠打擊射程，可在敵方近戰部隊接近前造成大量傷亡 |
| **主動索敵範圍 (`uacq`)** | 600 | **1150** | 配合 1000 射程，視野內一發現敵軍即主動瞄準射擊 |
| **攻擊冷卻時間 (`ua1c`)** | 1.35 秒 | **0.30 秒** | 射速提升超過 4 倍，極速傾瀉火力 |
| **攻擊出手前搖 (`udp1`)** | 0.17 秒 | **0.05 秒** | 抬手極短，走 A 與初次開火反應迅速 |
| **攻擊收手後搖 (`ubs1`)** | 0.56 秒 | **0.10 秒** | 硬直極低，部隊轉火切換目標極為流暢 |
| **子彈飛行速度 (`ua1z`)** | 1900 | **3000** | 避免長距離彈道飛行過久產生無效傷害溢出 |
| **長步槍升級 (`Rhri`)** | 需主城 (Keep) | **僅需 1 本鐵匠鋪** | 一本即可升級，攻擊距離再 **+300**（達 **1300**），攻擊速度再 **+20%** |

---

## 📑 各版本獨立改版紀錄

```text
maps/
├── Stromguarde-Gemini_enhanced_V3.w3m # 攻城防卡死與基地出征優化版 (推薦)
├── Stromguarde-Gemini_enhanced_V2.w3m # JASS 語法修正版
├── Stromguarde-Gemini_enhanced.w3m    # 初版對照圖
├── Stromguarde-Rifel_fast_V4.w3x      # 步槍兵特化最新版：防卡兵與防消極進攻完善版 (推薦)
└── Stromguarde-Rifel_fast_V3.w3x      # 步槍兵特化初代 AI 整合圖
```

---

### 🔹 [Stromguarde-Gemini_enhanced_V3.w3m](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Gemini_enhanced_V3.w3m)（推薦最新版）

* **地圖檔案路徑**：`maps/Stromguarde-Gemini_enhanced_V3.w3m`
* **遊戲內顯示名稱**：`Stromguarde-Gemini_enhanced_V3.w3m`
* **改版重點**：
  1. **限制攻城武器上限（MAX 2）**：防範 AI 因偵測到塔防而無止境生產大型投石車/絞肉車，徹底根治基地周遭被大型車輛擠塞卡死的致命問題。
  2. **加入出征推進引導**：攻城車在自家基地附近且周遭無敵塔時，強制發出推進攻擊指令，杜絕在基地內踱步發呆。
  3. **限制空軍突襲上限（MAX 4）**：平衡資源分配，保留充足金木給核心陸戰部隊與英雄維護。

---

### 🔹 [Stromguarde-Gemini_enhanced_V2.w3m](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Gemini_enhanced_V2.w3m)

* **地圖檔案路徑**：`maps/Stromguarde-Gemini_enhanced_V2.w3m`
* **遊戲內顯示名稱**：`Stromguarde-Gemini_enhanced_V2.w3m`
* **改版重點**：修正多重 `globals` 區塊導致的地圖載入語法錯誤。

---

### 🔹 [Stromguarde-Rifel_fast_V4.w3x](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Rifel_fast_V4.w3x)（推薦最新版）

* **地圖檔案路徑**：`maps/Stromguarde-Rifel_fast_V4.w3x`
* **遊戲內顯示名稱**：`Stromguarde-Rifel_fast_V4.w3x`
* **改版重點**：實體檔名與遊戲內名稱完全同步、修復開局人口卡死、優化雙兵營順序、步槍兵滿 8 隻解除 24 小時攻城限制與英雄陣亡發呆阻塞。
