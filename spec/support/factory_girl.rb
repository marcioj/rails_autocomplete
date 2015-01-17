require "factory_girl_rails"

FactoryGirl.definition_file_paths << Rails.root.join('spec/factories')
# factory_girl calls this before spec_helper being loaded, so we need to call again to apply our additional definition_file_path
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
