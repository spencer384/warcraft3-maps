# 版本更新紀錄 (Changelog)

### Stromguarde-Rifel_fast_V4.w3x
- **名稱標準化**：實體檔名與遊戲內顯示名稱（HM3W 檔頭、WTS 字串）全面統一名稱為 `Stromguarde-Rifel_fast_V4.w3x`。
- **AI 防卡兵機制完善**：
  - 開局階段（`basic_opening`）引入農場動態補充，避免因人口滿造成第 2 英雄及後續部隊卡住。
  - 調整出兵與分礦優先級，先完成 6 步槍兵與雙兵營後再執行開礦存錢。
  - 排除 `common.ai` 夜間不攻城的時間限制（步槍兵 >= 8 隻時解鎖全天候進攻）。
  - 排除英雄陣亡復活期間部隊在家枯等（`AwaitMeleeHeroes` 阻塞）的問題。

### Stromguarde-Rifel_fast_V3.w3x
- **初版專屬 AI 內嵌**：在 MPQ 封裝內新增自訂 `Scripts\human.ai`，使電腦具備主動速爆步槍兵並搭配長步槍推進能力。
- **地圖名稱更正**：修復 V2 殘留名稱為 V3。
