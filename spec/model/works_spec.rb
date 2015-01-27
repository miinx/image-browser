require_relative "../spec_helper.rb"

describe "Works" do

  before(:context) do
    @images = [
      Work.new("thumb1.jpg", "Canon", "D100"),
      Work.new("thumb2.jpg", "Canon", "FunPix"),
      Work.new("thumb3.jpg", "Nikon", "D100"),
      Work.new("thumb3.jpg", "Canon", "D100")
    ]
    @works = Works.new(@images)
  end

  it "holds all the images" do
    expect(@works.images.size).to eq(4)
  end

  it "determines unique camera makes" do
    expect(@works.unique_makes).to eq(["Canon", "Nikon"])
  end

  it "determines unique camera models for a camera make" do
    expect(@works.unique_models_for_make("Canon")).to eq(["D100", "FunPix"])
    expect(@works.unique_models_for_make("Nikon")).to eq(["D100"])
  end

end
