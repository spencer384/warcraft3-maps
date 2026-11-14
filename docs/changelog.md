# 地圖說明與改版總覽 (Map Documentation & Version History)

本專區收錄每張地圖檔案的設計說明、特化機制與改版歷程。

---

## 🗺️ 地圖系列分類

目前收錄兩大核心系列：
1. **Stromguarde-Rifel_fast 系列**（人類步槍兵數值與 AI 極限特化對戰圖）
2. **Stromguarde-Gemini_enhanced 系列**（純原版平衡、AMAI 戰術與反塔防/龜縮機制研究圖）

---

## 📌 系列一：Stromguarde-Gemini_enhanced

- **地圖檔案**：`maps/Stromguarde-Gemini_enhanced.w3m`
- **遊戲內名稱**：`Stromguarde-Gemini enhanced`
- **地圖類型**：經典 6 人對戰圖 (`.w3m` 混亂之治/寒冰霸權相容格式)
- **數據分析結論**：
  - **單位與科技數據**：**完全維持原版暴雪對戰數值**（無自訂 `war3map.w3u` / `war3map.w3q`），步槍兵與所有兵種均為標準暴雪官方屬性。
  - **特色與定位**：為本專案系列地圖的**原始平衡基底**，著重於對抗「箭塔龜縮流（Tower Rush / Turtle）」與戰局平衡觀察。

---

## 📌 系列二：Stromguarde-Rifel_fast 系列

- **地圖基底**：經典暴雪 6 人對戰地圖 **(6)Stromguarde**
- **支援玩家數**：6 人（支援 FFA、2v2、3v3）
- **核心設計概念**：
  針對**人類聯盟（Human）的步槍兵（Rifleman）**進行極限特化，將原本偏向輔助的遠程部隊改造為具備超遠狙擊距離、極高射速、快速前搖的主力打擊部隊；同時內嵌專屬的 `human.ai` 戰略腳本，讓電腦玩家能夠發揮這項特化優勢。

### 📊 步槍兵特化數值總表（相較於 Gemini enhanced 原版）

| 屬性項目 | Gemini enhanced (原版) | Rifel_fast 系列 (特化) | 差異與影響 |
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

## 📑 各版本改版紀錄

```text
maps/
├── Stromguarde-Gemini_enhanced.w3m # 原版平衡基底圖
├── Stromguarde-Rifel_fast_V3.w3x   # 初代 AI 整合特化圖
└── Stromguarde-Rifel_fast_V4.w3x   # 當前最新版：防卡兵與防消極進攻完善版
```

---

### 🔹 [Stromguarde-Rifel_fast_V4.w3x](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Rifel_fast_V4.w3x)（當前最新版）

* **地圖檔案路徑**：`maps/Stromguarde-Rifel_fast_V4.w3x`
* **遊戲內顯示名稱**：`Stromguarde-Rifel_fast_V4.w3x`
* **改版重點**：
  1. **名稱全域同步**：實體檔名、HM3W 檔頭資訊與 `war3map.wts`（`STRING 7`）全面統一名稱為 `Stromguarde-Rifel_fast_V4.w3x`。
  2. **修復開局人口卡死**：加入動態農場補充機制（`c_food_used + 5 >= c_food_made`），防止因 54 人口上限而卡住第 2 英雄生產。
  3. **兵營與分礦順序優化**：先集結 6 步槍兵並完成雙兵營、8 步槍兵與皮甲升級後才執行開礦，避免拖慢戰力。
  4. **排除消極進攻機制（24 小時推進）**：部隊滿 8 隻步槍兵時取得全天候攻城權限，打破原版 AI 僅在白天（04:00～12:00）進攻的缺陷。
  5. **解除英雄陣亡發呆阻塞**：場上有 8 隻以上步槍兵時，英雄陣亡復活期間部隊依然保持陣形主動進攻，不再原地待命。

---

### 🔹 [Stromguarde-Rifel_fast_V3.w3x](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Rifel_fast_V3.w3x)

* **地圖檔案路徑**：`maps/Stromguarde-Rifel_fast_V3.w3x`
* **遊戲內顯示名稱**：`Stromguarde-Rifel_fast_V3.w3x`
* **改版重點**：
  1. **內嵌自訂 `Scripts\human.ai`**：解決電腦延遲至三本城堡才升級長步槍的問題。
  2. **速出步槍兵體系**：開局步兵減至 2 隻，主力資源轉向步槍兵。
  3. **戰力門檻調整**：1 英雄搭配 3 步槍兵即展開首波主動出擊。

---

### 🔹 [Stromguarde-Gemini_enhanced.w3m](file:///C:/Users/readb/.gemini/antigravity/scratch/warcraft3-maps/maps/Stromguarde-Gemini_enhanced.w3m)

* **地圖檔案路徑**：`maps/Stromguarde-Gemini_enhanced.w3m`
* **遊戲內顯示名稱**：`Stromguarde-Gemini enhanced`
* **特色說明**：
  1. 保留暴雪原版兵種數值與升級樹。
  2. 作為原版與特化版本（Rifel Fast）的對照基準地圖。
