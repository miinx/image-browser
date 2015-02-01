require_relative "../spec_helper.rb"

describe Page do

  before(:context) do
    @camera_makes = ["Canon", "Nikon"]
    @page = Page.new
  end

  it "creates links" do
    expect(@page.links_for("makes", @camera_makes)).to eq({"Canon" => "makes/canon.html", "Nikon" => "makes/nikon.html"})
  end

  it "writes a page to target directory" do
    mock_renderer = double(ERB)
    erb_template = "<html />"
    output_file = "test_target/test_file.html"
    allow(ERB).to receive(:new) { mock_renderer }
    allow(File).to receive(:read) { erb_template }
    allow(File).to receive(:join) { output_file }

    expect(File).to receive(:open).with(output_file, "w")

    @page.render("target")

  end

end
