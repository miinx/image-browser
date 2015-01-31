require_relative "spec_helper.rb"

describe "Parser" do

  before(:context) do
    @xml = "<works>" \
            "<work><exif><make>Canon</make></exif></work>" \
            "<work><exif><make>Nikon</make></exif></work>" \
           "</works>"

    @parser = Parser.new
    @parser.parse_input(@xml)
  end

  it "parses the input xml" do
    expect(@parser.works.size).to eq(2)
    expect(@parser.works[0]).to be_instance_of(Work)
  end

  it "parses the camera makes" do
    expect(@parser.works[0].make).to eq("Canon")
  end

end
