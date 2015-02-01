class Page
  attr_reader :title, :url, :nav_links, :thumbs

  def links_for(subdir, page_names)
    page_names.inject({}) do |h, pg|
      h.merge(pg => "#{subdir}/#{pg.downcase}.html")
    end
  end
end


class IndexPage < Page

  def initialize(works)
    @title = "Index"
    @url = "index.html"
    @nav_links = links_for("camera_makes", works.unique_makes)
    @thumbs = works.first_10_thumbs
  end

end
