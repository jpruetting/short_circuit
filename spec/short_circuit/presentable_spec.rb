require_relative '../spec_helper'
 
module ShortCircuit
  describe Presentable do
    before :each do
      @model = TestModel.new('foo', 'bar')
    end

    it "should have a presenter" do
      @model.presenter.should be_an_instance_of TestModelPresenter
    end

    it "should present model attributes" do
      @model.present(:foo).should eql 'Foo'
    end

    it "should delegate model attributes" do
      @model.present(:bar).should eql 'bar'
    end

    it "should fail silently by default" do
      expect { @model.present(:not_a_method) }.not_to raise_error NoMethodError
    end

    it "should throw errors when using bang method" do
      expect { @model.present!(:not_a_method) }.to raise_error NoMethodError
    end
  end
end
