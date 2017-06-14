require_relative '../spec_helper'

describe 'Simplifier' do

  describe '#fraction_brackets' do
    it 'simplifies a top level fraction into a dollar sign' do
      simplify = Simplify.new('\frac{a}{b}')
      result = '\frac{$}{$}'
      binding.pry
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
      result = '$'
      expect(simplify.fractions).to eq result
    end
    it 'simplifies entire fraction with nesting' do
      simplify = Simplify.new('\frac{\frac{a}{b}}{a}')
      result = '$'
      expect(simplify.fractions).to eq result
    end
    it 'simplifies non-nested fractions' do
      simplify = Simplify.new('\frac{a}{a}\frac{a}{b}')
      result = '$$'
      expect(simplify.fractions).to eq result
      binding.pry
    end
  end

  describe '#parentheses_content' do
    it 'simplifies the contents of parentheses' do
      simplify = Simplify.new('2(a)b')
      result = '2($)b'
      expect(simplify.parentheses_content).to eq result
    end
    it 'simplifies the contents of parentheses with nesting' do
      simplify = Simplify.new('2(a(a(b)(sx)))b')
      result = '2($)b'
      expect(simplify.parentheses_content).to eq result
    end
  end

  describe '#parentheses' do
    it 'simplifies the entire parentheses' do
      simplify = Simplify.new('2(a)b')
      result = '2$b'
      expect(simplify.parentheses).to eq result

    end

    it 'simplifies multiple parentheses' do
      simplify = Simplify.new('2(a)(b)+1(a)')
      result = '2$$+1$'
      expect(simplify.parentheses).to eq result
    end
  end

  describe 'multiplications' do
    it 'simplifies basic multipliers' do
      simplify = Simplify.new('2ab+3a')
      result = '$+$'
      expect(simplify.multiplications).to eq result
    end

    it 'simplifies the replacement symbol' do
      simplify = Simplify.new('2$a+3$$$a')
      result = '$+$'
      expect(simplify.multiplications).to eq result
    end
  end

  describe '#expression' do
    it 'handles mixed stacks ' do
      simplify = Simplify.new('2\frac{}{}(\frac{a}{b})+1(a)')
      result = '$+$'
      expect(simplify.expression).to eq result
    end

    it 'makes a call to the parentheses function' do

    end
  end
end
