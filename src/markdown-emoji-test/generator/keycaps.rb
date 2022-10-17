require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Keycaps
      BASENAME = "keycaps.md"
      TITLE = {
        en: 'Markdown emoji prsentation test: Keycaps',
        ja: 'Markdown絵文字表示テスト: 文字キー',
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Stand-alone emojis](basic-emojis.md) ← [README](../README.md) → [Flags](flags.md)',
        ja: '[単独絵文字](basic-emojis.md) ← [README](../README.ja.md) → [国旗](flags.md)',
      }
      SEPARATOR = '-' * 40
      HEADER = {
        en: '| Sequence | Output | Name | Version |',
        ja: '| シーケンス | 出力 | 名前 | バージョン |',
      }
      SUFFIXES = [[0x20E3], [0xFE0E, 0x20E3], [0xFE0F, 0x20E3]]

      module_function
      def generate(f, lang)
        f.puts "# #{TITLE[lang]}"
        f.puts
        f.puts LANG[lang]
        f.puts
        f.puts NAVIGATION[lang]
        f.puts
        f.puts SEPARATOR
        f.puts
        f.puts HEADER[lang]
        f.puts '| - | - | - | - |'
        for item in Unicode::Emoji::Keycap::get_list
          seq, name, ver = item
          seqs = SUFFIXES.map {|suffix| [seq[0]] + suffix }
          f.puts "| #{
            seqs.map {|seq|
              seq.map {|c| sprintf "%04X", c }.join(' ')
            }.join '<br>'
          } | #{
            seqs.map {|seq|
              seq.map {|c| c.chr(Encoding::UTF_8) }.join('')
            }.join '<br>'
          } | #{name} | #{ver} |"
        end
        f.puts
        f.puts SEPARATOR
        f.puts
        f.puts NAVIGATION[lang]
      end

      def output_file(root_dir, lang)
        open("#{root_dir}/#{lang}/#{BASENAME}", 'w') do |f|
          generate f, lang
        end
      end
    end
  end
end
