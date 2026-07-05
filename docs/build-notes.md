# Build Notes

対象 Mod 名:

`Controlled Difficulty: Graphite Edition`

## Build Status

Status: blocked

Reason: KF2 SDK の `KFEditor.exe` が未確認のため、Blackout Edition / Graphite Edition のビルド確認を実行できない。

Codex 側で Steam、KF2 本体、SDK フォルダに対する編集、移動、削除、設定変更、インストール操作は行わない。外部環境に対して行う操作は、確認・参照・パス確認までに限定する。

この blocked 状態は、ユーザーが SDK パスと `KFEditor.exe` の存在を確認するまで継続する。

現在の作業ブランチ:

`docs/sdk-build-notes`

このブランチの目的:

- SDK / `KFEditor.exe` 確認前後の手順を整理する。
- ビルド blocked 状態を明確にする。
- SDK パス共有後にすぐ確認へ進めるようにする。
- 作業フォルダ外部へ書き込まない運用を明文化する。

ユーザー側で確認する候補:

- Steam Library > Tools から `Killing Floor 2 - SDK` がインストール可能か確認する。
- SDK インストール後、`KFEditor.exe` が存在するか確認する。
- 候補パス: `Steam/steamapps/common/KillingFloor2SDK/`
- 候補パス: `Steam/steamapps/common/Killing Floor 2 SDK/`
- 候補実行ファイル: `Binaries/Win64/KFEditor.exe`
- 候補実行ファイル: `Binaries/Win32/KFEditor.exe`

ユーザーに共有してほしい情報:

- SDK root の絶対パス。
- `KFEditor.exe` の絶対パス。
- Steam Library 上での表示名。
- `KFEditor.exe` が `Binaries/Win64` と `Binaries/Win32` のどちらにあるか。

Codex 側で行ってよいこと:

- ユーザーが共有したパス文字列を docs に記録する。
- 作業フォルダ内でビルド用メモや設定テンプレートを作る。
- 外部パスに対して存在確認や読み取り確認を行う。

Codex 側で行わないこと:

- Steam から SDK をインストールする。
- Steam / KF2 / SDK フォルダへファイルをコピーする。
- KF2 / SDK 側の ini、Script、BrewedPC、Unpublished などを編集する。
- 外部フォルダへ `local_paths.mk`、成果物、ログ、設定ファイルを生成する。

## 現状

Blackout Edition の取得は完了。

取得先:

`vendor/blackout-edition`

現時点ではビルド未実行。理由は KF2 SDK の `KFEditor.exe` が見つかっていないため。

Graphite Edition Phase 1 のソース領域は作成済み。

Graphite ソース:

`src/ControlledDifficulty_Graphite`

現時点では Graphite Edition のビルドも未実行。理由は同じく KF2 SDK の `KFEditor.exe` が未確認のため。

## Blackout Edition のビルド方式

`Makefile` は以下を前提にしている。

- `local_paths.mk` が存在する。
- `local_paths.mk` 内で `KF2BIN` を定義する。
- `KF2BIN` は `Win64` ディレクトリを含む KF2 SDK 側の `Binaries` ディレクトリを指す。
- compile ターゲットは `KFEditor.exe make -unattended -full` を実行する。

想定される `local_paths.mk` 例:

```makefile
KF2BIN := /cygdrive/c/Program Files (x86)/Steam/steamapps/common/killingfloor2/Binaries
```

ただし、このリポジトリは Cygwin/MSYS 系の `make` と `cygpath` 前提なので、PowerShell だけではそのまま動かない。

## ローカル環境確認結果

確認できた KF2 本体:

`C:\Program Files (x86)\Steam\steamapps\common\killingfloor2`

確認できたもの:

- `Binaries\Win64\KFGame.exe`
- `Binaries\Win64\KFEditor.lnk`
- `Binaries\Win64\ExampleEditor.lnk`

見つからなかったもの:

- `Binaries\Win64\KFEditor.exe`
- `Binaries\SDKFrontend.exe`

`KFEditor.lnk` のリンク先は `D:\KF2_Main\Binaries\Win64\KFGame.exe editor` になっており、現在の実ファイルを指していない。  
このため、現状では KF2 SDK が未導入、または Steam 版本体とは別に SDK が壊れた状態/未展開の可能性が高い。

## SDK について

KF2 のコード Mod ビルドには `Killing Floor 2 - SDK` が必要。  
Steam の Library > Tools から `Killing Floor 2 - SDK` をインストールするのが通常手順。

SteamDB 上では SDK AppID は `232150`、Editor executable は `Binaries/Win64/KFEditor.exe`。

## 次の対応

1. Steam の Tools から `Killing Floor 2 - SDK` がインストール済みか確認する。
2. 未導入なら SDK をインストールする。
3. `KFEditor.exe` が存在する SDK パスを確認する。
4. ユーザーが SDK パスを共有する。
5. Codex が作業フォルダ内の docs に SDK パスと確認結果を記録する。
6. Graphite 用ビルド方式を作業フォルダ内だけで設計する。
7. 外部書き込みが不要な範囲で、`ControlledDifficulty_Graphite` のコンパイル前提を確認する。

## SDK パス判明後の確認手順

SDK パスが共有されたら、まず以下だけを行う。

1. 共有パスが作業フォルダ外部であることを明示する。
2. そのパスに対する操作は存在確認、参照、読み取り確認までに限定する。
3. `KFEditor.exe` の存在を確認する。
4. `Binaries/Win64` または `Binaries/Win32` のどちらを使うべきか記録する。
5. `src/ControlledDifficulty_Graphite` を package root として扱うビルド方針を整理する。
6. 実際の compile 前に、出力先と生成物が作業フォルダ内に限定できるか確認する。

確認時点で外部書き込みが必要だと判明した場合は、そこで停止し、ユーザーに明示確認を取る。

## Graphite Edition ビルド前チェック

ビルド開始前に確認すること:

- branch が機能別ブランチであること。
- `main` に直接実装していないこと。
- `vendor/blackout-edition` と `vendor/combined-reference` に変更がないこと。
- `src/ControlledDifficulty_Graphite/Classes` に旧 package 名 `ControlledDifficulty_Blackout` が残っていないこと。
- `CD_Survival` の GameClass が `ControlledDifficulty_Graphite.CD_Survival` であること。
- `graphite_basic` が `CD_SpawnCycleCatalog` に登録されていること。
- ビルド成果物の出力先が外部フォルダにならないこと。

## 注意

- `local_paths.mk` は Blackout Edition 側の `.gitignore` に含まれている。
- このプロジェクト側でも `vendor/` は `.gitignore` 済み。
- Workshop upload 系ターゲットは使わない。
- PR 作成はユーザーの明示指示があるまで行わない。
- `main` に直接機能実装しない。以後は目的別ブランチで進める。
