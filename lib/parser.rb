require "nokogiri"
require_relative "model/work.rb"

class Parser < Nokogiri::XML::SAX::Document

  attr_reader :works

  def initialize
    @works = []
  end

  def parse_input(input)
    sax_parser = Nokogiri::XML::SAX::Parser.new(self)
    sax_parser.parse(input)
    @works
  end

  def start_element(name, attrs=[])
    @current_attrs = attrs
    @current_characters = nil

    if name == "work"
      @current_work = Work.new
    end
  end

  def end_element(name)
    if name == "work"
      @works.push(@current_work)
    else
      if self.respond_to?("on_#{name}")
        self.method("on_#{name}").call(@current_characters, @current_attrs)
      end
    end
  end

  def characters(characters)
    @current_characters = characters.strip
  end

  def on_make(make, attrs)
    @current_work.make = make
  end

  def on_model(model, attrs)
    @current_work.model = model
  end

  def on_url(url, attrs)
    if attrs[0].include?("small")
      @current_work.thumb = url
    end
  end

end
