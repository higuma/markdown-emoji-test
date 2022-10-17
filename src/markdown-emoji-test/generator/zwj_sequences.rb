require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module ZwjSequences
      BASENAME = 'zwj-sequences.md'
      TITLE = {
        en: 'Markdown emoji presentation test: Zero width joiner sequences',
        ja: 'Markdown絵文字表示テスト: ゼロ幅接合子シーケンス'
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Skin tones](skin-tones.md) ← [README](../README.md)',
        ja: '[肌の色](skin-tones.md) ← [README](../README.ja.md)',
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
        for group in ['Family', 'Role', 'Gendered', 'Hair', 'Other']
          generate_list f, lang, group
        end
        f.puts SEPARATOR
        f.puts
        f.puts NAVIGATION[lang]
      end

      def generate_list(f, lang, group)
        f.puts "## #{group}"
        f.puts
        f.puts HEADER[lang]
        f.puts '| - | - | - | - |'
        for item in Unicode::Emoji::ZwjSequences::get_cached[group]
          seq, name, ver = item
          f.puts "| #{seq.map {|c| sprintf "%04X", c }.join(' ') } | #{seq.map {|c| c.chr(Encoding::UTF_8) }.join('') } | #{name} | #{ver} |"
        end
        f.puts
      end

      def output_file(root_dir, lang)
        open("#{root_dir}/#{lang}/#{BASENAME}", 'w') do |f|
          generate f, lang
        end
      end
    end
  end
end
