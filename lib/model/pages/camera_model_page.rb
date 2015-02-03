class CameraModelPage < Page

  def initialize(works, make, model)
    @make = make
    @model = model

    @title = create_title
    @url = "cameras/#{make.snakeize}/#{model.snakeize}.html"
    @nav_links = create_nav_links
    @thumbs = works.all_thumbs_of_make_model(make, model)
  end

  def create_nav_links
    parent_link = links_for("..", ["#{@make}"])
    [index_link("../.."), parent_link].flatten
  end

  def create_title
    if @model.index(@make).nil?
      "#{@make} #{@model}".upcase
    else
      "#{@model}".upcase
    end
  end

end
