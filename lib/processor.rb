require "fileutils"
require_relative "parser.rb"
require_relative "model/page.rb"
require_relative "model/pages/index_page.rb"
require_relative "model/pages/camera_make_page.rb"
require_relative "model/pages/camera_model_page.rb"

class Processor

  attr_writer :parser

  def initialize(args)
    @input_file = args.fetch(:input_file, "")
    @output_dir = args.fetch(:target, "")
    @parser = Parser.new
  end

  def create_gallery
    parse_input
    create_output_directory(@output_dir)
    create_pages
  end

  private

  def parse_input
    images = @parser.parse_input(File.read(@input_file))
    @works = Works.new(images)
  end

  def create_output_directory(dir)
    FileUtils.mkdir_p dir
  end

  def create_pages
    create_index_page
    create_camera_make_pages
  end

  def create_index_page
    IndexPage.new(@works).render(@output_dir)
  end

  def create_camera_make_pages
    create_output_directory("#{@output_dir}/cameras")
    @works.unique_makes.each do |make|
      CameraMakePage.new(@works, make).render(@output_dir)
      create_camera_model_pages(make)
    end
  end

  def create_camera_model_pages(make)
    return if @works.unique_models_for_make(make) == []

    create_output_directory("#{@output_dir}/cameras/#{make.snakeize}")
    @works.unique_models_for_make(make).each do |model|
      CameraModelPage.new(@works, make, model).render(@output_dir)
    end
  end

end
