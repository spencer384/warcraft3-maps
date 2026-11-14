# Warcraft III Custom Maps & AI Enhancements (魔獸爭霸3 地圖與自訂 AI 專區)

[![GitHub repo](https://img.shields.io/badge/GitHub-spencer384%2Fwarcraft3--maps-blue?logo=github)](https://github.com/spencer384/warcraft3-maps)

本專案收錄《魔獸爭霸3》（Warcraft III）自訂對戰地圖、數值特化機制與自訂進攻 AI 腳本。

---

## 📁 目錄結構

```text
├── maps/                               # 地圖二進位檔 (.w3x / .w3m)
│   ├── Stromguarde-Gemini_enhanced.w3m # 原版平衡對照圖
│   ├── Stromguarde-Rifel_fast_V3.w3x   # 步槍兵特化 V3
│   └── Stromguarde-Rifel_fast_V4.w3x   # 步槍兵特化 V4 (推薦最新版)
├── src/                                # 核心 AI 原始碼與腳本
│   └── Scripts/
│       └── human.ai                    # 人類專屬步槍兵特化 AI 腳本
├── docs/                               # 詳細改版履歷與地圖說明
│   └── changelog.md                    # 各地圖版本完整說明與修改紀錄
└── README.md
```

---

## 🗺️ 地圖清單與獨立說明

詳細版本歷程與各版本更新日誌，請參閱 📄 **[docs/changelog.md](docs/changelog.md)**。

| 地圖檔名 | 遊戲內名稱 | 系列分類 | 核心特色 |
| :--- | :--- | :---: | :--- |
| **`Stromguarde-Rifel_fast_V4.w3x`** | `Stromguarde-Rifel_fast_V4.w3x` | 步槍兵特化 (最新) | 射程 1000~1300、攻速 0.3s、防卡人口、雙兵營順序優化、24 小時攻城推進。 |
| **`Stromguarde-Rifel_fast_V3.w3x`** | `Stromguarde-Rifel_fast_V3.w3x` | 步槍兵特化 (歷史) | 首次內嵌自訂 `human.ai`，速出步槍兵與一本長步槍科技。 |
| **`Stromguarde-Gemini_enhanced.w3m`** | `Stromguarde-Gemini enhanced` | 原版對照平衡圖 | 維持暴雪官方原版兵種數值與科技樹，作為特化版本之對照基準。 |

---

## ⚙️ 步槍兵特化數值總覽（相較於原版 Gemini enhanced）

* **射程與索敵**：基礎攻擊距離 `1000`（原版 400），主動索敵範圍 `1150`。
* **攻速與手感**：攻擊冷卻僅 `0.3 秒`（原版 1.35 秒），出手前搖 `0.05 秒`，後搖 `0.10 秒`，彈道速度 `3000`。
* **生存與科技**：基礎防禦提升為 `3`。長步槍升級無需二本主城，升級後射程達 **`1300`**，攻速再提升 **`+20%`**。

---

## 🤖 專屬 AI 戰術亮點（`human.ai`）

1. **速科技與速兵營**：開局 2 步兵後直衝鐵匠鋪與雙兵營，迅速集結 8～14 隻步槍兵大軍。
2. **24 小時全天候推進**：步槍兵達 8 隻時解鎖攻城權限，徹底打破常規 AI 只能在上午攻城的消極模式。
3. **戰略防卡機制**：全自動補充人口，英雄陣亡期間部隊依然保持陣形積極推進。

---

## 📥 安裝與使用指引

1. 下載 `maps/` 目錄下的 `.w3x` 或 `.w3m` 地圖檔案。
2. 放入 Windows 本機魔獸爭霸3地圖資料夾：
   * 繁中/英文路徑：`此電腦 > 文件 > Warcraft III > Maps`
   * 或遊戲根目錄：`Warcraft III\Maps\`
3. 啟動遊戲建立自訂遊戲，加入電腦玩家即可開始對戰體驗。
