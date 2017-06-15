require_relative '../spec_helper'

describe BetweenBrackets do

  context 'between parentheses' do

    it 'extracts between parentheses' do
      test_string = '2(x+3)'
      between_brackets = BetweenBrackets.new('(',')',test_string)
      result = 'x+3'
      expect(between_brackets.extract).to eq result
    end

    it 'extracts between curlys' do
      test_string = '2{x+3}'
      between_brackets = BetweenBrackets.new('{','}',test_string)
      result = 'x+3'
      expect(between_brackets.extract).to eq result
    end

    it 'leaves alone if no matches' do
      test_string = 'x+3'
      between_brackets = BetweenBrackets.new('{','}',test_string)
      result = 'x+3'
      expect(between_brackets.extract).to eq result
    end

    it 'handles nesting' do
      test_string = '(x+(3))'
      between_brackets = BetweenBrackets.new('(',')',test_string)
      result = 'x+(3)'
      expect(between_brackets.extract).to eq result
    end

  end
end
