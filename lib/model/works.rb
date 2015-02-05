class Works

  attr_reader :works

  def initialize(works)
    @works = works
  end

  def unique_makes
    all_makes = @works.map { |img| img.make }
    all_makes.uniq.compact.sort
  end

  def all_works_of_make(make)
    @works.select { |img| img.make == make }
  end

  def unique_models_for_make(make)
    models_for_make = all_works_of_make(make).map { |img| img.model }
    models_for_make.uniq.compact.sort
  end

  def first_10_thumbs
    first_10_thumbs_for @works
  end

  def first_10_thumbs_for_make(make)
    first_10_thumbs_for all_works_of_make(make)
  end

  def all_thumbs_of_make_model(make, model)
    all_works_of_make_model = @works.select { |img| img.make == make && img.model == model }
    all_works_of_make_model.map(&:thumb)
  end

  private

  def first_10_thumbs_for(ary)
    ary.take(10).map { |img| img.thumb }
  end
end
