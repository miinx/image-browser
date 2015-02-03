require "erb"
require_relative "works.rb"
require_relative "link.rb"
require_relative "../string_ext.rb"


class Page

  include StringExt

  attr_reader :title, :url, :nav_links, :thumbs

  def links_for(dir_path, page_names)
    page_names.map {|pg| Link.new(pg.upcase, "#{dir_path}/#{pg.snakeize}.html") }
  end

  def render(target_dir)
    renderer = ERB.new(File.read("lib/view/output-template.html.erb"))
    output_file = File.join(target_dir, @url)
    File.open(output_file, "w") do |f|
      f.write renderer.result(binding)
    end
  end

end

class IndexPage < Page

  def initialize(works)
    @title = "Index"
    @url = "index.html"
    @nav_links = links_for("cameras", works.unique_makes)
    @thumbs = works.first_10_thumbs
  end

end

class CameraMakePage < Page

  def initialize(works, make)
    @title = make.upcase
    @url = "cameras/#{make.snakeize}.html"
    @nav_links = links_for("../..", ["Index"]).concat(links_for("#{make.snakeize}", works.unique_models_for_make(make)))
    @thumbs = works.first_10_thumbs_for_make(make)
  end

end

class CameraModelPage < Page

  def initialize(works, make, model)
    @title = "#{make} #{model}".upcase
    @url = "cameras/#{make.snakeize}/#{model.snakeize}.html"
    @nav_links = links_for("../..", ["Index"]).concat(links_for("..", ["#{make}"]))
    @thumbs = works.all_thumbs_of_make_model(make, model)
  end

end
