# mas (Mac App Store) の調査手順

Mac App Store のアプリは Apple の審査を通っているのでサプライチェーン攻撃の入口としてはホームブリューよりは堅いが、過去にもベンダー側の開発者アカウント乗っ取りや、アプリの所有権が他社に売却された後のマルバージョニング (例: 一時期話題になった Bear や CleanMyMac の類似例) があり、油断はできない。

## 更新候補のリストアップ

```bash
mas outdated
```

出力例:

```
497799835  Xcode (16.4 → 16.5)
1289583905 Pixelmator Pro (3.6.4 → 3.6.5)
```

各行: `<app_id> <名前> (<current> → <latest>)`

## 候補ごとの調査ステップ

### 1. アプリの App Store ページを引く

App Store のメタ情報は WebFetch で取れる。URL は `id` を含めるだけ:

```
https://apps.apple.com/jp/app/id<APP_ID>
```

(日本リージョンが見たければ `/jp/`、米国なら `/us/`。)

WebFetch のプロンプト例:

> このページから次を抽出してください: 開発者名 (Developer)、開発者のサポート URL、最新版のリリース日、最新版の "What's New" の本文、過去のレビュー欄に "compromised", "malware", "scam" などの言及があるか。

抽出したい情報:

- **Developer 名**: 過去のスナップショットと変わっていないか
- **Developer URL**: 怪しいドメインに変わっていないか
- **What's New**: 重要な変更を確認 (例: 「新しい所有者の発表」「データ送信先の変更」)
- **直近のレビュー**: ユーザーが警告を上げていないか

### 2. ベンダー公式の変更履歴

App Store の "What's New" は短いので、ベンダーの公式 changelog ページを読むと文脈が分かる。多くの場合 Developer URL のサブパスに `release-notes` や `changelog` がある。WebFetch でリリースノート URL を取りに行く。

### 3. 開発者アカウントの所有権変更を疑うとき

「いつもと違う」と感じたら次を確認:

- Developer 名が変わった (例: 個人開発者 → 急に法人名)
- Developer URL のドメインが変わった
- 既存の開発者の他アプリと比べてビルドペースが急に速くなった
- レビュー欄に "the app changed" 系の投稿がある

これらがあれば 🟡 MEDIUM 以上に分類。

### 4. Web 上の警告調査

SKILL.md 本筋のルール (LOW は集約 1 クエリ / HIGH・MEDIUM 仮判定は個別深掘り) に従う。

HIGH/MEDIUM 候補向け個別クエリ:

```
- "<app name>" Mac App Store malware
- "<app name>" acquired OR sold "Mac"
- "<app name>" CVE
- "<app name>" sketchy OR scam <year>
```

LOW 候補の集約クエリ:

```
- "<app1>" OR "<app2>" OR ... acquired OR malware OR scam <year>
```

ベンダー買収のニュースは Apple Insider / 9to5Mac / TechCrunch などで報じられることが多い。買収自体は普通の出来事だが、買収後初のアップデートは追加情報を集めてから入れる。

## 判定の目安

| 観察結果                                                           | 分類      |
| ------------------------------------------------------------------ | --------- |
| Apple から削除された、CVE 公開済、明確な乗っ取り報告がある         | 🔴 HIGH   |
| Developer 変更 / 買収後初リリース / レビューでデータ送信の苦情多発 | 🟡 MEDIUM |
| 同一 Developer の連番パッチ更新で What's New が穏当な内容          | 🟢 LOW    |

## スキップ条件

- Apple 純正アプリ (Xcode, Pages, Keynote, Numbers など) は Developer が `Apple` 固定なので、Advisory チェックを省略してよい。リリースノートだけ見ればよい。
- Microsoft, Adobe, JetBrains のような大手ベンダーアプリも同じく、Web 検索だけで十分。

## mas が使えない場合のフォールバック

`mas` コマンドが入っていない / Apple ID にサインインしていない場合は手動でアプリ ID を集める必要がある:

```bash
# インストール済みアプリの ID 列挙
mas list
```

`mas list` が動かない環境では、`~/Applications` 配下の `.app` を `find` で列挙して、各 `.app/Contents/Info.plist` の `ITSAppUsesNonExemptEncryption` などから App Store 経由かどうかを判定する...が、ここまでするケースは稀。基本は `mas` が使える前提でよい。
