# Build Notes

対象 Mod 名:

`Controlled Difficulty: Graphite Edition`

## Build Status

Status: blocked

Reason: KF2 SDK の `KFEditor.exe` が未確認のため、Blackout Edition / Graphite Edition のビルド確認を実行できない。

Codex 側で Steam、KF2 本体、SDK フォルダに対する編集、移動、削除、設定変更、インストール操作は行わない。外部環境に対して行う操作は、確認・参照・パス確認までに限定する。

ユーザー側で確認する候補:

- Steam Library > Tools から `Killing Floor 2 - SDK` がインストール可能か確認する。
- SDK インストール後、`KFEditor.exe` が存在するか確認する。
- 候補パス: `Steam/steamapps/common/KillingFloor2SDK/`
- 候補パス: `Steam/steamapps/common/Killing Floor 2 SDK/`
- 候補実行ファイル: `Binaries/Win64/KFEditor.exe`
- 候補実行ファイル: `Binaries/Win32/KFEditor.exe`

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
4. `vendor/blackout-edition/local_paths.mk` をローカル専用で作成する。
5. Cygwin/MSYS/Git Bash 環境で `make compile` を試す。

## 注意

- `local_paths.mk` は Blackout Edition 側の `.gitignore` に含まれている。
- このプロジェクト側でも `vendor/` は `.gitignore` 済み。
- Workshop upload 系ターゲットは使わない。
- コミット、プッシュ、PR 作成は行わない。
