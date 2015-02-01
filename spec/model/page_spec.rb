require_relative "../spec_helper.rb"

describe Page do

  before(:context) do
    @camera_makes = ["Canon"]
    @page = Page.new
  end

  it "creates links" do
    allow(Link).to receive(:new)
    @page.links_for("makes", @camera_makes)
    expect(Link).to have_received(:new).with("Canon", "makes/canon.html")
  end

  it "writes a page to target directory" do
    mock_renderer = double(ERB)
    erb_template = "<html />"
    output_file = "target/test_file.html"
    allow(ERB).to receive(:new) { mock_renderer }
    allow(File).to receive(:read) { erb_template }
    allow(File).to receive(:join) { output_file }

    expect(File).to receive(:open).with(output_file, "w")

    @page.render("target")

    expect(File).to have_received(:read)
    expect(ERB).to have_received(:new).with(erb_template)
    expect(File).to have_received(:join)

  end

end