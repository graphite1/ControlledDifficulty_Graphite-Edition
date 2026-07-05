# `!ot` Command Prep

Controlled Difficulty: Graphite Edition で `!ot` を最小実装するための準備メモ。

このメモは実装前整理であり、現時点ではソースコードを変更しない。

## 目的

Trader が開いている間に、プレイヤーがチャットから Trader menu を開けるようにする。

想定コマンド:

- `!ot`
- 必要なら互換用に `!cdot`

## Blackout 側で触る候補クラス

主候補:

- `src/ControlledDifficulty_Graphite/Classes/CD_ChatCommander.uc`
- `src/ControlledDifficulty_Graphite/Classes/CD_PlayerController.uc`
- `src/ControlledDifficulty_Graphite/Classes/CD_Survival.uc`

優先して読む箇所:

- `CD_ChatCommander.SubmitChatCommand`
- `CD_ChatCommander.RegisterChatCommands`
- `CD_ChatCommander.Setup...Command` 系の登録処理
- `CD_PlayerController` の chat / echo / HUD 連携
- `CD_Survival` の Trader open / close / pause / unpause 周辺

## 既存チャットコマンド処理の位置

Blackout の `CD_ChatCommander` は、既存コマンドを `!cd` prefix 中心で扱う。

確認済みの注意点:

- Blackout には `!ot` は見当たらない。
- 既存のコマンド判定は `!cd` prefix 前提のため、`!ot` をそのまま通すには例外処理が必要。
- `!cdpt`、`!cdupt` など TraderTime 操作用コマンドは既存実装を流用できる参考箇所。

最小方針:

1. まず `!cdot` を既存 prefix 体系に沿って追加できるか確認する。
2. その後、`!ot` を例外的に受け付ける分岐を追加する。
3. 既存 command table の構造を崩さない。

## Trader を開く処理の候補

Combined Edition の実装は `CD_PlayerController.OpenTraderMenu()` を呼ぶ。

Graphite / Blackout 側で確認すること:

- `CD_PlayerController` が `OpenTraderMenu()` を直接呼べるか。
- Trader open 判定として `KFGameReplicationInfo(WorldInfo.GRI).bTraderIsOpen` を使えるか。
- `CD_Survival` 側に既存の Trader open state 判定があるか。
- Trader が閉じている時は何もしないか、短いメッセージを返すか。

初期案:

```uc
if ( MyKFGRI != None && MyKFGRI.bTraderIsOpen )
{
    CDPC.OpenTraderMenu();
}
```

ただし、実際の型名と参照経路は SDK 確認後にコンパイルしながら確定する。

## Combined Edition で参照するファイル

参照対象:

- `vendor/combined-reference/CombinedCD2/Classes/CD_ChatCommander.uc`
- `vendor/combined-reference/CombinedCD2/Classes/CD_PlayerController.uc`

Combined 側の `!ot` 概要:

```uc
SetupSenderCommand("!ot", "!cdot", "Open trader menu", OpenTraderCommand);
```

```uc
private function string OpenTraderCommand(const array<string> Params, CD_PlayerController CDPC)
{
    if(MyKFGRI.bTraderIsOpen)
    {
        CDPC.OpenTraderMenu();
    }
    return "";
}
```

Combined の UI / admin / menu 依存は持ち込まない。

## Blackout 由来で流用できる箇所

流用候補:

- `CD_ChatCommander` の command 登録構造。
- 既存の sender / authority 判定。
- 既存の TraderTime pause / unpause command のレスポンス形式。
- `CD_PlayerController` の echo message 表示。

流用しないもの:

- Combined Edition の menu UI。
- CustomHUD 依存。
- Admin Menu / Client Option Menu / Console Menu。

## 実装前チェックリスト

- 作業ブランチが `feature/ot-command` など目的別ブランチであること。
- `main` へ直接実装していないこと。
- SDK / `KFEditor.exe` の確認状況を確認すること。
- 変更対象を `src/ControlledDifficulty_Graphite/Classes` に限定すること。
- `vendor/blackout-edition` と `vendor/combined-reference` を直接編集しないこと。
- `!ot` 以外の武器禁止・パーク禁止には触れないこと。

