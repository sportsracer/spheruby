# frozen_string_literal: true

require 'rspec'

require 'vector_reflect'

describe 'Vector' do
  it 'gets reflected across a surface normal' do
    vector = Vector[0.5, 0.5]
    normal = Vector[0, 1]

    reflected = vector.reflect(normal)

    expect(reflected[0]).to be_within(Float::EPSILON).of(0.5)
    expect(reflected[1]).to be_within(Float::EPSILON).of(-0.5)

    expect(vector.magnitude).to be_within(Float::EPSILON).of(reflected.magnitude)
  end

  it 'cannot be reflected by a normal of length zero' do
    vector = Vector[1, 1]
    normal = Vector[0, 0]

    expect do
      vector.reflect(normal)
    end.to raise_error(ArgumentError)
  end
end
