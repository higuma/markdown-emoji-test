require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Flags
      BASENAME = 'flags.md'
      TITLE = {
        en: 'Markdown emoji presentation test: Flags',
        ja: 'Markdown絵文字表示テスト: 国旗'
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Keycaps](keycaps.md) ← [README](../README.md#flags) → [Tags(subdivision flags)](tags.md)',
        ja: '[文字キー](keycaps.md) ← [解説](../README.ja.md#国旗) → [タグ(地域旗)](tags.md)',
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
        for item in Unicode::Emoji::Flag::get_list
          seq, name, ver = item
          f.puts "| #{seq.map {|c| sprintf "%04X", c }.join(' ') } | #{seq.map {|c| c.chr(Encoding::UTF_8) }.join('') } | #{name} | #{ver} |"
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
