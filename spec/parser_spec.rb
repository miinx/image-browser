require_relative "spec_helper.rb"

describe Parser do

  context "with a valid & complete work in xml" do

    before(:context) do
      @xml = "<works>" \
              "<work>" \
              "<urls><url type='small'>http://test.com/small.jpg</url><url type='large'>http://test.com/large.jpg</url></urls>" \
              "<exif><make>Canon</make><model>Snappy</model></exif>" \
              "</work>" \
              "<work><exif><make> Fuji </make></exif></work>" \
             "</works>"
      @parser = Parser.new
      @parser.parse_input(@xml)
    end

    it "creates a work object for each image" do
      expect(@parser.works.size).to eq(2)
      expect(@parser.works[0]).to be_instance_of(Work)
    end

    it "parses the camera makes" do
      expect(@parser.works[0].make).to eq("Canon")
    end

    it "parses the camera models" do
      expect(@parser.works[0].model).to eq("Snappy")
    end

    it "parses the thumbnails" do
      expect(@parser.works[0].thumb).to eq("http://test.com/small.jpg")
    end

    it "strips whitespace from values" do
      expect(@parser.works[1].make).to eq("Fuji")
    end

  end

  context "with missing or empty values in work data in xml" do

    before(:context) do
      @xml = "<works>" \
              "<work><urls><url type='small'>thumb1.jpg</url></urls></work>" \
              "<work><exif><make>Canon</make></exif></work>" \
              "<work><urls><url type='small'></url></urls><exif><make></make></exif></work>" \
             "</works>"
      @parser = Parser.new
      @parser.parse_input(@xml)
    end

    it "still creates work object for each image" do
      expect(@parser.works.size).to eq(3)
    end

    it "reports nil for missing values" do
      expect(@parser.works[0].make).to be(nil)
      expect(@parser.works[1].thumb).to be(nil)
      expect(@parser.works[1].model).to be(nil)
    end

    it "reports nil for empty xml nodes" do
      expect(@parser.works[2].thumb).to be(nil)
      expect(@parser.works[2].make).to be(nil)
    end

    it "still stores valid available values" do
      expect(@parser.works[0].thumb).to eq("thumb1.jpg")
    end

  end

end
