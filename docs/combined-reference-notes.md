# Combined Edition Reference Notes

Graphite Edition で Combined Edition を限定参照するためのメモ。

対象 Mod 名:

`Controlled Difficulty: Graphite Edition`

対象リポジトリ:

https://github.com/Asapi1020/CD-Combined-Edition

ローカル参照先:

`vendor/combined-reference`

取得ブランチ:

`main`

取得コミット:

`e2b5d4f update localization CHN (#108)`

## 参照方針

Combined Edition は丸ごとベースにしない。  
クラシック路線の Blackout Edition に必要な最小機能だけを読む。

参照対象:

- `CD_AuthorityHandler.uc`
- `CD_PlayerController.uc` の RPW / restriction 周辺
- `CD_ChatCommander.uc` の `!ot` と RPW info 周辺
- Trader / Perk / Weapon restriction の hook 箇所

除外対象:

- `CD_GFx*` の UI 統合
- `xUI_*`
- Admin Menu
- Map Vote
- CustomHUD
- Scoreboard
- Analyzer UI
- Zed cosmetic

## 制限機能の核

### `CD_AuthorityHandler.uc`

制限設定を config として保持する中心。

主な変数:

- `PerkRestrictions`
- `SkillRestrictions`
- `WeaponRestrictions`
- `bRequireLv25`
- `bAntiOvercap`

主な関数:

- `ChangePerkRestriction(class<KFPerk> Perk, int Increment)`
- `ChangeWeaponRestriction(CD_WeaponInfo CDWI)`
- `GetAuthorityLevel(CD_PlayerController CDPC, optional out string LogMsg)`

Blackout へ最小実装するなら、まずは権限レベル機構を持ち込まず、単純な ban list として再設計した方が軽い。

### 型定義

型は `CustomHUD/Classes/xStructHolder.uc` にある。  
CustomHUD 依存を持ち込まないため、必要な struct だけ Blackout 側で再定義する方針がよい。

必要候補:

```uc
struct CD_WeaponInfo
{
    var class<KFWeaponDefinition> WeapDef;
    var int RequiredLevel;
    var bool bOnlyForBoss;
    var bool bNotInTrader;
};

struct CD_PerkInfo
{
    var class<KFPerk> Perk;
    var int RequiredLevel;
};
```

クラシック路線では `RequiredLevel` や `bOnlyForBoss` も不要な可能性がある。  
最小実装では以下程度で足りる可能性が高い。

```uc
struct CD_BannedWeapon
{
    var class<KFWeaponDefinition> WeapDef;
};

struct CD_BannedPerk
{
    var class<KFPerk> Perk;
};
```

## パーク禁止

Combined の実装:

- `CD_PlayerController.IsRestrictedPerk(class<KFPerk> Perk)`
- `CD_PlayerController.RestrictPlayer()`
- `CD_PlayerController.TrySwitchPerk()`
- `CD_GFxMenu_Perks.PerkChanged(...)`
- `CD_GFxMenu_Trader.PerkChanged(...)`

Combined は UI 側でも選択前ブロックしている。  
Blackout に最小実装する場合は、まず UI を置き換えず、サーバー側で禁止パーク使用を検出して別パークへ戻す方式が現実的。

最小案:

- `CD_Survival` に `config array<class<KFPerk>> BannedPerks` 相当を追加。
- `CD_PlayerController` または `CD_Survival` 側で現在 Perk を周期チェック。
- 禁止 Perk なら許可 Perk に変更、または trader 中だけ変更を促す。

注意:

- UI で選択肢を消さない場合、ユーザーは一瞬選べる。
- 強制変更のタイミングを間違えると Ready/Spawn/Trader の挙動に影響する。

## 武器禁止

Combined の実装:

- `CD_PlayerController.RestrictWeapon(Weapon Weap)`
- `CD_PlayerController.IsAllowedWeapon(class<KFWeaponDefinition> WeapDef, bool bBossWave, bool bIsDoshinegun)`
- `CD_PlayerController.ForceToSellWeap(STraderItem SoldItem, Weapon Weap)`
- `CD_GFxTraderContainer_Store.IsItemFiltered(STraderItem Item)`

Combined は以下の 2 段で制限している。

- Trader UI から禁止武器を隠す。
- 所持中の禁止武器を検出して売却/削除する。

Blackout に最小実装する場合は、UI から隠す実装は後回しでよい。  
まずは所持中の禁止武器を検出し、装備・所持を解除するサーバー側制御を優先する。

最小案:

- `config array<class<KFWeaponDefinition>> BannedWeapons` を持つ。
- `CD_PlayerController` で現在武器を周期チェック。
- `KFGameReplicationInfo(WorldInfo.GRI).TraderItems.SaleItems` から `WeaponDef` と `WeaponClassPath` を照合する。
- 禁止武器なら売却または削除する。

注意:

- Trader UI からは見えるため、購入後に即売却される挙動になりうる。
- 最終的には `KFGFxTraderContainer_Store` 派生で非表示化する方が自然だが、UI 置換になるためクラシック路線では慎重に扱う。

## `!ot` コマンド

Blackout Edition には `!ot` は見当たらない。  
Combined Edition の実装は小さい。

登録:

```uc
SetupSenderCommand("!ot", "!cdot", "Open trader menu", OpenTraderCommand);
```

実処理:

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

Blackout 側に最小追加するなら、`CD_ChatCommander` が現在 `!cd` prefix だけを受け付ける作りなので、次のどちらかが必要。

- `!ot` を例外的に受け付ける。
- `!cdot` のみ追加し、`!ot` は後で対応する。

ユーザー要望では `!ot` を残したいため、チャットコマンド判定の prefix 条件を調整する必要がある。

## 最小実装の優先順

1. `!ot` の追加。
2. ini ベースの `BannedPerks` 追加。
3. 禁止 Perk の検出と強制変更。
4. ini ベースの `BannedWeapons` 追加。
5. 禁止 Weapon の検出と削除/売却。
6. 必要になった場合だけ Trader UI 非表示を検討。

## 持ち込まない方がよいもの

- `CD_GFxMenu_Perks`
- `CD_GFxMenu_Trader`
- `CD_GFxTraderContainer_Store`
- `xUI_AdminMenu_RPW`
- `CustomHUD/Classes/xStructHolder.uc` 全体

これらは便利だが UI / CustomHUD 依存が強く、クラシック路線を崩す。
