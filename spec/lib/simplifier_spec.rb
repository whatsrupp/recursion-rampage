require_relative '../spec_helper'

describe 'Simplifier' do

  describe '#fraction_brackets' do
    it 'simplifies a top level fraction into a dollar sign' do
      simplify = Simplify.new('\frac{a}{b}')
      result = '\frac{$}{$}'
      expect(simplify.fraction_brackets).to eq result
    end

    it 'simplifies nested fractions' do
      simplify = Simplify.new('\frac{\frac{a}{b}}{a}')
      result = '\frac{$}{$}'
      expect(simplify.fraction_brackets).to eq result
    end

  end

  describe '#fractions' do
    it 'simplifies entire fraction with no nesting' do
      simplify = Simplify.new('\frac{b}{a}')
      result = "£"
      expect(simplify.fractions).to eq result
    end
    it 'simplifies entire fraction with nesting' do
      simplify = Simplify.new('\frac{\frac{a}{b}}{a}')
      result = "£"
      expect(simplify.fractions).to eq result
    end
    it 'simplifies 1 non-nested fraction' do
      simplify = Simplify.new('\frac{a}{a}\frac{a}{b}')
      result = '£\frac{a}{b}'
      expect(simplify.fractions).to eq result
    end
  end

  describe '#powers' do

  end

  describe '#parentheses_content' do
    it 'simplifies the contents of parentheses' do
      simplify = Simplify.new('2(a)b')
      result = '2$b'
      expect(simplify.parentheses_content).to eq result
    end
    it 'simplifies the contents of parentheses with nesting' do
      simplify = Simplify.new('2(a(a(b)(sx)))b')
      result = '2$b'
      expect(simplify.parentheses_content).to eq result
    end
  end

  describe '#parentheses' do
    it 'simplifies the entire parentheses' do
      simplify = Simplify.new('2(a)b')
      result = '2$b'
      expect(simplify.parentheses).to eq result

    end

    it 'simplifies only 1 parentheses' do
      simplify = Simplify.new('2(a)(b)+1(a)')
      result = '2$(b)+1(a)'
      expect(simplify.parentheses).to eq result
    end

    it 'simplifies one per repetition' do
      simplify = Simplify.new('2(a)(b)+1(a)')
      result = '2$$+1(a)'
      simplify.parentheses
      expect(simplify.parentheses).to eq result
    end
  end

  describe '#expression' do
    it 'handles mixed stacks ' do
      simplify = Simplify.new('2\frac{}{}(\frac{a}{b})+1(a)')
      result = '2£$+1$'
      expect(simplify.expression).to eq result
    end

  end
end
