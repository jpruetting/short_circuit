ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

require_relative '../lib/short_circuit/presentable'
require_relative '../lib/short_circuit/presenter'

class TestModel
  include ShortCircuit::Presentable

  attr_accessor :foo, :bar

  def initialize(foo, bar)  
    self.foo = foo
    self.bar = bar
  end
end

class TestModelPresenter < ShortCircuit::Presenter
  def foo
    @testmodel.foo.titleize
  end
end
