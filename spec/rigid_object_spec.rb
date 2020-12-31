# frozen_string_literal: true

require 'matrix'

require 'rspec'

require 'rigid_object'

# rubocop:disable Metrics/BlockLength

describe 'RigidObject' do
  it 'moves when it has a velocity' do
    rigid_object = RigidObject.new(Vector[-2, -3], 1, Vector[1, 4])

    rigid_object.update!

    expect(rigid_object.center).to eq Vector[-1, 1]
  end

  it 'changes velocity when accelerated by a force' do
    rigid_object = RigidObject.new(Vector[0, 0], 1)

    force = Vector[2, 1]
    rigid_object.accelerate!(force)
    rigid_object.update!

    expect(rigid_object.velocity).to eq Vector[2, 1]
  end

  it 'attracts other objects due to gravity' do
    object1 = RigidObject.new(Vector[0, 0], 1)
    light_object = RigidObject.new(Vector[1, 1], 1)

    object1.send(:attract!, light_object)
    object1.update!

    expect(object1.velocity[0]).to be > 0
    expect(object1.velocity[1]).to be > 0

    # Check that higher mass leads to more attraction force

    object2 = RigidObject.new(Vector[0, 0], 1)
    heavy_object = RigidObject.new(Vector[1, 1], 10)

    object2.send(:attract!, heavy_object)
    object2.update!

    expect(object2.velocity[0]).to be > object1.velocity[0]
    expect(object2.velocity[1]).to be > object1.velocity[1]
  end
end

# rubocop:enable Metrics/BlockLength
