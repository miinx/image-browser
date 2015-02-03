class IndexPage < Page

  def initialize(works)
    @title = "Index"
    @url = "index.html"
    @nav_links = links_for("cameras", works.unique_makes)
    @thumbs = works.first_10_thumbs
  end

end
