# Markdown Emoji presentation test

English | [Japanese](README.ja.md)

## Introduction

Unicode standard has various emoji representation methods as follows.

* Basic (stand-alone) emojis
* Keycaps
* Flags
* Modifiers (skin tones)
* Zero width joiner sequences

They are defined in [Unicode® Technical Standard #51](https://unicode.org/reports/tr51/). However, most presentation environments do not supports these specs strictly. Some of them support partially, or others have extra features which are not present in Unicode standard.

### Test data

Unicode privides presentation test documents for emojis. You can open these documents with browsers or text editors, and check how they display emoji characters and sequences.

* HTML: https://www.unicode.org/emoji/charts/emoji-style.html
    * [Characters which should be displayed as text (using VS15)](https://www.unicode.org/emoji/charts/emoji-style.html#text+ts_plain)
    * [Characters which presentations depend on platforms (character-only)](https://www.unicode.org/emoji/charts/emoji-style.html#text-vs_plain)
    * [Characters which should be displayed as emoji (using VS16)](https://www.unicode.org/emoji/charts/emoji-style.html#text+es_plain)
    * [Emoji-only characters](https://www.unicode.org/emoji/charts/emoji-style.html#emoji_cps_plain)
    * [Flags](https://www.unicode.org/emoji/charts/emoji-style.html#emoji_reg/tags_plain)
    * [Modifiers](https://www.unicode.org/emoji/charts/emoji-style.html#modifier_plain)
    * [ZWJ sequences](https://www.unicode.org/emoji/charts/emoji-style.html#zwj_emoji_plain)
* Text: https://www.unicode.org/emoji/charts/emoji-style.txt

### Motivation

Markdown has been widely used for documentation recently. But Unicode does not provide any presentation documetns for Markdown.

Unicode emoji presentation test documents for Markdown are made as follows.

## [Basic (stand-alone) emojis](en/basic-emojis.md)

There are two types for Unicode stand-alone emoji presentations.

* Emoji-only characters (e.g. U+1F9F2 → &#x1F9F2;)
* Characters which have both text and emoji presentations (e.g. U+2601 → &#x2601;&#xFE0E;, &#x2601;&#xFE0F;)

When characters have both text and emoji presentations, VS15(U+FE0E) or VS16(U+FE0F) are used to specify which presentation is used. These are called **variation selectors**.

https://en.wikipedia.org/wiki/Variation_Selectors_(Unicode_block)

Presentations are specified with VS15(text) or VS16(emoji) after the target character. They are just ignored if used for characters which has only one presentation. See the example below. U+0041 is text-only. U+1F9F2 is emoji-only. U+00A9 and U+2601 have both presentations.

| Character | Default| with VS15 | with VS16 |
| :-: | :-: | :-: | :-: |
| U+0041 | `&#x0041;`<br>&#x0041; | `&#x0041;&#xFE0E;`<br>&#x0041;&#xFE0E; | `&#x0041;&#xFE0F;`<br>&#x0041;&#xFE0F; |
| U+00A9 | `&#x00A9;`<br>&#x00A9; | `&#x00A9;&#xFE0E;`<br>&#x00A9;&#xFE0E; | `&#x00A9;&#xFE0F;`<br>&#x00A9;&#xFE0F; |
| U+2601 | `&#x2601;`<br>&#x2601; | `&#x2601;&#xFE0E;`<br>&#x2601;&#xFE0E; | `&#x2601;&#xFE0F;`<br>&#x2601;&#xFE0F; |
| U+1F9F2 | `&#x1F9F2;`<br>&#x1F9F2; | `&#x1F9F2;&#xFE0E;`<br>&#x1F9F2;&#xFE0E; | `&#x1F9F2;&#xFE0F;`<br>&#x1F9F2;&#xFE0F; |

If VS15/16 is not specified with characters which has both presentations, the results depand on platform. See the full listings at the following link.

→ [Basic (stand-alone) emojis](en/basic-emojis.md)

All Unicode characters which have stand-alone emoji presentations are listed in the table. Each cell has following four lines.

* character inside a code span
* default (no VS15/16)
* as text (with VS15)
* as emoji (with VS16)

It also popups a character code, name, and Unicode version on hovering a mouse cursor on a character.

> GitHub Markdown implementation is basically emoji-first. For example, according to the Unicode standard, U+2194`↔` should be displayed as text as default. But GitHub displays as emoji. Also, VS15 does not work with U+26BD`⚽`. It only displays as text inside a code span.

## [Keycaps](en/keycaps.md)

Emojis for telephone push buttons are defined as key + VS16(U+FE0F) + KEYCAP(U+20E3) sequences.

→ [Keycaps](en/keycaps.md)

## [Flags](en/flags.md)

In Unicode, country flags are represented with two [regional indicator symbols](https://en.wikipedia.org/wiki/Regional_indicator_symbol).

→ [Flags](en/flags.md)

> They are intended to display each country flags. But most environments just display small two alphabets.
> 
> https://www.unicode.org/emoji/charts/emoji-style.html#emoji_reg/tags_plain

## [Tags (subdivision flags)](en/tags.md)

Regional flags inside countries are represented with Unicode tags.

https://en.wikipedia.org/wiki/Tags_(Unicode_block)

Currently, only three flags within the United Kingdom are defined.

→ [Tags (subdivision flags)](en/tags.md)

## [Modifiers](en/modifiers.md) \([Skin tones](en/skin-tones.md)\)

Unicode emoji has character codes called modifiers, which are intended to use in emoji sequences to modify their presentations. Currently they are used to define skin colors of emojis which represent people or body parts. They are also called **skin tones**. 

https://en.wikipedia.org/wiki/Emoji#Skin_color

| Code | Name |
| - | - |
| U+1F3FB | EMOJI MODIFIER FITZPATRICK TYPE-1-2 |
| U+1F3FC | EMOJI MODIFIER FITZPATRICK TYPE-3 |
| U+1F3FD | EMOJI MODIFIER FITZPATRICK TYPE-4 |
| U+1F3FE | EMOJI MODIFIER FITZPATRICK TYPE-5 |
| U+1F3FF | EMOJI MODIFIER FITZPATRICK TYPE-6 |

Examples:

| Modifier | U+1F44D<br>👍 | U+1F9B6<br>🦶 | U+1F9D1<br>🧑 |
| :-: | :-: | :-: | :-: |
| 1-2 | 👍&#x1F3FB; | 🦶&#x1F3FB; | 🧑&#x1F3FB; |
| 3 | 👍&#x1F3FC; | 🦶&#x1F3FC; | 🧑&#x1F3FC; |
| 4 | 👍&#x1F3FD; | 🦶&#x1F3FD; | 🧑&#x1F3FD; |
| 5 | 👍&#x1F3FE; | 🦶&#x1F3FE; | 🧑&#x1F3FE; |
| 6 | 👍&#x1F3FF; | 🦶&#x1F3FF; | 🧑&#x1F3FF; |

All possible sequences using ZWJ and their presentation samples are listed at the following link.

→ [Modifiers](en/modifiers.md)

See skin tone gradations for each characters at the following link.

→ [Skin tones](en/skin-tones.md)

## [Zero width joiner sequences](en/zwj-sequences.md)

ZWJ sequences are represented as combinations with emojis and ZERO WIDTH JOINER (U+200D)s. All possible sequences are listed in [emoji-zwj-sequences.txt].

See the listing with presentation test samples at the following link.

→ [Zero width joiner sequences](en/zwj-sequences.md)

## Generating listings

All listings are generated with Ruby. The following command accesses [the Unicode Character Database](https://unicode.org/ucd/) and update the whole listings to the newest contents.

```
$ cd src
$ ruby generate-all.rb
```

## References

Unicode® Emoji: https://unicode.org/emoji/techindex.html

Unicode® Technical Standard #51: https://unicode.org/reports/tr51/

[emoji-sequences.txt]: https://www.unicode.org/Public/emoji/latest/emoji-sequences.txt
[emoji-zwj-sequences.txt]: https://www.unicode.org/Public/emoji/latest/emoji-zwj-sequences.txt
