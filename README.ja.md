# Markdown絵文字表示テスト

[English](README.md) | 日本語

## はじめに

Unicodeには様々な絵文字の記述方法がある。

* 基本(単独)絵文字
* 文字キー
* 国旗・地域旗
* 修飾子(肌の色)
* ゼロ幅接合子シーケンス

これらは[Unicode技術標準#51](https://unicode.org/reports/tr51/)で定義されているが、実際の表示環境では新しい仕様ほど未実装の場合が多い。また標準とデフォルト動作が異なったり、さらにはUnicode標準にない独自仕様を持つ環境も多い。

### テストデータ

Unicodeではこのためのテストデータを用意しており、ターゲット環境上で表示させてUnicode仕様にどれだけ準拠しているか確認することができる。HTML版とテキスト版の2種類がある。

* HTML: https://www.unicode.org/emoji/charts/emoji-style.html
    * [テキスト出力(VS15指定)](https://www.unicode.org/emoji/charts/emoji-style.html#text+ts_plain)
    * [文字コードのみ(どちらを表示するか環境依存)](https://www.unicode.org/emoji/charts/emoji-style.html#text-vs_plain)
    * [絵文字出力(VS16指定)](https://www.unicode.org/emoji/charts/emoji-style.html#text+es_plain)
    * [絵文字のみの文字](https://www.unicode.org/emoji/charts/emoji-style.html#emoji_cps_plain)
    * [旗](https://www.unicode.org/emoji/charts/emoji-style.html#emoji_reg/tags_plain)
    * [修飾子(肌の色)](https://www.unicode.org/emoji/charts/emoji-style.html#modifier_plain)
    * [セロ幅接合子シーケンス](https://www.unicode.org/emoji/charts/emoji-style.html#zwj_emoji_plain)
* テキスト: https://www.unicode.org/emoji/charts/emoji-style.txt

### 目的

Web用などの文書作成にはMarkdownが幅広く用いられるようになったが、Unicodeでは絵文字テストデータのMarkdown版は用意されていない。今回Markdown版を一式作成した。

## [単独絵文字](ja/basic-emojis.md)

Unicodeの単一文字で絵文字を表現する場合には2種類ある。

* 絵文字専用コード(例: U+1F9F2 → &#x1F9F2;)
* テキスト・絵文字共有コード(例: U+2601 → &#x2601;&#xFE0E;, &#x2601;&#xFE0F;)

同じ文字コードがテキスト・絵文字両方の表現を持つ場合、その選択にVS15(U+FE0E)またはVS16(U+FE0F)を用いる。これらは異体字セレクタ(Variation selectors)と呼ばれ、表現が複数ある文字に対して用いられる。

https://en.wikipedia.org/wiki/Variation_Selectors_(Unicode_block)

対象文字コードの後にVS15(テキスト指定)またはVS16(絵文字指定)を追加して表現を指定する。VS15/16は片方の表現しか持たない文字に対しては単に無視される。適用例は次の通り。U+0041はテキストのみ、U+1F9F2は絵文字のみ、またU+00A9とU+2601は両方が可能でVS15/16で表示を選択する。

| 文字 | デフォルト | VS15あり | VS16あり |
| :-: | :-: | :-: | :-: |
| U+0041 | `&#x0041;`<br>&#x0041; | `&#x0041;&#xFE0E;`<br>&#x0041;&#xFE0E; | `&#x0041;&#xFE0F;`<br>&#x0041;&#xFE0F; |
| U+00A9 | `&#x00A9;`<br>&#x00A9; | `&#x00A9;&#xFE0E;`<br>&#x00A9;&#xFE0E; | `&#x00A9;&#xFE0F;`<br>&#x00A9;&#xFE0F; |
| U+2601 | `&#x2601;`<br>&#x2601; | `&#x2601;&#xFE0E;`<br>&#x2601;&#xFE0E; | `&#x2601;&#xFE0F;`<br>&#x2601;&#xFE0F; |
| U+1F9F2 | `&#x1F9F2;`<br>&#x1F9F2; | `&#x1F9F2;&#xFE0E;`<br>&#x1F9F2;&#xFE0E; | `&#x1F9F2;&#xFE0F;`<br>&#x1F9F2;&#xFE0F; |

なおデフォルト(VS15/16なし)の場合にどちらが選択されるかは表示環境により一般に異なる。またサポート上の理由で一方しか表示できなかったり、あるいは未対応で表示できない場合もある。

> 公式仕様では[emoji-sequences.txt]の`type_field`が`Basic_Emoji`の場合が単独絵文字で、コード表示が`FE0F`とのシーケンスの場合はテキスト、単独の場合は絵文字がデフォルト。ただし厳密なものではなく、上記の公式テストデータではVS15/16なしの場合は「環境依存」(may vary by platform)と表現している。

Markdownの表示テスト用一覧表は次の通り。

→ [単独絵文字](ja/basic-emojis.md)

表には公式仕様で単独絵文字表現を持つ全文字コードがある(絵文字を持たないコード領域は除外)。セル内には文字コード表現が次の4行で入力されている。

* コーススパン内に文字入力
* デフォルト(VS15,16なし)
* テキスト指定(VS15付き)
* 絵文字指定(VS16付き)

各文字のコードスパン上にマウスカーソルを置くとポップアップで文字コードとUnicodeの文字名、採用されたUnicodeバージョンを表示する。2行目以降は実際の入力シーケンスを16進表現でポップアップする。

> GitHub Markdownの仕様は全体的に絵文字優先でUnicodeとかなり異なる。例えばU+2194`↔`はUnicode標準ではテキストがデフォルトだが、GitHub Markdownは絵文字がデフォルト。またU+26BD`⚽`は本来は両方の表現が可能だが、GitHub MarkdownではVS15が効かずコードスパンの場合だけテキスト表現になる。

## [文字キー](ja/keycaps.md)

UnicodeにはCOMBINING ENCLOSING KEYCAP(U+20E3&emsp;&#x20E3;)という[結合文字]があり、他の文字と組み合わせてキーボードなどボタン上に書かれた文字を表現するのに用いられる。この中で電話のダイヤルボタンに用いられるキー(`#`,` * `,`0`..`9`)にだけ絵文字表現が存在する。

→ [文字キー](ja/keycaps.md)

## [国旗・地域旗](ja/flags.md)

Unicode絵文字では国や地域の旗はREGIONAL INDICATOR SYMBOL LETTER(U+1F1E6..U+1F1FF) 2文字の組み合わせで表現する。

→ [国旗・地域旗](ja/flags.md)

> 多くの表示環境では各国の国旗ではなく、小さめのアルファベット2文字をそのまま表示する。

## [タグ(国・地域内部の旗)](ja/tags.md)

国や地域のさらに内部の区域を表す旗にはタグと呼ばれる専用文字によるシーケンスが用いられる。タグに関しては次の英語版Wikipediaが詳しい。

https://en.wikipedia.org/wiki/Tags_(Unicode_block)

元々は言語の種類を表すために作られたものだが、現在は絵文字に転用されており、イギリス国内の地方の旗を表現する目的にのみ用いられている。

→ [タグ(国・地域内部の旗)](ja/tags.md)

## [修飾子](ja/modifiers.md)\([肌の色](ja/skin-tones.md)\)

Unicode絵文字には修飾子(modifiers)と呼ばれる文字コードがあり、既存の絵文字とのシーケンスで表示効果を加える。現在は肌の色を表現する次の修飾子コードがある。

| Code | Name |
| - | - |
| U+1F3FB | EMOJI MODIFIER FITZPATRICK TYPE-1-2 |
| U+1F3FC | EMOJI MODIFIER FITZPATRICK TYPE-3 |
| U+1F3FD | EMOJI MODIFIER FITZPATRICK TYPE-4 |
| U+1F3FE | EMOJI MODIFIER FITZPATRICK TYPE-5 |
| U+1F3FF | EMOJI MODIFIER FITZPATRICK TYPE-6 |

https://en.wikipedia.org/wiki/Emoji#Skin_color

これらは人物や人体の部位を表す絵文字に対して作用する。例を示す。

| 修飾子 | U+1F44D<br>👍 | U+1F9B6<br>🦶 | U+1F9D1<br>🧑 |
| :-: | :-: | :-: | :-: |
| 1-2 | 👍&#x1F3FB; | 🦶&#x1F3FB; | 🧑&#x1F3FB; |
| 3 | 👍&#x1F3FC; | 🦶&#x1F3FC; | 🧑&#x1F3FC; |
| 4 | 👍&#x1F3FD; | 🦶&#x1F3FD; | 🧑&#x1F3FD; |
| 5 | 👍&#x1F3FE; | 🦶&#x1F3FE; | 🧑&#x1F3FE; |
| 6 | 👍&#x1F3FF; | 🦶&#x1F3FF; | 🧑&#x1F3FF; |

適用可能な全ての絵文字及びシーケンスは次の通り(人体に無関係な絵文字には効果がないため除外)。

→ [修飾子](ja/modifiers.md)

発色の違いによる表示比較サンプルは次を参照。

→ [肌の色](ja/skin-tones.md)

## [ゼロ幅接合子シーケンス](ja/zwj-sequences.md)

ゼロ幅接合子(ZERO WIDTH JOINER U+200D)を用いて複数の絵文字コードを合成して表現する。Unicode絵文字で可能な組み合わせは[emoji-zwj-sequences.txt]に記述されている。全リストとその表示サンプルは次の通り。

→ [ゼロ幅接合子シーケンス](ja/zwj-sequences.md)

## 表の生成

一覧表はRubyを用いて自動生成しており、最新版は次のように生成できる。Unicodeサイトから最新データを取得して全ての表を更新する。

```
$ cd src
$ ruby generate-all.rb
```

## リファレンス

Unicode® Emoji: https://unicode.org/emoji/techindex.html

Unicode® Technical Standard #51: https://unicode.org/reports/tr51/

[emoji-sequences.txt]: https://www.unicode.org/Public/emoji/latest/emoji-sequences.txt
[emoji-zwj-sequences.txt]: https://www.unicode.org/Public/emoji/latest/emoji-zwj-sequences.txt
[結合文字]: https://ja.wikipedia.org/wiki/結合文字
