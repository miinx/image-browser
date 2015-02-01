require "fileutils"

class Processor

  attr_writer :parser

  def initialize(input, output)
    @input_file = input
    @output_dir = output
    @parser = Parser.new
  end

  def create_gallery
    parse_input
    create_output_directory
  end

  def parse_input
    @works = @parser.parse_input(File.read(@input_file))
  end

  def create_output_directory
    FileUtils.mkdir_p @output_dir
  end

end
