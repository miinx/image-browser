require_relative "../../spec_helper.rb"

describe CameraModelPage do

  context "when created" do

    before(:context) do
      RSpec::Mocks.with_temporary_scope do
        @expected_thumbs = ["thumb1.jpg", "thumb2.jpg"]

        mock_works = double(Works)
        allow(mock_works).to receive(:all_thumbs_of_make_model).with("Canon", "EOS").and_return(@expected_thumbs)

        @page = CameraModelPage.new(mock_works, "Canon", "EOS")
      end
    end

    it "page title includes camera make & model" do
      expect(@page.title).to eq("CANON EOS")
    end

    it "title only includes camera make if camera model does not already include it" do
      mock_works = double(Works)
      allow(mock_works).to receive(:all_thumbs_of_make_model).with("Canon", "Canon EOS")

      page_for_canon_eos = CameraModelPage.new(mock_works, "Canon", "Canon EOS")

      expect(page_for_canon_eos.title).to eq("CANON EOS")
    end

    it "holds the page url" do
      expect(@page.url).to eq("cameras/canon/eos.html")
    end

    it "determines the nav links" do
      expect(@page.nav_links.size).to eq(2)
      expect(@page.nav_links[0].name).to eq("INDEX")
      expect(@page.nav_links[1].name).to eq("CANON")
    end

    it "holds the thumbs" do
      expect(@page.thumbs).to eq(@expected_thumbs)
    end

  end

end
