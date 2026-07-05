# Classic Direction

## 方針

**Controlled Difficulty: Graphite Edition** は、Killing Floor 2 Controlled Difficulty 系 Mod をクラシック路線で継承する派生版。

主ベース候補は Blackout Edition:

https://github.com/Treedestroyed/kf2-controlled-difficulty

Combined Edition は参考実装としてのみ使う:

https://github.com/Asapi1020/CD-Combined-Edition

## 採用理由

Blackout Edition は原版 Controlled Difficulty に近く、構造が比較的単純。  
SpawnCycle、MaxMonsters、WaveSizeFakes、SpawnMod、HPFakes、Ready System、AutoPause といった CD の中核を保ちながら、余計な統合 UI を避けられる。

Combined Edition は現代的で便利だが、Admin Menu、Map Vote、CustomHUD、Scoreboard など統合機能が多く、Graphite Edition のベースとしては大きすぎる。必要箇所だけ参考にする。

## 残す機能

- SpawnCycle
- MaxMonsters
- WaveSizeFakes
- SpawnMod
- HPFakes
- Ready System
- AutoPause
- `!ot` など基本チャットコマンド

## 追加する候補

- 独自 SpawnCycle
- 武器禁止
- パーク禁止

## 取り込まない機能

- Admin Menu
- Map Vote Menu
- Client Option Menu
- Console Menu
- Scoreboard
- CustomHUD
- Match Result Menu
- SpawnCycle Analyzer UI
- Zed cosmetic
- Combined Edition のその他統合 UI 系

## Combined Edition から読む範囲

- `CD_ChatCommander`
- `CD_PlayerController`
- Trader / Trader Inventory 周辺
- Perk 制限周辺
- Weapon 制限周辺

## 判断ポイント

- 武器禁止・パーク禁止を ini 設定で制御するか、チャットコマンドで制御するか。
- 既存 package 名を使うか、新しい package 名にするか。
- Workshop 公開を想定するか、ローカル/サーバー専用にするか。
- Combined Edition の実装を読む際、UI 依存をどこで切るか。
