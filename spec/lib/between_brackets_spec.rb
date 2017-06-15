require_relative '../spec_helper'

describe BetweenBrackets do

  context 'between parentheses' do

    it 'extracts between parentheses' do
      between_brackets = BetweenBrackets.new('(',')')
      test_string = '2(x+3)'
      result = 'x+3'
      expect(between_brackets.extract(test_string)).to eq result
    end

    it 'extracts between curlys' do
      between_brackets = BetweenBrackets.new('{','}')
      test_string = '2{x+3}'
      result = 'x+3'
      expect(between_brackets.extract(test_string)).to eq result
    end

  end
end
