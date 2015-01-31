require_relative "spec_helper.rb"

describe "Parser" do

  before(:context) do
    @xml = "<works>" \
            "<work></work>" \
            "<work></work>" \
           "</works>"

    @parser = Parser.new
  end

  it "parses the input xml" do
    @parser.parse_input(@xml)
    expect(@parser.works.size).to eq(2)
  end

end
