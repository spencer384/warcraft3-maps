<div align="center">

# ⚔️ WARCRAFT III: REFORGED & CLASSIC ⚔️
### Custom Maps & Native Tactical AI Enhancements
**《魔獸爭霸 III》自訂對戰地圖與進階原生戰術 AI 專區**

[![GitHub Stars](https://img.shields.io/github/stars/spencer384/warcraft3-maps?style=for-the-badge&color=gold&logo=github)](https://github.com/spencer384/warcraft3-maps)
[![Warcraft Version](https://img.shields.io/badge/WARCRAFT_III-1.29c--1.31_%2F_Reforged-red?style=for-the-badge&logo=battle.net)](https://github.com/spencer384/warcraft3-maps)
[![Map Format](https://img.shields.io/badge/MAP_FORMAT-ROC_.W3M_%7C_TFT_.W3X-blue?style=for-the-badge)](https://github.com/spencer384/warcraft3-maps)
[![AI Engine](https://img.shields.io/badge/AI_ENGINE-PURE_NATIVE_JASS-green?style=for-the-badge)](https://github.com/spencer384/warcraft3-maps)

---

> ### *"For the Alliance! Lok-tar Ogar! The Legion will fall!"*
> 歡迎來到魔獸爭霸自訂對戰戰術庫。本專案致力於打破傳統暴雪對戰 AI 之僵化行為，<br>
> 深度重構**兵種極限特化數值**與**原生 JASS 即時戰術運算引擎（Anti-Tower / Air Flank）**。

</div>

---

## 🏛️ 戰區地圖展示館 (MAP EXHIBITION)

<div align="center">

| 陣營 / 主題 | 最新旗艦版本 (.w3m / .w3x) | 核心戰術特化亮點 | 檔案下載 |
| :---: | :---: | :--- | :---: |
| 🛡️ **人類步槍特化** | **`Stromguarde-Rifel_fast_V4.w3x`** | 狙擊射程 1300、攻速 0.3s、一本長步槍、解除 24h 攻城限制 | [**[ 下載 V4 ]**](maps/Stromguarde-Rifel_fast_V4.w3x) |
| 🦅 **反塔防繞後引擎** | **`Stromguarde-Gemini_enhanced_V3.w3m`** | 每 3 秒掃描敵營防禦塔、限制攻城車防卡死、空軍側翼繞後偷襲農民 | [**[ 下載 V3 ]**](maps/Stromguarde-Gemini_enhanced_V3.w3m) |

</div>

<br>

<details>
<summary><b>📜 點擊展開：歷史版本檔案庫 (Archive Vault)</b></summary>
<br>

* **`maps/Stromguarde-Rifel_fast_V3.w3x`**：步槍兵初代 AI 整合版，速出步槍兵與一本科技。
* **`maps/Stromguarde-Gemini_enhanced_V2.w3m`**：反塔防戰術引擎語法修正版。
* **`maps/Stromguarde-Gemini_enhanced.w3m`**：暴雪官方原版兵種數值對照基準圖。

</details>

---

## ⚡ 核心戰術引擎技術 (TACTICAL AI SYSTEM)

### 1. 🎯 人類狙擊特化體系 (`human.ai`)
本專案打破原版 AI「先出 8 隻近戰步兵、拖延至三本城堡才升級長步槍」的遲緩節奏：
* **閃電速爆兵營**：開局僅保留 2 名步兵，直衝鐵匠鋪並快速架設雙兵營。
* **一本科技壓制**：有鐵匠鋪即刻研發「長步槍（`Rhri`）」，攻擊距離從 400 暴增至 **1300 碼**、攻速再提升 **+20%**。
* **全天候攻城**：常規 AI 僅在白天（04:00~12:00）進攻；特化 AI 步槍兵成軍（>= 8 隻）即解鎖全天候主動推進，且部隊不再受英雄陣亡復活所阻塞。

### 2. 🏹 反塔防龜縮與空軍側翼突襲 (`AMAI_AntiTower_Tactics.j`)
專門對抗「多重箭塔/幽魂塔防禦龜縮」戰術的原生 JASS 引擎：
* **動態塔防雷達**：每 3 秒週期輪詢各陣營防禦工事，塔數超過 3 座立即進入防龜縮模式。
* **攻城武器防卡死上限 (V3 核心)**：嚴格限制攻城單位上限為 **2 台**，徹底解決大型車輛擠塞基地出入口的致命 bug。
* **拉扯定點點殺**：攻城武器進入射程時保持 **750 ~ 1150 碼** 安全極限距離，優先點殺防禦塔。
* **空軍側翼繞後**：空軍部隊動態偏移 2400 碼向量路徑，**避開正面塔網重防，直接直插敵營後方金礦屠殺農民**。

---

## 📊 單位數值天平對照 (ARMORY BALANCE)

### 🎖️ 人類步槍兵 (Rifleman) 性能躍遷表

```text
[ 射程比較 ]
原版步槍兵:    ■■■■ (400)
特化初始:      ■■■■■■■■■■ (1000)
特化長步槍:    ■■■■■■■■■■■■■ (1300)

[ 攻擊間隔 (攻速) 比較 - 數值越小越快 ]
原版步槍兵:    ██████████████ 1.35 秒
特化步槍兵:    ███ 0.30 秒 (+20% 升級後達 0.25 秒)
```

| 兵種屬性項目 | 官方原版 (Gemini enhanced) | 步槍特化版 (Rifel fast) | 戰場影響評估 |
| :--- | :---: | :---: | :--- |
| **基礎防禦力 (`udef`)** | 0 | **3** | 大幅提升對抗野怪與衝臉部隊的生存率 |
| **基礎攻擊距離 (`ua1r`)** | 400 | **1000** | 開局即具備超遠距離阻截火力 |
| **長步槍升級 (`Rhri`)** | 需二本主城 (Keep) | **僅需一本鐵匠鋪** | 一本即可研發，射程再 **+300 (達 1300)**、攻速 **+20%** |
| **攻擊間隔 / 冷卻 (`ua1c`)** | 1.35 秒 | **0.30 秒** | 射速提升 400% 以上，傾瀉毀滅性火力 |
| **攻擊前搖 / 出手 (`udp1`)** | 0.17 秒 | **0.05 秒** | 抬手極短，點選目標瞬間開火 |
| **攻擊後搖 / 硬直 (`ubs1`)** | 0.56 秒 | **0.10 秒** | 轉火極快，目標陣亡後立即鎖定下一個敵軍 |
| **彈道飛行速度 (`ua1z`)** | 1900 | **3000** | 極速彈道，消除超遠距離攻擊之延遲與空包彈 |

---

## 📂 專案檔案結構 (DIRECTORY STRUCTURE)

```text
spencer384/warcraft3-maps/
├── maps/                                   # 地圖二進位發行檔
│   ├── Stromguarde-Gemini_enhanced_V3.w3m  # [推薦] 反塔防與攻城防卡死優化版
│   ├── Stromguarde-Gemini_enhanced_V2.w3m  # JASS 語法修正版
│   ├── Stromguarde-Gemini_enhanced.w3m     # 暴雪官方數值對照基準圖
│   ├── Stromguarde-Rifel_fast_V4.w3x       # [推薦] 步槍兵特化最新防卡出征版
│   └── Stromguarde-Rifel_fast_V3.w3x       # 步槍兵初代 AI 特化版
├── src/                                    # 核心戰術與 AI 原始代碼
│   └── Scripts/
│       ├── AMAI_AntiTower_Tactics.j        # 反塔防偵測、攻城行軍拉扯、空軍側翼繞後 JASS 引擎 (V3)
│       └── human.ai                        # 人類專屬步槍兵特化進攻 AI 腳本
├── docs/                                   # 戰術手冊與版本履歷
│   └── changelog.md                        # 詳細改版紀錄與參數修訂日誌
└── README.md                               # 本專案首頁
```

---

## 🎮 戰役啟動指引 (INSTALLATION & PLAY)

1. **下載地圖檔案**：
   * 推薦從上方表格點擊直接下載 **`Stromguarde-Rifel_fast_V4.w3x`** 或 **`Stromguarde-Gemini_enhanced_V3.w3m`**。
2. **放置地圖檔案**：
   * 將地圖放置於本機魔獸爭霸 III 專用目錄：
     * Windows 文件夾：`C:\Users\<您的使用者名稱>\Documents\Warcraft III\Maps\`
     * 或遊戲根目錄：`Warcraft III\Maps\`
3. **啟動遊戲自訂戰役**：
   * 進入遊戲選單 → **自訂遊戲 (Custom Game)** → 選擇對應地圖。
   * 加入電腦玩家（推薦設定為「人類玩家」以體驗步槍兵特化體系，或加入其他種族體驗反塔防繞後引擎）。

---

<div align="center">

📄 **更詳盡的版本修訂歷程與技術細節，請參閱 [docs/changelog.md](docs/changelog.md)**

*Developed with Passion for the Warcraft III Modding Community.*

</div>
