require "factory_girl"

require_relative "../lib/model/work.rb"
require_relative "../lib/model/works.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/processor.rb"
require_relative "factories/work.rb"

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.include FactoryGirl::Syntax::Methods
end
