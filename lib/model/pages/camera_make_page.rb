class CameraMakePage < Page

  def initialize(works, make)
    @works = works
    @make = make

    @title = make.upcase
    @url = "cameras/#{make.snakeize}.html"
    @nav_links = create_nav_links
    @thumbs = works.first_10_thumbs_for_make(make)
  end

  def create_nav_links
    child_links = links_for("#{@make.snakeize}", @works.unique_models_for_make(@make))
    [index_link(".."), child_links].flatten
  end
end
