require "fileutils"
require_relative "parser.rb"
require_relative "model/page.rb"

class Processor

  attr_writer :parser

  def initialize(input, output)
    @input_file = input
    @output_dir = output
    @parser = Parser.new
    @images = []
  end

  def create_gallery
    parse_input
    create_output_directory
    create_pages
  end

  def parse_input
    @images = @parser.parse_input(File.read(@input_file))
  end

  def create_output_directory
    FileUtils.mkdir_p @output_dir
  end

  def create_pages
    works = Works.new(@images)
    IndexPage.new(works).render(@output_dir)
  end

end
