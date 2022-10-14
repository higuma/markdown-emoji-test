require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module ZwjSequences
      TITLE = {
        :en => 'Markdown emoji test: Zero width joiner sequences',
        :ja => 'Markdown絵文字テスト: ゼロ幅接合子シーケンス'
      }
      HEADER = {
        :en => '| Sequence | Output | Name | Version |',
        :ja => '| シーケンス | 出力 | 名前 | バージョン |',
      }

      module_function
      def generate(f, lang)
        f.puts "# #{TITLE[lang]}"
        for group in ['Family', 'Role', 'Gendered', 'Hair', 'Other']
          generate_list f, lang, group
        end
      end

      def generate_list(f, lang, group)
        f.puts
        f.puts "## #{group}"
        f.puts
        f.puts HEADER[lang]
        f.puts '| - | - | - | - |'
        for item in Unicode::Emoji::ZwjSequences::get_cached[group]
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
