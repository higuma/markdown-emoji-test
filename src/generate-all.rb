#!/usr/bin/env ruby

# Generate all documents

require 'fileutils'
require_relative 'markdown-emoji-test/generator'

include MarkdownEmojiTest::Generator

for lang in [:en, :ja]
  dir = "../#{lang}"
  FileUtils.makedirs dir
  BasicEmojis.output_file "#{dir}/basic-emojis.md", lang
  Keycaps.output_file "#{dir}/keycaps.md", lang
  Flags.output_file "#{dir}/flags.md", lang
  Tags.output_file "#{dir}/tags.md", lang
  Modifiers.output_file "#{dir}/modifiers.md", lang
  SkinTones.output_file "#{dir}/skin-tones.md", lang
  ZwjSequences.output_file "#{dir}/zwj-sequences.md", lang
end
