# Warcraft III Custom Maps & AI Enhancements (魔獸爭霸3 地圖與自訂 AI 專區)

[![GitHub repo](https://img.shields.io/badge/GitHub-spencer384%2Fwarcraft3--maps-blue?logo=github)](https://github.com/spencer384/warcraft3-maps)

本專案收錄《魔獸爭霸3》（Warcraft III）自訂對戰地圖、數值特化機制與自訂進攻 AI 腳本。

---

## 📁 目錄結構

```text
├── maps/                                   # 地圖二進位檔 (.w3x / .w3m)
│   ├── Stromguarde-Gemini_enhanced_V2.w3m  # 反塔防與繞後戰術引擎完整注入版 (推薦)
│   ├── Stromguarde-Gemini_enhanced.w3m     # 原版對照基準圖
│   ├── Stromguarde-Rifel_fast_V4.w3x       # 步槍兵特化 V4 (推薦)
│   └── Stromguarde-Rifel_fast_V3.w3x       # 步槍兵特化 V3
├── src/                                    # 核心 AI 與戰術引擎原始碼
│   └── Scripts/
│       ├── AMAI_AntiTower_Tactics.j        # 反塔防偵測、火砲拉扯、空軍側翼繞後 JASS 引擎
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
| **`Stromguarde-Gemini_enhanced_V2.w3m`** | `Stromguarde-Gemini_enhanced_V2.w3m` | 反塔防與繞後突襲 (最新) | 完整注入原生 JASS 戰術引擎：2.5 秒掃描敵營塔陣、攻城火砲 750~1150 碼拉扯、空軍避開正門塔網繞後偷襲農民。 |
| **`Stromguarde-Rifel_fast_V4.w3x`** | `Stromguarde-Rifel_fast_V4.w3x` | 步槍兵特化 (最新) | 射程 1000~1300、攻速 0.3s、防卡人口、雙兵營順序優化、24 小時攻城推進。 |
| **`Stromguarde-Gemini_enhanced.w3m`** | `Stromguarde-Gemini enhanced` | 歷史對照圖 | 暴雪官方原版兵種數值對照基準圖。 |
| **`Stromguarde-Rifel_fast_V3.w3x`** | `Stromguarde-Rifel_fast_V3.w3x` | 歷史特化圖 | 首次內嵌自訂 `human.ai`，速出步槍兵與一本長步槍科技。 |

---

## 🧠 核心技術亮點

### 1. 反塔防與空軍側翼繞後引擎（`AMAI_AntiTower_Tactics.j`）
* **動態塔防雷達**：每 2.5 秒輪詢敵方玩家建築，若防禦塔數量 `>= 3` 立即觸發防龜縮模式。
* **攻城武器射程維護**：強制攻城單位在 750~1150 碼極限距離開火，優先破壞防禦塔。
* **側翼向量路徑運算**：空軍部隊不再無腦衝正面塔陣送死，而是偏移 2400 碼計算側翼路徑繞至後排獵殺採集農民。

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
