require_relative '../spec_helper'

describe ObjectifyAddition do

  it 'objectifies -2+3' do
    input = '-2+3'
    expected_output = add('-2', '3')
    addition = ObjectifyAddition.new(input)
    expect(addition.objectify).to eq expected_output
  end

  it 'objectifies -24+a' do
    input = '-24+a'
    expected_output = add('-24', 'a')
    expect(ObjectifyAddition.new(input).objectify).to eq expected_output
  end

  it 'objectifies a+b+c+d+355' do
    input = 'a+b+c+d+355'
    expected_output = add('a', 'b', 'c', 'd', '355')
    expect(ObjectifyAddition.new(input).objectify).to eq expected_output
  end

  it 'objectifies -2-25' do
    input = '-2-25'
    expected_output = add('-2', '-25')
    expect(ObjectifyAddition.new(input).objectify).to eq expected_output
  end

end

describe ObjectifyDivision do

end

describe ObjectifyMultiplication do
  it 'objectifies 2x' do
    input = '2x'
    expected_output = mtp('2', 'x')
    expect(ObjectifyMultiplication.new(input).objectify).to eq expected_output
  end

  it 'objectifies -2ay' do
    input = '-2ay'
    expected_output = mtp('-2', 'a', 'y')
    expect(ObjectifyMultiplication.new(input).objectify).to eq expected_output
  end

  it 'objectifies -a' do
    input = '-a'
    expected_output = mtp('-1', 'a')
    expect(ObjectifyMultiplication.new(input).objectify).to eq expected_output
  end

  it 'objectifies uz24j78k9' do
    input = 'uz24j78k9'
    expected_output = mtp('u', 'z', '24', 'j', '78', 'k', '9')
    expect(ObjectifyMultiplication.new(input).objectify).to eq expected_output
  end
end
