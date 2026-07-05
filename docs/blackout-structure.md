# Blackout Edition Structure

Graphite Edition の主ベース調査メモ。

対象 Mod 名:

`Controlled Difficulty: Graphite Edition`

対象リポジトリ:

https://github.com/Treedestroyed/kf2-controlled-difficulty

ローカル取得先:

`vendor/blackout-edition`

取得コミット:

`5d18ff7 Update CD_Survival.uc`

## 構成概要

Blackout Edition は単一パッケージ型の Controlled Difficulty 派生。

- `Classes/`: UnrealScript ソース本体。
- `CD_Survival.uc`: GameInfo 中心。設定、SpawnCycle 読み込み、Ready System、AutoPause、Trader pause/unpause、HPFakes などの中核。
- `CD_ChatCommander.uc`: チャットコマンドの登録・実行。
- `CD_PlayerController.uc`: CD 用 PlayerController。Ready 状態などを保持。
- `CD_SpawnCycleCatalog.uc`: SpawnCycle プリセットの登録と解決。
- `CD_SpawnCycleParser.uc`: SpawnCycle 文字列の解析。
- `CD_SpawnCycle_Preset*.uc`: 個別 SpawnCycle プリセット。
- `CD_DynamicSetting_*.uc`: MaxMonsters、WaveSizeFakes、SpawnMod、HPFakes など動的設定。
- `CD_BasicSetting_*.uc`: SpawnCycle、AutoPause、Ready System、TraderTime など基本設定。

## Graphite Phase 1 コピー前記録

コピー元:

`vendor/blackout-edition/Classes`

コピー先:

`src/ControlledDifficulty_Graphite/Classes`

コピー元の確認結果:

- `Classes` 直下に UnrealScript `.uc` ファイルが 129 件ある。
- 主要クラスは `CD_Survival.uc`、`CD_PlayerController.uc`、`CD_ChatCommander.uc`、`CD_SpawnCycleCatalog.uc`、`CD_SpawnCycleParser.uc`、`CD_SpawnManager*.uc`、`CD_SpawnCycle_Preset*.uc`。
- `vendor/blackout-edition` は参照元としてのみ扱い、直接編集しない。
- Graphite 側の編集対象は `src/ControlledDifficulty_Graphite/Classes` に複製したファイルに限定する。

Graphite Phase 1 の置換方針:

- `ControlledDifficulty_Blackout` 参照は、Graphite 側では `ControlledDifficulty_Graphite` へ置換する。
- `config( ControlledDifficulty_Blackout )` は `config( ControlledDifficulty_Graphite )` へ置換する。
- GameClass は `ControlledDifficulty_Graphite.CD_Survival` を目標にする。
- 表示名は `Controlled Difficulty: Graphite Edition` を使う。
- 機械的な広範囲移植は避け、Blackout の構造を保ったまま Graphite 用 package 参照に必要な箇所だけを変更する。

## Graphite Phase 1 実施結果

作成した Graphite 用ソース領域:

`src/ControlledDifficulty_Graphite/Classes`

補助領域:

`config/graphite`

実施内容:

- `vendor/blackout-edition/Classes` の `.uc` 129 件を `src/ControlledDifficulty_Graphite/Classes` へ複製した。
- Graphite 独自 SpawnCycle として `CD_SpawnCycle_Preset_graphite_basic.uc` を追加した。
- Graphite 側の `.uc` は合計 130 件になった。
- `src/ControlledDifficulty_Graphite/CD_Log.uci` と `src/ControlledDifficulty_Graphite/CD_BuildInfo.uci` を追加した。
- `ControlledDifficulty_Blackout` 参照は Graphite 側コピー内で `ControlledDifficulty_Graphite` に置換した。
- `CD_Survival.uc` の `config` は `ControlledDifficulty_Graphite` に変更した。
- `CDGameModes` の `FriendlyName` は `Controlled Difficulty: Graphite Edition` に変更した。
- `CDGameModes` / `GameInfoClassAliases` の GameClass は `ControlledDifficulty_Graphite.CD_Survival` に変更した。
- `CD_ChatCommander.uc` のコマンド一覧見出しを Graphite Edition 表記に変更した。
- `CD_SpawnCycleCatalog.uc` に `graphite_basic` preset を登録した。

