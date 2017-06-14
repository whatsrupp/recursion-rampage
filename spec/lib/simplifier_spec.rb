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

  describe '#fractions' do
    it 'simplifies entire fraction with no nesting' do
      test_string = '\frac{b}{a}'
      result = '$'
      expect(simplify.fractions(test_string)).to eq result
    end
    it 'simplifies entire fraction with nesting' do
      test_string = '\frac{\frac{a}{b}}{a}'
      result = '$'
      expect(simplify.fractions(test_string)).to eq result
    end
    it 'simplifies non-nested fractions' do
      test_string = '\frac{a}{a}\frac{a}{b}'
      result = '$$'
      expect(simplify.fractions(test_string)).to eq result
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

    it 'simplifies multiple parentheses' do
      test_string = '2(a)(b)+1(a)'
      result = '2$$+1$'
      expect(simplify.parentheses(test_string)).to eq result
    end
  end

  describe 'multiplications' do
    it 'simplifies basic multipliers' do
      test_string = '2ab+3a'
      result = '$+$'
      expect(simplify.multiplications(test_string)).to eq result
    end

    it 'simplifies the replacement symbol' do
      test_string = '2$a+3$$$a'
      result = '$+$'
      expect(simplify.multiplications(test_string)).to eq result
    end
  end

  describe '#expression' do
    it 'handles mixed stacks ' do
      test_string = '2\frac{}{}(\frac{a}{b})+1(a)'
      result = '$+$'
      expect(simplify.expression(test_string)).to eq result
    end

    it 'makes a call to the parentheses function' do

    end
  end
end
