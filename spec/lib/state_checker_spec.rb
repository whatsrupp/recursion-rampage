require_relative '../spec_helper'

class TestClass
  include StateChecker
end
describe 'StateChecker' do

  let (:state_checker) {TestClass.new()}
  describe '#needs_add_simplification?' do
    describe 'context: no minus symbols' do
      it 'returns true if there are any plusses' do
        expect(state_checker.needs_add_simplification('2+2')).to eq true
      end

      it 'returns false if there is not any plusses' do
        expect(state_checker.needs_add_simplification('22')).to eq false
      end
    end

    describe 'context: minus symbols' do
      it 'returns true when an appropriate minus' do
        expect(state_checker.needs_add_simplification('-22-5')).to eq true
      end

      it 'returns false when appropriate ' do
        expect(state_checker.needs_add_simplification('-22')).to eq false

      end

      it 'false check' do
        test_string = 'mtp(-2, a, y)'
        expect(state_checker.needs_mult_simplification(test_string)).to eq false

      end
    end
  end
  describe '#needs_mult_simplificatino?' do
    it 'true if negative next to a letter' do
      test_string = '-a'
      expect(state_checker.needs_mult_simplification(test_string)).to eq true
    end

    it 'true if letter next to number' do
      test_string = 'a21'
      expect(state_checker.needs_mult_simplification(test_string)).to eq true
    end

    it 'true if number next to letter' do
      test_string = '21a'
      expect(state_checker.needs_mult_simplification(test_string)).to eq true
    end
    it 'false when appropriate' do
      test_string = '-1-3'
      expect(state_checker.needs_mult_simplification(test_string)).to eq false
    end
  end
end
