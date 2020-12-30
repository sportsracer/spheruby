# frozen_string_literal: true

require 'matrix'

require 'rspec'

require 'rigid_object'

describe 'RigidObject' do
  it 'moves when it has a velocity' do
    rigid_object = RigidObject.new(Vector[-2, -3], 1, Vector[1, 4])

    rigid_object.update

    expect(rigid_object.center).to eq Vector[-1, 1]
  end

  it 'changes velocity when accelerated by a force' do
    rigid_object = RigidObject.new(Vector[0, 0], 1)

    force = Vector[2, 1]
    rigid_object.accelerate(force)

    expect(rigid_object.velocity).to eq Vector[2, 1]
  end

  it 'attracts other objects due to gravity' do
    light_object = RigidObject.new(Vector[0, 0], 1)
    other_object1 = RigidObject.new(Vector[1, 1], 1)

    light_object.attract(other_object1)

    expect(other_object1.velocity[0]).to be < 0
    expect(other_object1.velocity[1]).to be < 0

    # Check that higher mass leads to more attraction force

    heavy_object = RigidObject.new(Vector[0, 0], 10)
    other_object2 = RigidObject.new(Vector[1, 1], 1)

    heavy_object.attract(other_object2)

    expect(other_object2.velocity[0]).to be < other_object1.velocity[0]
    expect(other_object2.velocity[1]).to be < other_object1.velocity[1]
  end
end
