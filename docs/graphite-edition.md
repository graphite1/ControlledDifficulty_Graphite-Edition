# Controlled Difficulty: Graphite Edition

## 概要

**Controlled Difficulty: Graphite Edition** は、Killing Floor 2 の Controlled Difficulty 系 Mod を Blackout Edition ベースで継承するクラシック路線の派生版。

目的は、Controlled Difficulty の核であるスポーン制御と難易度制御を維持しつつ、現代的なサーバー運用に必要な最小限の制限機能だけを追加すること。

## ベース

Graphite Edition 予定先:

https://github.com/graphite1/ControlledDifficulty_Graphite-Edition.git

主ベース:

https://github.com/Treedestroyed/kf2-controlled-difficulty

参考実装:

https://github.com/Asapi1020/CD-Combined-Edition

## 基本思想

- CD のクラシックなプレイ感を維持する。
- 大規模 UI 統合は避ける。
- 設定と挙動を読みやすく保つ。
- 追加機能はサーバー運用上の必要最小限に留める。
- Combined Edition の便利機能を必要以上に持ち込まない。

## 残す中核機能

- SpawnCycle
- MaxMonsters
- WaveSizeFakes
- SpawnMod
- HPFakes
- Ready System
- AutoPause
- 基本チャットコマンド

## Graphite Edition で追加する機能

- 独自 SpawnCycle
- 武器禁止
- パーク禁止
- `!ot` のような軽量 QoL コマンド

## Graphite Edition で入れない機能

- Admin Menu
- Map Vote Menu
- Client Option Menu
- Console Menu
- Scoreboard
- CustomHUD
- Match Result Menu
- SpawnCycle Analyzer UI
- Zed cosmetic
- その他 Combined Edition の統合 UI 系

## 初期実装方針

最初は UI を作らず、ini 設定と軽量チャットコマンドを中心に実装する。

武器禁止:

- 禁止武器リストを config として持つ。
- 所持中の禁止武器を検出する。
- 禁止武器は削除または売却する。
- Trader UI から隠す処理は後回しにする。

パーク禁止:

- 禁止パークリストを config として持つ。
- 禁止パーク使用を検出する。
- 使用中なら許可パークへ切り替える、または変更を促す。
- Perk UI の差し替えは後回しにする。

独自 SpawnCycle:

- まず `SpawnCycle=ini` で検証する。
- 安定したら `CD_SpawnCycle_Preset_*` としてプリセット化する。

## Phase 1 source layout

Package 名:

`ControlledDifficulty_Graphite`

GameClass:

`ControlledDifficulty_Graphite.CD_Survival`

表示名:

`Controlled Difficulty: Graphite Edition`

ソース領域:

`src/ControlledDifficulty_Graphite/Classes`

初期 SpawnCycle preset:

`graphite_basic`

現状:

- Blackout Edition の `Classes` を Graphite 用に複製済み。
- Graphite 側 package 参照へ置換済み。
- `graphite_basic` は追加経路確認用の軽量テスト SpawnCycle として追加済み。
- SDK / `KFEditor.exe` 未確認のため、ビルド確認は blocked。

## 未決事項

- Graphite Edition 予定先リポジトリは、現時点では refs が空のため初期ブランチ作成方針を決める必要がある。
- package 名は現時点で `ControlledDifficulty_Graphite` を基本候補とする。
- GameClass 名は現時点で `ControlledDifficulty_Graphite.CD_Survival` を基本候補とする。
- 武器禁止・パーク禁止の config 名。
- 禁止武器を「削除」するか「売却」するか。
- Workshop 公開を想定するか、サーバー専用にするか。
