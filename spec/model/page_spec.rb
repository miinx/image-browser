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

  it "creates the page in the target directory" do
    erb_template = "<html />"
    mock_renderer = double(ERB)
    output_html = "<html>done</html>"
    output_file = "target/test_file.html"

    allow(File).to receive(:read).and_return(erb_template)
    allow(ERB).to receive(:new).with(erb_template).and_return(mock_renderer)
    allow(File).to receive(:join).and_return(output_file)
    allow(File).to receive(:open).with(output_file, "w")

    @page.instance_variable_set("@url", "page.html")
    @page.render("target")

    expect(File).to have_received(:read).once
    expect(ERB).to have_received(:new).with(erb_template).once
    expect(File).to have_received(:join).with("target", "page.html").once
  end

end
