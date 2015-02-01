require_relative "../spec_helper.rb"

describe IndexPage do

  context "when created" do

    before(:context) do
      RSpec::Mocks.with_temporary_scope do
        @expected_thumbs = ["http://rb.com/thumb1.jpg", "http://rb.com/thumb2.jpg"]

        mock_works = double(Works)
        allow(mock_works).to receive(:unique_makes).and_return(["Canon", "Nikon"])
        allow(mock_works).to receive(:first_10_thumbs).and_return(@expected_thumbs)

        @page = IndexPage.new(mock_works)
      end
    end

    it "holds the page title" do
      expect(@page.title).to eq("Index")
    end

    it "holds the page url" do
      expect(@page.url).to eq("index.html")
    end

    it "determines the nav links to each camera make page" do
      expect(@page.nav_links).to eq({"Canon" => "camera_makes/canon.html", "Nikon" => "camera_makes/nikon.html"})
    end

    it "holds the thumbs" do
      expect(@page.thumbs).to eq(@expected_thumbs)
    end

  end

end
