require_relative "spec_helper.rb"

describe "Parser" do

  before(:context) do
    @xml = "<works>" \
            "<work>" \
            "<exif><make>Canon</make><model>Snappy</model></exif>" \
            "</work>" \
           "</works>"

    @parser = Parser.new
    @parser.parse_input(@xml)
  end

  it "parses the input xml" do
    expect(@parser.works.size).to eq(1)
    expect(@parser.works[0]).to be_instance_of(Work)
  end

  it "parses the camera makes" do
    expect(@parser.works[0].make).to eq("Canon")
  end

  it "parses the camera models" do
    expect(@parser.works[0].model).to eq("Snappy")
  end

end
