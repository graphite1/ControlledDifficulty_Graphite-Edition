# AGENTS.md

## 基本ルール

- 勝手なコミット、プッシュは行わない。
- コミット、プッシュ、PR 作成、外部公開は、ユーザーから明示指示がある場合だけ行う。
- 既存ファイルを編集する前に、必ず内容を確認する。
- ユーザーが作成した変更を勝手に戻さない。
- リポジトリ clone、外部ダウンロード、依存追加、大きな変更を行う前に、作業意図を短く説明する。
- 作業対象は、この作業フォルダ内に限定する。
- 作業フォルダ外部のファイル、フォルダ、既存環境、Steam / KF2 / SDK 本体、ユーザーの個人ファイルは絶対に編集・削除・移動しない。
- 外部フォルダやローカル環境に対して行う操作は、確認・参照・パス確認までに限定する。
- 作業フォルダ外部への書き込み、設定変更、ファイル生成、コピー、上書きが必要になった場合は、必ず事前にユーザーへ確認し、明示許可を得てから行う。

## 作業フォルダ外部の扱い

- 作業対象は `C:\Users\rinnt\CodeX\KF2` 内に限定する。
- Steam、KF2 本体、KF2 SDK、ユーザーの個人ファイル、その他作業フォルダ外部の既存環境は編集・削除・移動しない。
- 外部環境に対して許可される操作は、存在確認、パス確認、参照、読み取りによる状態確認まで。
- 外部フォルダへの書き込み、設定変更、ファイル生成、コピー、上書き、インストール操作が必要な場合は、事前にユーザーへ確認し、明示許可を得る。
- SDK の導入や Steam 側の操作は Codex では実行せず、ユーザーに手順を提示する。

## Mod 名称

**Controlled Difficulty: Graphite Edition**

## 現在の開発方針

Killing Floor 2 Controlled Difficulty 系 Mod をクラシック路線で開発する。

- Blackout Edition をベースにする。
- クラシックな CD 体験を維持する。
- Combined Edition を丸ごとベースにしない。
- `Treedestroyed/kf2-controlled-difficulty` を主ベース候補にする。
- `Asapi1020/CD-Combined-Edition` は必要機能の参考実装としてのみ読む。
- 追加要素は最小限にする。

## 残したい機能

- SpawnCycle
- MaxMonsters
- WaveSizeFakes
- SpawnMod
- HPFakes
- Ready System
- AutoPause
- `!ot` など基本チャットコマンド

## 追加したい機能

- 独自 SpawnCycle 追加
- 武器禁止
- パーク禁止

## 入れない機能

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

## 作業手順

1. Blackout Edition の構造を確認する。
2. Blackout Edition をビルドできるか確認する。
3. SpawnCycle の追加方法を整理する。
4. Combined Edition の `CD_ChatCommander`、`CD_PlayerController`、Trader、Perk 制限周辺だけを参照する。
5. 武器禁止とパーク禁止を Blackout ベースへ最小実装できるか調査する。
6. まだコミット、プッシュ、PR 作成はしない。
7. 既存ファイルを編集する前に必ず内容を確認する。

## 参照

- Graphite Edition 方針: `docs/graphite-edition.md`
- 調査メモ: `ControlledDifficulty_research.md`
- クラシック路線方針: `docs/classic-direction.md`
- 開発計画: `docs/development-plan.md`
