#!/usr/bin/env ruby

# Generate all documents

require 'fileutils'
require_relative 'markdown-emoji-test/generator'

include MarkdownEmojiTest::Generator

for lang in [:en, :ja]
  FileUtils.makedirs "../#{lang}"
  BasicEmojis.output_file "..", lang
  Keycaps.output_file "..", lang
  Flags.output_file "..", lang
  Tags.output_file "..", lang
  Modifiers.output_file "..", lang
  SkinTones.output_file "..", lang
  ZwjSequences.output_file "..", lang
end
