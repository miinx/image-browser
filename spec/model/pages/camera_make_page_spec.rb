require_relative "../../spec_helper.rb"

describe CameraMakePage do

  context "when created" do

    before(:context) do
      RSpec::Mocks.with_temporary_scope do
        @expected_thumbs = ["thumb1.jpg", "thumb2.jpg"]

        mock_works = double(Works)
        allow(mock_works).to receive(:unique_models_for_make).and_return(["EOS", "Snappy"])
        allow(mock_works).to receive(:first_10_thumbs_for_make).with("Canon").and_return(@expected_thumbs)

        @page = CameraMakePage.new(mock_works, "Canon")
      end
    end

    it "holds the page title" do
      expect(@page.title).to eq("CANON")
    end

    it "holds the page url" do
      expect(@page.url).to eq("cameras/canon.html")
    end

    it "determines the nav links" do
      expect(@page.nav_links.size).to eq(3)
      expect(@page.nav_links[0].name).to eq("INDEX")
      expect(@page.nav_links[1].name).to eq("EOS")
      expect(@page.nav_links[2].name).to eq("SNAPPY")
    end

    it "holds the thumbs" do
      expect(@page.thumbs).to eq(@expected_thumbs)
    end

  end

end
