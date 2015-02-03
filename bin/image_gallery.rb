#!/usr/bin/env ruby

require "optparse"
require_relative "../lib/processor.rb"

ARGV << '-h' if ARGV.empty?

options = {}

option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: image_browser.rb [options]"

  opts.on("-i", "--input_file INPUT_FILE", "XML file containing image EXIF data for processing.") do |input_file|
    options[:input_file] = input_file
  end

  opts.on("-o", "--out OUTPUT_DIRECTORY", "The target directory to output html files to.") do |output_directory|
    options[:target] = output_directory
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end

option_parser.parse!

Processor.new(options).create_gallery
