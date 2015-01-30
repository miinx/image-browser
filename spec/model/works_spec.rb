require_relative "../spec_helper.rb"

describe "Works" do

  before(:context) do
    @works_many = Works.new(build_list(:work, 14, :canon_snappy))

    @works_mixed = Works.new([
      build(:work, :nikon_d80),
      build(:work, :canon_snappy),
      build(:work, :canon_d80),
      build(:work, :canon_snappy)
      ])
  end


  it "holds all the images" do
    expect(@works_many.images.size).to eq(14)
  end

  it "determines unique camera makes" do
    expect(@works_mixed.unique_makes).to eq(["Canon", "Nikon"])
  end

  it "determines unique camera models for a camera make" do
    expect(@works_mixed.unique_models_for_make("Canon")).to eq(["D80", "Snappy"])
    expect(@works_mixed.unique_models_for_make("Nikon")).to eq(["D80"])
  end

  it "retrieves the first 10 thumbnails" do
    expected_thumbs = []
    (1..10).each {|i| expected_thumbs.push("thumb_#{i}.jpg") }

    expect(@works_many.first_10_thumbs).to eq(expected_thumbs)
  end


end
