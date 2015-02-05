require "erb"
require_relative "works.rb"
require_relative "link.rb"
require_relative "../string_ext.rb"


class Page

  include StringExt

  attr_reader :title, :url, :nav_links, :thumbs

  def index_link(relative_dir_path)
    Link.new("INDEX", "#{relative_dir_path}/index.html")
  end

  def links_for(dir_path, page_names)
    page_names.map { |pg| Link.new(pg.upcase, "#{dir_path}/#{pg.snakeize}.html") }
  end

  def render(target_dir)
    renderer = ERB.new(File.read("lib/view/output-template.html.erb"))
    output_file = File.join(target_dir, @url)
    File.open(output_file, "w") do |f|
      f.write renderer.result(binding)
    end
  end

end
