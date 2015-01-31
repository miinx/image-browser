require_relative "../spec_helper.rb"

describe "Works" do

  def create_expected_thumbs(ary)
      ary.map {|i| "thumb_#{i}.jpg" }
  end


  context "with large input data set" do

    before(:context) do
      @works = Works.new([
        build_list(:work, 4, :canon_snappy),
        build(:work),
        build_list(:work, 7, :nikon_d80),
        build_list(:work, 2, :canon_d80),
        build_list(:work, 11, :canon_snappy)
      ].flatten)
    end

    it "holds all the images" do
      expect(@works.images.size).to eq(25)
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
      expected_thumbs = create_expected_thumbs [1,2,3,4,13,14,15,16,17,18]
      expect(@works.first_10_thumbs_for_make("Canon")).to eq(expected_thumbs)
    end

    it "retrieves all thumbnails for a particular camera make & model" do
      expected_thumbs = create_expected_thumbs (1..4).to_a.concat (15..25).to_a
      expect(@works.all_thumbs_of_make_model("Canon", "Snappy")).to eq(expected_thumbs)
    end

  end

  context "with small input data set" do

    before(:context) do
      FactoryGirl.reload

      @works = Works.new([
        build(:work),
        build(:work, :canon_snappy),
        build(:work, :canon_d80)
      ])
    end

    it "holds all the images" do
      expect(@works.images.size).to eq(3)
    end

    it "determines unique camera makes" do
      expect(@works.unique_makes).to eq(["Canon"])
    end

    it "determines unique camera models for a camera make" do
      expect(@works.unique_models_for_make("Canon")).to eq(["D80", "Snappy"])
    end

    it "retrieves the first 10 thumbnails of any camera make & model" do
      expect(@works.first_10_thumbs).to eq(create_expected_thumbs [1,2,3])
    end

    it "retrieves first 10 thumbnails for a particular camera make" do
      expect(@works.first_10_thumbs_for_make("Canon")).to eq(create_expected_thumbs [2,3])
      expect(@works.first_10_thumbs_for_make("Nikon")).to eq([])
    end

    it "retrieves all thumbnails for a particular camera make & model" do
      expect(@works.all_thumbs_of_make_model("Canon", "Snappy")).to eq(create_expected_thumbs [2])
    end

  end

  context "with input data that has missing make or model in image's camera info" do

    before(:context) do
      FactoryGirl.reload

      @works = Works.new([
        build(:work, :make_without_model),
        build(:work, :model_without_make)
      ])
    end

    it "holds all the images" do
      expect(@works.images.size).to eq(2)
    end

    it "determines unique camera makes" do
      expect(@works.unique_makes).to eq(["Make Without Model"])
    end

    it "returns empty value when camera make has missing model" do
      expect(@works.unique_models_for_make("Make Without Model")).to eq([])
    end

    it "does not report unique models when camera make is empty" do
      expect(@works.unique_models_for_make("")).to eq([])
    end

  end

end
