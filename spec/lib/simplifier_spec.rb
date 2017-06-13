require_relative '../spec_helper'

describe 'Simplifier' do

  let (:simplify) {Simplify.new()}
  describe '#fraction_brackets' do
    it 'simplifies a top level fraction into a dollar sign' do
      test_string = '\frac{a}{b}'
      result = '\frac{$}{$}'
      expect(simplify.fraction_brackets(test_string)).to eq result
    end

    it 'simplifies nested fractions' do
      test_string = '\frac{\frac{a}{b}}{a}'
      result = '\frac{$}{$}'
      expect(simplify.fraction_brackets(test_string)).to eq result
    end
  end

  describe '#fraction' do
    it 'simplifies entire fraction with no nesting' do
      test_string = '\frac{b}{a}'
      result = '$'
      expect(simplify.fraction(test_string)).to eq result
    end
    it 'simplifies entire fraction with nesting' do
      test_string = '\frac{\frac{a}{b}}{a}'
      result = '$'
      expect(simplify.fraction(test_string)).to eq result
    end
  end
end
