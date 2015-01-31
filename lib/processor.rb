class Processor

  attr_writer :parser

  def initialize(input, output)
    @input_file = input
    @output_dir = output
    @parser = Parser.new
  end

  def create_gallery
    parse_input
  end

  def parse_input
    @works = @parser.parse_input(File.read(@input_file))
  end

end
