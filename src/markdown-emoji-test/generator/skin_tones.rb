require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module SkinTones
      BASENAME = 'skin-tones.md'
      TITLE = {
        en: 'Markdown emoji presentation test: Skin tones',
        ja: 'Markdown絵文字表示テスト: 肌の色',
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[Modifiers](modifiers.md) ← [README](../README.md#modifiers-skin-tones) → [Zero width joiner sequences](zwj-sequences.md)',
        ja: '[修飾子](modifiers.md) ← [解説](../README.ja.md#修飾子肌の色) → [ゼロ幅接合子シーケンス](zwj-sequences.md)',
      }
      SEPARATOR = '-' * 40
      HEADER = {
        en: '| Code | None | 1-2 | 3 | 4 | 5 | 6 | Name | Version |',
        ja: '| コード | なし | 1-2 | 3 | 4 | 5 | 6 | 名前 | バージョン |',
      }
      MODIFIERS = (0x1F3FB..0x1F3FF).map {|mod| mod.chr(Encoding::UTF_8) }

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
        f.puts '| - | - | - | - | - | - | - | - | - |'
        for items in Unicode::Emoji::Modifier::get_list.each_slice(5)
          seq, name, ver = items[0]
          code = seq[0]
          name =~ /^(.*):/
          name = $1
          chr = code.chr(Encoding::UTF_8)
          hex = sprintf "%04X", code
          f.puts "| <span id=\"#{hex}\">#{hex}</span> |" + MODIFIERS.map {|mod| " #{chr}#{mod} |" }.join('') + " #{name} | #{ver} |"
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
