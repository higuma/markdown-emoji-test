require_relative '../../unicode-emoji/unicode'

module MarkdownEmojiTest
  module Generator
    module Keycaps
      TITLE = {
        :en => 'Markdown emoji prsentation test: Keycaps',
        :ja => 'Markdown絵文字表示テスト: 文字キー',
      }
      HEADER = {
        :en => '| Sequence | Output | Name | Version |',
        :ja => '| シーケンス | 出力 | 名前 | バージョン |',
      }
      SUFFIXES = [[0x20E3], [0xFE0E, 0x20E3], [0xFE0F, 0x20E3]]

      module_function
      def generate(f, lang)
        f.puts "# #{TITLE[lang]}"
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
      end

      def output_file(path, lang)
        open(path, 'w') do |f|
          generate f, lang
        end
      end
    end
  end
end
