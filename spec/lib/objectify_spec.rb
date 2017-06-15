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

end
