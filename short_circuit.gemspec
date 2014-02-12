$:.push File.expand_path('../lib', __FILE__)

require 'short_circuit/version'

Gem::Specification.new do |s|
  s.name        = 'short_circuit'
  s.version     = ShortCircuit::VERSION
  s.authors     = ['Jim Pruetting']
  s.email       = ['jim@roboticmethod.com}']
  s.homepage    = 'https://github.com/jpruetting/short_circuit'
  s.summary     = 'Simple presenters for Rails.'
  s.description = 'Short Circuit adds simple presenters for Rails views.'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.0'
end