未確認事項:

- SDK / `KFEditor.exe` 未確認のため、Graphite package としてのコンパイル確認は未実施。
- `graphite_basic` は追加経路確認用の軽量テスト SpawnCycle であり、バランス調整は未実施。
- package 名は `ControlledDifficulty_Graphite`、GameClass は `ControlledDifficulty_Graphite.CD_Survival` を現時点の前提とする。
- `vendor/blackout-edition` と `vendor/combined-reference` は直接編集していない。

## 残したい機能の実装位置

| 機能 | 主な実装 |
|---|---|
| SpawnCycle | `CD_Survival.uc`, `CD_SpawnCycleCatalog.uc`, `CD_SpawnCycleParser.uc`, `CD_SpawnCycle_Preset*.uc` |
| MaxMonsters | `CD_DynamicSetting_MaxMonsters.uc`, `CD_Survival.uc` |
| WaveSizeFakes | `CD_DynamicSetting_WaveSizeFakes.uc`, `CD_Survival.uc` |
| SpawnMod | `CD_DynamicSetting_SpawnMod.uc`, `CD_DummyGameConductor.uc`, `CD_Survival.uc` |
| HPFakes | `CD_DynamicSetting_*HPFakes.uc`, `CD_Survival.uc` |
| Ready System | `CD_BasicSetting_EnableReadySystem.uc`, `CD_PlayerController.uc`, `CD_Survival.uc` |
| AutoPause | `CD_BasicSetting_AutoPause.uc`, `CD_Survival.uc` |
| Trader pause/unpause | `CD_ChatCommander.uc`, `CD_Survival.uc` |

注意: Blackout Edition には `!ot` は見当たらない。`!ot` は Combined Edition 側の小さな追加機能として参照し、Blackout へ最小追加する候補とする。

## SpawnCycle 追加方法

Blackout Edition には 2 通りの追加方法がある。

### 方法 A: ini 定義

`SpawnCycle=ini` を指定し、`KFGame.ini` の `[ControlledDifficulty_Blackout.CD_Survival]` セクションに `SpawnCycleDefs` を書く。

利点:

- コード変更なしで試せる。
- まず独自 SpawnCycle を検証する用途に向く。

欠点:

- プリセット名として組み込まれない。
- 配布時にユーザー側 ini 設定が必要。

### 方法 B: プリセットクラス追加

1. `CD_SpawnCycle_PresetBase` を継承し、`CD_SpawnCycle_Preset` を implements するクラスを追加する。
2. `GetShortSpawnCycleDefs` / `GetNormalSpawnCycleDefs` / `GetLongSpawnCycleDefs` に wave 定義を書く。
3. `CD_SpawnCycleCatalog.InitSpawnCyclePresetList()` に `SpawnCyclePresetList.AddItem(new class'...')` を追加する。

利点:

- `SpawnCycle=<name>` として通常プリセット化できる。
- 配布時に追加設定が少ない。

欠点:

- コード変更と再ビルドが必要。

## 武器禁止・パーク禁止の見立て

Blackout Edition には、Combined Edition のような RPW 系の武器/パーク制限は含まれていない。

最小実装候補:

- ini に禁止リストを持たせる。
- PlayerController / GameInfo / Trader 周辺で購入、装備、パーク選択を制限する。
- まずは UI を作らず、サーバー設定または基本チャットコマンドで制御する。

調査対象:

- Blackout 側: `CD_PlayerController.uc`, `CD_Survival.uc`, `CD_ChatCommander.uc`
- Combined 側: `CD_ChatCommander`, `CD_PlayerController`, Trader / Perk / Weapon restriction 周辺

## 次に見るべき箇所

- `CD_ChatCommander.uc` のコマンド登録方式。
- `CD_PlayerController.uc` が KF2 標準 PlayerController のどの挙動を override しているか。
- `CD_Survival.uc` の `InitGame`, `PostLogin`, TraderOpen state, inventory/trader 関連 hook。
- Combined Edition の restriction 実装で UI 依存を持たない最小部分。
