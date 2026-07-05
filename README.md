# Controlled Difficulty: Graphite Edition

Killing Floor 2 の Controlled Difficulty 系 Mod を、Blackout Edition ベースのクラシック路線で開発するための作業用リポジトリ。

## Mod 名称

**Controlled Difficulty: Graphite Edition**

## 開発方針

- Blackout Edition をベースにする。
- クラシックな Controlled Difficulty 体験を維持する。
- Combined Edition を丸ごとベースにしない。
- Combined Edition は必要機能の参考実装としてのみ読む。
- 追加要素は最小限にする。

## 残す機能

- SpawnCycle
- MaxMonsters
- WaveSizeFakes
- SpawnMod
- HPFakes
- Ready System
- AutoPause
- `!ot` など基本チャットコマンド

## 追加する機能

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
- その他 Combined Edition の統合 UI 系

## 主要ドキュメント

- `AGENTS.md`: 作業ルールと現在の開発方針。
- `docs/graphite-edition.md`: Graphite Edition の製品方針。
- `docs/classic-direction.md`: クラシック路線の採用方針。
- `docs/development-plan.md`: 次の調査・実装ステップ。
- `docs/blackout-structure.md`: Blackout Edition の構造調査。
- `docs/build-notes.md`: ビルド環境メモ。
- `docs/combined-reference-notes.md`: Combined Edition 参照箇所メモ。
- `ControlledDifficulty_research.md`: Controlled Difficulty の系譜調査。

## 候補リポジトリ

- Graphite Edition 予定先: https://github.com/graphite1/ControlledDifficulty_Graphite-Edition.git
- Blackout Edition: https://github.com/Treedestroyed/kf2-controlled-difficulty
- 原版: https://github.com/notblackout/kf2-controlled-difficulty
- Combined Edition 参考用: https://github.com/Asapi1020/CD-Combined-Edition

## 現在の作業状態

- Graphite Edition 予定先 URL は確認済み。ただし `git ls-remote` では refs が空のため、空リポジトリまたは初期ブランチ未作成として扱う。
- Blackout Edition を `vendor/blackout-edition` に参照用 clone 済み。
- Combined Edition を `vendor/combined-reference` に参照用 clone 済み。
- ビルド確認は KF2 SDK の `KFEditor.exe` 未検出のため未実行。
- Graphite Edition 予定先の clone、push、PR 作成はしていない。
- コミット、プッシュ、PR 作成はしていない。
