# Warcraft III Custom Maps & AI Enhancements (魔獸爭霸3 地圖與自訂 AI 專區)

[![GitHub repo](https://img.shields.io/badge/GitHub-spencer384%2Fwarcraft3--maps-blue?logo=github)](https://github.com/spencer384/warcraft3-maps)

本專案收錄《魔獸爭霸3》（Warcraft III）自訂對戰地圖、數值特化機制與自訂進攻 AI 腳本。

---

## 📁 目錄結構

```text
├── maps/                                   # 地圖二進位檔 (.w3x / .w3m)
│   ├── Stromguarde-Gemini_enhanced_V3.w3m  # 攻城防卡死與基地出征優化版 (推薦最新)
│   ├── Stromguarde-Gemini_enhanced_V2.w3m  # JASS 語法修復版
│   ├── Stromguarde-Gemini_enhanced.w3m     # 原版對照基準圖
│   ├── Stromguarde-Rifel_fast_V4.w3x       # 步槍兵特化 V4 (推薦最新)
│   └── Stromguarde-Rifel_fast_V3.w3x       # 步槍兵特化 V3
├── src/                                    # 核心 AI 與戰術引擎原始碼
│   └── Scripts/
│       ├── AMAI_AntiTower_Tactics.j        # 反塔防偵測、攻城行軍拉扯、空軍側翼繞後 JASS 引擎 (V3)
│       └── human.ai                        # 人類專屬步槍兵特化對戰 AI 腳本
├── docs/                                   # 詳細改版履歷與地圖說明
│   └── changelog.md                        # 各地圖版本完整說明與修改紀錄
└── README.md
```

---

## 🗺️ 地圖清單與獨立說明

詳細版本歷程與各版本更新日誌，請參閱 📄 **[docs/changelog.md](docs/changelog.md)**。

| 地圖檔名 | 遊戲內名稱 | 系列分類 | 核心特色 |
| :--- | :--- | :---: | :--- |
| **`Stromguarde-Gemini_enhanced_V3.w3m`** | `Stromguarde-Gemini_enhanced_V3.w3m` | 反塔防與繞後突襲 (**推薦最新**) | **修復後期投石車擠死基地問題**：嚴格限制攻城車上限（最多 2 台）、攻城武器出征推進引導、空軍繞後偷襲農民。 |
| **`Stromguarde-Gemini_enhanced_V2.w3m`** | `Stromguarde-Gemini_enhanced_V2.w3m` | 反塔防與繞後突襲 | 修正 JASS 語法，完整注入反塔防戰術引擎。 |
| **`Stromguarde-Gemini_enhanced.w3m`** | `Stromguarde-Gemini enhanced` | 歷史對照圖 | 暴雪官方原版兵種數值對照基準圖。 |
| **`Stromguarde-Rifel_fast_V4.w3x`** | `Stromguarde-Rifel_fast_V4.w3x` | 步槍兵特化 (**推薦最新**) | 射程 1000~1300、攻速 0.3s、防卡人口、雙兵營順序優化、24 小時攻城推進。 |
| **`Stromguarde-Rifel_fast_V3.w3x`** | `Stromguarde-Rifel_fast_V3.w3x` | 歷史特化圖 | 首次內嵌自訂 `human.ai`，速出步槍兵與一本長步槍科技。 |

---

## 🧠 核心技術亮點

### 1. 反塔防、防卡死與空軍側翼繞後引擎（`AMAI_AntiTower_Tactics.j` - V3）
* **數量嚴格控管（防堵死）**：加入 `MAX_SIEGE_UNITS = 2` 限制，徹底避免後期無窮產出大型攻城車堵死基地出口。
* **基地出征引導**：攻城武器在基地周遭且無敵塔時，自動對敵營下達移動攻擊指令，引導開赴前線。
* **攻城武器極限拉扯**：在 750~1150 碼極限距離開火，優先定點拆毀防禦塔。
* **側翼向量路徑運算**：空軍部隊避開正面火網，偏移 2400 碼計算側翼路徑繞至後排獵殺採集農民。

### 2. 步槍兵極限特化與進攻 AI（`human.ai`）
* **極限射擊屬性**：射程 1000~1300、攻速 0.3s、前搖 0.05s、彈道 3000。
* **開局科技特化**：一本鐵匠鋪直升長步槍，雙兵營迅速擴編 8~14 隻步槍兵。
* **全天候進攻機制**：消除原版 AI 僅在白天攻城的限制，兵力達標即展開 24 小時連續壓制。

---

## 📥 安裝與使用指引

1. 下載 `maps/` 目錄下的 `.w3x` 或 `.w3m` 地圖檔案。
2. 放入 Windows 本機魔獸爭霸3地圖資料夾：
   * 繁中/英文路徑：`此電腦 > 文件 > Warcraft III > Maps`
   * 或遊戲根目錄：`Warcraft III\Maps\`
3. 啟動遊戲建立自訂遊戲，加入電腦玩家即可開始對戰體驗。
