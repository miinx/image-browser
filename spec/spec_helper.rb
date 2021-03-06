require "factory_girl"

require_relative "../lib/model/work.rb"
require_relative "../lib/model/works.rb"
require_relative "../lib/model/link.rb"
require_relative "../lib/model/page.rb"
require_relative "../lib/model/pages/index_page.rb"
require_relative "../lib/model/pages/camera_make_page.rb"
require_relative "../lib/model/pages/camera_model_page.rb"
require_relative "../lib/work_builder.rb"
require_relative "../lib/processor.rb"
require_relative "factories/work.rb"

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.include FactoryGirl::Syntax::Methods
end
