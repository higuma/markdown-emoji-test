require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Tags
      BASENAME = 'tags.md'
      TITLE = {
        en: 'Markdown emoji presentation test: Tags (subdivision flags)',
        ja: 'Markdown絵文字表示テスト: タグ(地域旗)'
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Flags](flags.md) ← [README](../README.md#tags-subdivision-flags) → [Modifiers](modifiers.md)',
        ja: '[国旗](flags.md) ← [解説](../README.ja.md#タグ地域旗) → [修飾子](modifiers.md)',
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
        for item in Unicode::Emoji::Tag::get_list
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
