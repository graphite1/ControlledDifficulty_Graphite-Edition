# Killing Floor 2 Controlled Difficulty 調査メモ

調査日: 2026-07-05  
目的: Controlled Difficulty 系 Mod の歴史背景、主要派生、最新候補、開発ベース選定材料の整理。

## 前提

このメモでは、Steam Workshop と GitHub で公開確認できる情報を基準に整理する。  
現時点ではリポジトリの clone / ダウンロード / コミット / プッシュは行っていない。

## 結論

開発ベース候補は大きく 2 系統に分かれる。

- 小さく理解して自作 CD を作るなら、原版または Blackout Edition 系が向いている。
- 現在使われる便利機能や日本語圏の運用を前提にするなら、Combined Edition 系が最有力。

最新コードという意味では、`Asapi1020/CD-Combined-Edition` の `2026-summer` ブランチが 2026-05-10 に更新されている。  
ただし Steam Workshop 公開版に近い安定候補は `main` ブランチで、最終コミットは 2025-07-14。

## 主要系譜

### 1. 始祖: blackout / Controlled Difficulty

- Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=738484519
- GitHub: https://github.com/notblackout/kf2-controlled-difficulty
- 公開: 2016-08-05
- 最終 Workshop 更新: 2018-04-11
- GitHub 最新リリース相当: `cc3eaf4`
- GitHub 最新コミット日: 2018-03-09
- 概要: KF2 の難易度要素を制御する基礎 Mod。SpawnCycle、MaxMonsters、WaveSizeFakes、SpawnMod、HPFakes など CD の中核概念を提供。

原版は設計理解には最もよいが、現在の KF2 では古く、Workshop コメント上でもクラッシュや旧版扱いの報告が見られる。

### 2. Blackout Edition

- Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2050370803
- GitHub: https://github.com/Treedestroyed/kf2-controlled-difficulty
- 対応コミット: `5d18ff7`
- 最終 GitHub コミット日: 2020-04-07
- Last Tested Game Version: v1093
- 概要: 原版に近い構造を保ちつつ、Ready System / AutoPause など実運用向けの QoL を追加した派生。

原版より現実的な基礎候補。Combined Edition のベースにもなっている。

### 3. Eternal Edition

- Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=1554427429
- 作者: HUNTER
- 公開: 2018-11-02
- 最終 Workshop 更新: 2020-09-03
- Version: v4.1
- 概要: 原版より多機能な CD 派生。Eternal / ShootingSurvival / Endless など複数 GameMode を持つ。

今回の検索範囲では、現在有効な公開 GitHub リポジトリは確認できなかった。  
2020 Winter Update 以降の HUD 問題があり、Classic Scoreboard や Yet Another Scoreboard 併用が案内されている。

### 4. Chokepoints Edition

- Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2052571175
- GameClass: `Controlled_Difficulty.CD_Survival`
- Current version: 4.5.6
- Workshop 更新表示: 2025-04-09
- 概要: 高難度・チョークポイント向けの強いゲームプレイ方針を持つ派生。

説明文上で「archived and will not receive any further updates」と明記されている。  
今回の検索範囲では、公開 GitHub リポジトリは確認できなかった。

### 5. Combined Edition

- Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2862691598
- GitHub: https://github.com/Asapi1020/CD-Combined-Edition
- 作者: あさぴっぴ [asapi]
- 公開: 2022-09-13
- Workshop 更新: 2025-07-14
- GameClass: `CombinedCD2.CD_Survival`
- GitHub `main`: `e2b5d4f`, 2025-07-14
- GitHub `2026-summer`: `75e4489`, 2026-05-10

Blackout Edition ベースの日本向け統合版。CD 本体に加え、RPW 的な制限、Admin Menu、Map Vote Menu、Client Option Menu、Scoreboard、Match Result Menu、Console Menu、Spawn Cycle Preset Menu、CustomHUD、SpawnCycle Analyzer などを含む。

## 最新と過去の違い

### 原版 / Blackout 系と Combined Edition の違い

| 観点 | 原版 / Blackout 系 | Combined Edition |
|---|---|---|
| 目的 | CD の中核機能を提供 | CD を中心に周辺機能まで統合 |
| 規模 | 小さい | 大きい |
| 構造 | 主に `Classes` 直下の単一パッケージ構成 | `SpawnCycle`, `CustomHUD`, `CombinedCD2`, `CombinedCDContent` の複数パッケージ |
| GameClass | `ControlledDifficulty.CD_Survival` / `ControlledDifficulty_Blackout.CD_Survival` | `CombinedCD2.CD_Survival` |
| UI | 基本的 | Admin Menu, Map Vote, Scoreboard, Client Option, Console Menu など |
| SpawnCycle | 基本機能 | 追加プリセット多数、Analyzer あり |
| 制限機能 | 基本的な CD 設定中心 | Perk / Level / Skill / Weapon 制限を統合 |
| 競合リスク | 比較的低い | 機能統合が多く、他 Mod と競合しやすい |
| 改造しやすさ | 読みやすい | 構造把握に時間が必要 |
| 現代運用 | 古い | 現在の運用に近い |

