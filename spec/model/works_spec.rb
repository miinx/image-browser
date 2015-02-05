require_relative "../spec_helper.rb"

describe Works do

  def create_expected_thumbs(ary)
      ary.map { |i| "thumb_#{i}.jpg" }
  end


  context "with large input data set" do

    before(:context) do
      @works = Works.new([
        build_list(:work, 4, :canon_snappy),
        build(:work),
        build_list(:work, 2, :nikon_d80),
        build_list(:work, 1, :canon_d80),
        build_list(:work, 8, :canon_snappy)
      ].flatten)
    end

    it "holds all the works" do
      expect(@works.size).to eq(16)
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
      expected_thumbs = create_expected_thumbs [1,2,3,4,8,9,10,11,12,13]
      expect(@works.first_10_thumbs_for_make("Canon")).to eq(expected_thumbs)
    end

    it "retrieves all thumbnails for a particular camera make & model" do
      expected_thumbs = create_expected_thumbs [1,2,3,4,9,10,11,12,13,14,15,16]
      expect(@works.all_thumbs_of_make_model("Canon", "Snappy")).to eq(expected_thumbs)
    end

  end

  context "with small input data set of less than 10 works" do

    before(:context) do
      FactoryGirl.reload

      @works = Works.new([
        build(:work),
        build(:work, :canon_snappy),
        build(:work, :canon_d80)
      ])
    end

    it "retrieves all thumbnails of any camera make & model" do
      expect(@works.first_10_thumbs).to eq(create_expected_thumbs [1,2,3])
    end

    it "retrieves all thumbnails for a particular camera make" do
      expect(@works.first_10_thumbs_for_make("Canon")).to eq(create_expected_thumbs [2,3])
      expect(@works.first_10_thumbs_for_make("Nikon")).to eq([])
    end

    it "retrieves all thumbnails for a particular camera make & model" do
      expect(@works.all_thumbs_of_make_model("Canon", "Snappy")).to eq(create_expected_thumbs [2])
    end

  end

  context "with input data that has incomplete camera info" do

    before(:context) do
      FactoryGirl.reload

      @works = Works.new([
        build(:work, :make_without_model),
        build(:work, :model_without_make)
      ])
    end

    it "determines unique camera makes" do
      expect(@works.unique_makes).to eq(["Make Without Model"])
    end

    it "returns empty unique models value when camera make has missing model" do
      expect(@works.unique_models_for_make("Make Without Model")).to eq([])
    end

    it "does not report unique models when camera make is empty" do
      expect(@works.unique_models_for_make("")).to eq([])
    end

  end

end
