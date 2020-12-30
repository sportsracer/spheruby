# frozen_string_literal: true

require 'matrix'

require 'rspec'

require 'circle'

describe 'Circle' do
  it 'collides with close-by circles' do
    circle1 = Circle.new(Vector[0, 0], 1, 0.8 + Float::EPSILON)
    circle2 = Circle.new(Vector[2, 0], 1, 1.2 + Float::EPSILON)

    point, normal = circle1.collision(circle2)

    expect(point[0]).to be_within(Float::EPSILON).of(0.8)
    expect(point[1]).to be_within(Float::EPSILON).of(0.0)
    expect(normal[0]).to be_within(Float::EPSILON).of(1.0)
    expect(normal[1]).to be_within(Float::EPSILON).of(0.0)
  end

  it 'does not collide with faraway circles' do
    circle1 = Circle.new(Vector[0, 0], 1, 1.0)
    circle2 = Circle.new(Vector[20, 20], 1, 1.0)

    coll = circle1.collision(circle2)

    expect(coll).to be_nil
  end
end