### ファイル規模の比較

GitHub tree から確認した概算。

| リポジトリ / ブランチ | ファイル数 | `.uc` 数 | 備考 |
|---|---:|---:|---|
| `notblackout/kf2-controlled-difficulty@master` | 111 | 87 | 原版 |
| `Treedestroyed/kf2-controlled-difficulty@master` | 154 | 129 | Blackout Edition |
| `Asapi1020/CD-Combined-Edition@main` | 391 | 330 | Workshop 公開版に近い |
| `Asapi1020/CD-Combined-Edition@2026-summer` | 392 | 331 | GitHub 上の最新作業ブランチ |

Combined Edition は原版の単純な更新ではなく、複数パッケージ化された統合 Mod と見るべき。

### `main` と `2026-summer` の違い

`Asapi1020/CD-Combined-Edition` には主に以下のブランチがある。

- `main`: 2025-07-14, `e2b5d4f`, Workshop 公開版に近い安定候補
- `2026-summer`: 2026-05-10, `75e4489`, 最新作業ブランチ
- `refactor-cd-survival`: 2024-09-02, `647d29b`, refactor 用ブランチ

`2026-summer` で確認できる追加コミットは以下。

- 2025-12-04: `add base of zed cosmetic system`
- 2025-12-06: `add UI to config ZedHatType and optimize logic`
- 2026-05-10: `fix dosh drone`

つまり、`2026-summer` は Workshop 公開版より新しいが、公開安定版かどうかは別判断が必要。

## 開発ベース候補

### 候補 A: Blackout Edition をベースにする

対象: https://github.com/Treedestroyed/kf2-controlled-difficulty

利点:

- 原版に近く、構造が比較的単純。
- CD の中核を理解しやすい。
- 自作方針を強く出しやすい。
- 競合リスクが Combined より低い。

欠点:

- 2020 年で更新停止。
- 現在の KF2 仕様との差分を自分で埋める必要がある。
- UI や便利機能は少ない。

向いている方針:

- 「自分の CD」を作る。
- まずは CD の仕組みを理解する。
- 必要な機能だけ足す。

### 候補 B: Combined Edition `main` をベースにする

対象: https://github.com/Asapi1020/CD-Combined-Edition/tree/main

利点:

- 現在の日本語圏 CD 運用に近い。
- UI、制限、MapVote、Scoreboard、SpawnCycle 周辺がすでに揃っている。
- Workshop 公開版と対応を取りやすい。

欠点:

- 大規模で把握に時間がかかる。
- 他 Mod と競合しやすい。
- 「CD 本体だけを改造したい」場合は余計な機能が多い。

向いている方針:

- 既存の Combined を改良する。
- 日本語圏サーバー向けに運用する。
- UI や管理機能を重視する。

### 候補 C: Combined Edition `2026-summer` をベースにする

対象: https://github.com/Asapi1020/CD-Combined-Edition/tree/2026-summer

利点:

- GitHub 上では最も新しい。
- 2026 年時点の追加修正を含む。

欠点:

- Workshop 公開版と一致しない可能性がある。
- 作業ブランチのため、安定性確認が必要。

向いている方針:

- 最新差分を読みたい。
- `main` を基準に、必要な差分だけ取り込む。

## 推奨方針

最初の開発ステップとしては、次の順が安全。

1. `Asapi1020/CD-Combined-Edition` の `main` を clone して構造確認。
2. `2026-summer` との差分を確認。
3. 「Combined を改造する」のか「Blackout Edition ベースで軽量 CD を作る」のか決める。
4. 方針が決まってから作業ブランチを切る。

個人的な見立てでは、参照・現代運用確認には Combined Edition、基礎理解には Blackout Edition が向いている。  
最初から `2026-summer` を土台にするより、`main` を基準にして差分を選別する方が安全。

## 参考リンク

- 原版 Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=738484519
- 原版 GitHub: https://github.com/notblackout/kf2-controlled-difficulty
- Blackout Edition Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2050370803
- Blackout Edition GitHub: https://github.com/Treedestroyed/kf2-controlled-difficulty
- Eternal Edition Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=1554427429
- Chokepoints Edition Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2052571175
- Combined Edition Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2862691598
- Combined Edition GitHub: https://github.com/Asapi1020/CD-Combined-Edition
- Controlled Difficulty Wiki: https://steamcommunity.com/sharedfiles/filedetails/?id=2851601924
- CD 日本語ガイド: https://steamcommunity.com/sharedfiles/filedetails/?id=2427951363
