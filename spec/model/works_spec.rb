require_relative "../spec_helper.rb"

describe "Works" do

  before(:context) do
    @works = Works.new([
      build_list(:work, 4, :canon_snappy),
      build_list(:work, 7, :nikon_d80),
      build_list(:work, 2, :canon_d80),
      build_list(:work, 11, :canon_snappy)
    ].flatten)
  end

  def create_expected_thumbs(ary)
      ary.map {|i| "thumb_#{i}.jpg" }
  end


  it "holds all the images" do
    expect(@works.images.size).to eq(24)
  end

  it "determines unique camera makes" do
    expect(@works.unique_makes).to eq(["Canon", "Nikon"])
  end

  it "determines unique camera models for a camera make" do
    expect(@works.unique_models_for_make("Canon")).to eq(["D80", "Snappy"])
    expect(@works.unique_models_for_make("Nikon")).to eq(["D80"])
  end

  it "retrieves the first 10 thumbnails of any camera make & model" do
    expected_thumbs = create_expected_thumbs (1..10).to_a
    expect(@works.first_10_thumbs).to eq(expected_thumbs)
  end

  it "retrieves first 10 thumbnails for a particular camera make" do
    expected_thumbs = create_expected_thumbs [1,2,3,4,12,13,14,15,16,17]
    expect(@works.first_10_thumbs_for_make("Canon")).to eq(expected_thumbs)
  end

  it "retrieves all thumbnails for a particular camera make & model" do
    expected_thumbs = create_expected_thumbs (1..4).to_a.concat (14..24).to_a
    expect(@works.all_thumbs_of_make_model("Canon", "Snappy")).to eq(expected_thumbs)
  end

end
