require_relative "../spec_helper.rb"

describe Page do

  before(:context) do
    @camera_makes = ["Canon Foo-Bar., Ltd."]
    @page = Page.new
  end

  it "creates links with uppercase names and snake-cased urls without punctuation" do
    allow(Link).to receive(:new)
    @page.links_for("makes", @camera_makes)
    expect(Link).to have_received(:new).with("CANON FOO-BAR., LTD.", "makes/canon_foo_bar_ltd.html")
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
