require 'spec_helper'

module ShortCircuit
  describe Presentable do
    before do
      mock_model('TestModel')
      TestModel.any_instance.stub(:test_method).and_return('Test Method')
      TestModel.send(:include, Presentable)
      stub_const('TestModelPresenter', Presenter)
    end

    let(:model) { TestModel.new }

    describe '#presenter' do
      subject(:presenter) { model.presenter }

      it 'returns the correct presenter' do
        expect(presenter).to be_a(Presenter)
        expect(presenter).to be_a(TestModelPresenter)
      end
    end

    describe '#present' do
      context 'when the method exists' do
        let(:method) { :test_method }

        it 'calls the presenter method' do
          expect(model.presenter).to receive(:send)
          model.present(method)
        end
      end

      context 'when the method does not exist' do
        let(:method) { :fake_method }

        it 'does not throw an error' do
          expect{model.present(method)}.to_not raise_error
        end

        it 'calls the error_response method' do
          expect(model.presenter).to receive(:error_response)
          model.present(method)
        end
      end
    end

    describe '#present!' do
      context 'when the method exists' do
        let(:method) { :test_method }

        it 'calls the presenter method' do
          expect(model.presenter).to receive(:send)
          model.present!(method)
        end
      end

      context 'when the method does not exist' do
        let(:method) { :fake_method }

        it 'throws an error' do
          expect{model.present!(method)}.to raise_error(NoMethodError)
        end
      end
    end
  end
end
