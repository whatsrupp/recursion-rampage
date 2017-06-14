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

  describe '#parentheses_content' do
    it 'simplifies the contents of parentheses' do
      test_string = '2(a)b'
      result = '2($)b'
      expect(simplify.parentheses_content(test_string)).to eq result
    end
    it 'simplifies the contents of parentheses with nesting' do
      test_string = '2(a(a(b)(sx)))b'
      result = '2($)b'
      expect(simplify.parentheses_content(test_string)).to eq result
    end
  end

  describe '#parentheses' do
    it 'simplifies the entire parentheses' do
      test_string = '2(a)b'
      result = '2$b'
      expect(simplify.parentheses(test_string)).to eq result

    end
  end
end
