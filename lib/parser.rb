require "nokogiri"

class Parser < Nokogiri::XML::SAX::Document

  attr_reader :works

  def initialize
    @works = []
  end

  def parse_input(input)
    sax_parser = Nokogiri::XML::SAX::Parser.new(self)
    sax_parser.parse(input)
  end

  def start_element(name, attrs=[])
    if name == "work"
      @current_work = Work.new
    end
  end

  def end_element(name)
    if name == "work"
      @works.push(@current_work)
    end
  end

end
