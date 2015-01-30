class Works
  attr_reader :images

  def initialize(images)
    @images = images
  end

  def unique_makes
    @images.map {|img| img.make}.uniq.sort
  end

  def unique_models_for_make(make)
    images_from_camera_make = @images.select {|img| img.make == make }
    images_from_camera_make.map {|img| img.model }.uniq.sort
  end
end
