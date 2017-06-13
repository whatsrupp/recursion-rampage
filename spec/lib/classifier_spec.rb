require_relative '../spec_helper'

class TestClass
  include Classifier
end
describe 'Classifier' do

  let (:classifier) {TestClass.new()}

  it ' \frac{-14a}{2+x}' do
    test_string = '\frac{-14a}{2+x}'
    expect(classifier.classify(test_string)).to eq(:div)
  end
  it '3(x+7)+4' do
    test_string = '3(x+7)+4'
    expect(classifier.classify(test_string)).to eq(:add)
  end
  it '2(x+\frac{3}{y})w' do
    test_string = '2(x+\frac{3}{y})w'
    expect(classifier.classify(test_string)).to eq(:mult)
  end


  describe '#extract_string_from_outer_bracket' do

    it 'returns the string between brackets' do
      test_string = '(2x+3)'
      result =classifier.extract_string_from_outer_bracket(test_string)
      expect(result).to eq ('2x+3')


    end

    it 'returns the string if no brackets' do
      test_string = '322x+3'
      result =classifier.extract_string_from_outer_bracket(test_string)
      expect(result).to eq ('322x+3')
    end

    it 'finds the first bracket' do
      test_string = '32(2x+3)'
      result =classifier.extract_string_from_outer_bracket(test_string)
      expect(result).to eq ('2x+3')
    end

    it 'returns the string between nested brackets' do
      test_string = '32(2(x+3))'
      result =classifier.extract_string_from_outer_bracket(test_string)
      expect(result).to eq ('2(x+3)')

    end
  end
  # it '\frac{21a+3}{\frac{-14a}{2+x}-(b+d)}' do
  #   test_string = '\frac{21a+3}{\frac{-14a}{2+x}-(b+d)}'
  #   expect(classifier.classify(test_string)).to eq(:frac)
  # end
  # it '2(x+\frac{3}{y})w' do
  #   test_string = '2(x+\frac{3}{y})w'
  #   expect(classifier.classify(test_string)).to eq(:mult)
  # end
  # it '2(x+\frac{3}{y})w' do
  #   test_string = '2(x+\frac{3}{y})w'
  #   expect(classifier.classify(test_string)).to eq(:mult)
  # end

end
