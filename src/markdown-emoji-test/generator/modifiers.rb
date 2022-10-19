require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Modifiers
      BASENAME = 'modifiers.md'
      TITLE = {
        en: 'Markdown emoji presentation test: Modifiers',
        ja: 'Markdown絵文字表示テスト: 修飾子'
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Tags (subdivision flags)](tags.md) ← [README](../README.md#modifiers-skin-tones) → [Skin tones](skin-tones.md)',
        ja: '[タグ(地域旗)](tags.md) ← [解説](../README.ja.md#修飾子肌の色) → [肌の色](skin-tones.md)',
      }
      SEPARATOR = '-' * 40
      HEADER = {
        en: '| Sequence | Output | Name | Version |',
        ja: '| シーケンス | 出力 | 名前 | バージョン |',
      }

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
        for item in Unicode::Emoji::Modifier::get_list
          seq, name, ver = item
          hex_seq = seq.map {|c| sprintf "%04X", c }
          f.puts "| <span id=\"#{
            hex_seq.join '-'
          }\">#{
            hex_seq.join ' '
          }</span> | #{
            seq.map {|c| c.chr(Encoding::UTF_8) }.join ''
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
