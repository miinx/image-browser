require "fileutils"
require_relative "parser.rb"
require_relative "model/page.rb"

class Processor

  attr_writer :parser

  def initialize(input, output)
    @input_file = input
    @output_dir = output
    @parser = Parser.new
  end

  def create_gallery
    parse_input
    create_output_directory(@output_dir)
    create_pages
  end

  def parse_input
    @images = @parser.parse_input(File.read(@input_file))
  end

  def create_output_directory(dir)
    FileUtils.mkdir_p dir
  end

  def create_pages
    @works = Works.new(@images)
    create_index_page
    create_camera_make_pages
  end

  def create_index_page
    IndexPage.new(@works).render(@output_dir)
  end

  def create_camera_make_pages
    create_output_directory("#{@output_dir}/camera_makes")
    @works.unique_makes.each do |make|
      CameraMakePage.new(@works, make).render(@output_dir)
    end
  end

end
