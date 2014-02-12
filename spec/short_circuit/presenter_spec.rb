require 'spec_helper'

module ShortCircuit
  describe Presenter do
    let(:presentable_object) do
      mock_model('TestModel', test_method: 'Test Method')
    end

    let(:presenter) { Presenter.new(presentable_object) }

    it 'delegates missing method calls to controller helpers' do
      expect(ApplicationController.helpers).to receive(:fake_method)
      presenter.send(:fake_method)
    end

    it 'delegates missing method calls to url helpers' do
      expect(presenter.url_helpers).to receive(:fake_method)
      presenter.send(:fake_method)
    end

    it 'delegates missing method calls to presentable object' do
      expect(presenter.__getobj__).to receive(:fake_method)
      presenter.send(:fake_method)

      expect(presenter.test_method).to eq(presentable_object.test_method)
    end

    describe '#initialize' do
      it 'sets presentable_object' do
        expect(presenter.__getobj__).to eq(presentable_object)
      end

      it 'set an instance variable for presentable_object' do
        var = "@#{presentable_object.class.to_s.underscore}"
        expect(presenter.instance_variable_get(var)).to eq(presentable_object)
      end
    end

    describe '#url_helpers' do
      subject(:url_helpers) { presenter.url_helpers }

      it 'returns url_helpers' do
        expect(url_helpers).to_not be_nil
        expect(url_helpers).to respond_to(:url_for)
      end
    end

    describe '#error_response' do
      subject(:error_response) { presenter.error_response('error', :method) }

      it 'returns a blank response' do
        expect(error_response).to be_empty
      end
    end
  end
end
