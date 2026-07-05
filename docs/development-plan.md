# Development Plan

対象 Mod: **Controlled Difficulty: Graphite Edition**

## Repository

Graphite Edition 予定先:

https://github.com/graphite1/ControlledDifficulty_Graphite-Edition.git

現在:

- branch: `main`
- remote: `https://github.com/graphite1/ControlledDifficulty_Graphite-Edition.git`
- latest commit: `2c6508d Initial Graphite Edition scaffold`
- local `main` と `origin/main` は同一。
- `main` は初期スキャフォールドの安定点として扱う。
- 今後の作業は目的別ブランチで行い、`main` に直接機能実装しない。

現在の作業ブランチ:

`docs/sdk-build-notes`

PR 作成はユーザーの明示指示があるまで行わない。

## Current Blocker

ビルド確認は SDK 未確認のため停止中。

- `KFEditor.exe` が見つかるまで、ビルド実行は行わない。
- Steam / KF2 / SDK など作業フォルダ外部には書き込まない。
- SDK 導入や Steam 側操作はユーザーが行う。
- Codex はパス確認、参照、作業メモ更新までに限定する。

## Next Steps

SDK 確認前に行う作業:

1. SDK / `KFEditor.exe` 確認前後の手順を docs に整理する。
2. Graphite 用 package コピーのビルド前チェック項目を整理する。
3. `graphite_basic` SpawnCycle の確認項目を整理する。
4. `!ot` を Graphite に最小追加する設計を作る。
5. 武器禁止・パーク禁止の config 名と最小 hook 位置を設計する。
6. Combined Edition 参照は `CD_ChatCommander`、`CD_PlayerController`、Trader、Perk/Weapon 制限周辺に限定する。

SDK 確認後に行う作業:

1. `local_paths.mk` のローカル設定方針を決める。
2. 外部フォルダへ書き込まずに済むビルド手順を確定する。
3. Graphite Edition の無改造相当ビルドを試す。
4. package / GameClass 名 `ControlledDifficulty_Graphite.CD_Survival` の動作を確認する。
5. `graphite_basic` の SpawnCycle 登録と parse を確認する。
6. `!ot`、武器禁止、パーク禁止の順に最小実装へ進む。

## Implementation Branch Policy

- `main` は `2c6508d Initial Graphite Edition scaffold` を初期スキャフォールドとして扱う。
- docs 整理は `docs/*` ブランチで行う。
- `!ot` 実装は別ブランチで行う。候補: `feature/ot-command`。
- 武器禁止は別ブランチで行う。候補: `feature/weapon-bans`。
- パーク禁止は別ブランチで行う。候補: `feature/perk-bans`。
- PR 作成はユーザーの明示指示があるまで行わない。

## Implementation Phase 1: Graphite package scaffold

Status: started

作成済み:

- `src/ControlledDifficulty_Graphite/Classes`
- `config/graphite`
- `src/ControlledDifficulty_Graphite/CD_Log.uci`
- `src/ControlledDifficulty_Graphite/CD_BuildInfo.uci`

実施内容:

- Blackout Edition の `Classes` を Graphite 用 source tree に複製した。
- package 参照を `ControlledDifficulty_Blackout` から `ControlledDifficulty_Graphite` へ変更した。
- GameClass 目標を `ControlledDifficulty_Graphite.CD_Survival` とした。
- 表示名を `Controlled Difficulty: Graphite Edition` とした。
- 初期 SpawnCycle preset `graphite_basic` を追加し、`CD_SpawnCycleCatalog` に登録した。

今回は未実施:

- 武器禁止の実装。
- パーク禁止の実装。
- `!ot` の実装。
- Combined Edition のコード移植。
- ビルド成果物の生成。
- git init、commit、push、PR 作成。

## Phase 1: Blackout Edition の取得前確認

- `Treedestroyed/kf2-controlled-difficulty` の構造を GitHub 上で確認する。
- 原版 `notblackout/kf2-controlled-difficulty` との差分を確認する。
- clone が必要になった時点で、ユーザーに作業意図を説明してから取得する。

現在: `vendor/blackout-edition` に参照用 clone 済み。

## Phase 2: Blackout Edition の構造確認

- `Classes` 配下の主要クラスを整理する。
- `CD_Survival`、SpawnCycle、チャットコマンド、Ready System、AutoPause の実装位置を特定する。
- ビルドスクリプト、Makefile、必要な KF2 SDK 前提を確認する。

現在: `docs/blackout-structure.md` に整理済み。

## Phase 3: ビルド可否確認

- ローカルの KF2 SDK / UnrealScript コンパイル環境を確認する。
- ビルドに必要なパス、出力先、除外対象を整理する。
- 可能なら Blackout Edition の無改造ビルドを試す。

現在: KF2 本体は検出済みだが、`KFEditor.exe` が未検出。`docs/build-notes.md` に整理済み。

## Phase 4: SpawnCycle 追加方法の整理

- 既存 SpawnCycle の定義場所と読み込み経路を確認する。
- 独自 SpawnCycle を追加する最小手順をまとめる。
- 設定ファイル追加だけで済む範囲と、コード変更が必要な範囲を分ける。

現在: `ini` 方式とプリセットクラス追加方式を `docs/blackout-structure.md` に整理済み。

## Phase 5: Combined Edition の限定参照

Combined Edition は丸ごと取り込まない。次の周辺だけを参考実装として読む。

- `CD_ChatCommander`
- `CD_PlayerController`
- Trader / Trader Inventory 周辺
- Perk 制限周辺
- Weapon 制限周辺

参照時は、UI、HUD、Map Vote、Scoreboard、Analyzer、cosmetic 系の依存を持ち込まない。

現在: `docs/combined-reference-notes.md` に整理済み。

## Phase 6: Graphite Edition 最小実装案

優先順:

1. `!ot` の追加。
2. ini ベースの `BannedWeapons` 追加。
3. 禁止 Weapon の検出と削除/売却。
4. ini ベースの `BannedPerks` 追加。
5. 禁止 Perk の検出と強制変更。
6. 独自 SpawnCycle の追加調整。
7. 必要になった場合だけ Trader UI 非表示を検討。

## 禁止事項

- ユーザー指示なしのコミット。
- ユーザー指示なしのプッシュ。
- ユーザー指示なしの PR 作成。
- `main` への直接機能実装。
- Combined Edition の統合 UI 系を丸ごと移植すること。
