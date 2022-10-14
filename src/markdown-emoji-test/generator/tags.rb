require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Tags
      TITLE = {
        :en => 'Markdown emoji test: Tags (subdivision flags)',
        :ja => 'Markdown絵文字テスト: タグ(国・地域内部の旗)'
      }
      HEADER = {
        :en => '| Sequence | Output | Name | Version |',
        :ja => '| シーケンス | 出力 | 名前 | バージョン |',
      }

      module_function
      def generate(f, lang)
        f.puts "# #{TITLE[lang]}"
        f.puts
        f.puts HEADER[lang]
        f.puts '| - | - | - | - |'
        for item in Unicode::Emoji::Tag::get_list
          seq, name, ver = item
          f.puts "| #{seq.map {|c| sprintf "%04X", c }.join(' ') } | #{seq.map {|c| c.chr(Encoding::UTF_8) }.join('') } | #{name} | #{ver} |"
        end
      end

      def output_file(path, lang)
        open(path, 'w') do |f|
          generate f, lang
        end
      end
    end
  end
end
