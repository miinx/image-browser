require_relative "spec_helper.rb"

describe Processor do

  before(:context) do
    @processor = Processor.new("works.xml", "target")
    @parser = double(Parser)
    @processor.parser = @parser
  end

  it "should pass the input file contents to the parser for parsing" do
    allow(File).to receive(:read).and_return("<works />")
    expect(@parser).to receive(:parse_input).with("<works />")
    @processor.parse_input
  end

  it "should create the output directory" do
    fileutils = double(FileUtils)
    expect(FileUtils).to receive(:mkdir_p).with("target")
    @processor.create_output_directory("target")
  end

end
