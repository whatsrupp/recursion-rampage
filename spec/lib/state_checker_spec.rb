require_relative '../spec_helper'

class TestClass
  include StateChecker
end
describe 'StateChecker' do

  let (:state_checker) {TestClass.new()}
  describe '#needs_add_simplification?' do
    describe 'no minus symbols' do
      it 'returns true if there are any plusses' do
        expect(state_checker.needs_add_simplification('2+2')).to eq true
      end

      it 'returns false if there is not any plusses' do
        expect(state_checker.needs_add_simplification('22')).to eq false
      end
    end
  end
end
