require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module BasicEmojis
      VS15 = ?\uFE0E
      VS16 = ?\uFE0F

      BASENAME = "basic-emojis.md"
      TITLE = {
        en: 'Markdown emoji presentation test: Stand-alone emojis',
        ja: 'Markdown絵文字表示テスト: 単独絵文字',
      }
      LANG = {
        en: "English | [Japanese](../ja/#{BASENAME})",
        ja: "日本語 | [English](../en/#{BASENAME})",
      }
      NAVIGATION = {
        en: '[README](../README.md#stand-alone-emojis) → [Keycaps](keycaps.md)',
        ja: '[解説](../README.ja.md#単独絵文字) → [文字キー](keycaps.md)',
      }
      SEPARATOR = '-' * 40
      EXAMPLE = {
        en: '`c`: as code span, &nbsp; **c**: character only, &nbsp; **15**: character + VS15(U+FE0E), &nbsp; **16**: character + VS16(U+FE0F)',
        ja: '`c`: コードスパン表示, &nbsp; **c**: 文字のみ, &nbsp; **15**: 文字 + VS15(U+FE0E), &nbsp; **16**: 文字 + VS16(U+FE0F)',
      }

      @@emoji_map = Unicode::Emoji::Data::Map.new

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
        f.puts EXAMPLE[lang]
        f.puts
        f.puts '| U+ |' + (0..0x0F).map {|c| sprintf " %X<br>`c`<br>c<br>15<br>16 |", c }.join('')
        f.puts '| - |' + ' :-: |' * 16

        base = 0
        items = {}
        for item in Unicode::Emoji::Basic::get_list
          code = item[0][0]
          if code >= base + 16
            generate_line f, base, items
            base = code & 0xFFFFF0
            items = {}
          end
          items[code] = true
        end
        generate_line f, base, items
        f.puts
        f.puts SEPARATOR
        f.puts
        f.puts NAVIGATION[lang]
      end

      def generate_line(f, base, items)
        return if items.empty?
        f.print "| #{sprintf "%04X", base} |"
        for i in 0..15
          code = base + i
          hex = sprintf "%04X", code
          if items[code]
            c = code.chr(Encoding::UTF_8)
            name = @@emoji_map.name code
            ver = @@emoji_map.version code
            f.print " <span title=\"U+#{hex} #{name}, #{ver}\">`#{c}`</span><br><span title=\"#{hex}\">#{c}</span><br><span title=\"#{hex} FE0E\">#{c}#{VS15}</span><br><span title=\"#{hex} FE0F\">#{c}#{VS16}</span> |"
          else
            f.print " <span title=\"U+#{hex} (not an emoji)\">-</span> |"
          end
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
