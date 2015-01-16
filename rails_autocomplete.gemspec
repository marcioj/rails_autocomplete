$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_autocomplete/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_autocomplete"
  s.version     = RailsAutocomplete::VERSION
  s.authors     = ["Marcio Junior"]
  s.email       = ["marciojunior_eu@yahoo.com.br"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsAutocomplete."
  s.description = "TODO: Description of RailsAutocomplete."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3"
end
