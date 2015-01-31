class Works
  attr_reader :images

  def initialize(images)
    @images = images
  end

  def unique_makes
    all_makes = @images.map {|img| img.make }
    all_makes.uniq.compact.sort
  end

  def all_images_of_make(make)
    @images.select {|img| img.make == make }
  end

  def unique_models_for_make(make)
    models_for_make = all_images_of_make(make).map {|img| img.model }
    models_for_make.uniq.compact.sort
  end

  def first_10_thumbs
    first_10_thumbs_for @images
  end

  def first_10_thumbs_for_make(make)
    first_10_thumbs_for all_images_of_make(make)
  end

  def all_thumbs_of_make_model(make, model)
    all_images_of_make_model = @images.select {|img| img.make == make && img.model == model }
    all_images_of_make_model.map {|img| img.thumb }
  end

  private

  def first_10_thumbs_for(ary)
    ary.take(10).map {|img| img.thumb }
  end
end
