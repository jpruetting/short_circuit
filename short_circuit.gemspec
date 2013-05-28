$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "short_circuit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "short_circuit"
  s.version     = ShortCircuit::VERSION
  s.authors     = ["Jim Pruetting"]
  s.email       = ["jim@roboticmethod.com}"]
  s.homepage    = "http://www.roboticmethod.com"
  s.summary     = "Simple presenters for Rails."
  s.description = "Short Circuit enables simple presenters for Rails views."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency "sqlite3"
end
