# frozen_string_literal: true

require 'optparse'

require 'gosu'

require_relative 'camera'
require_relative 'circle'
require_relative 'scene'
require_relative 'window'

options = {
  width: 800,
  height: 600
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [-w/--width WIDTH] [-h/--height HEIGHT]"

  opts.on('-w WIDTH', '--width WIDTH', Integer) do |width|
    options[:width] = width
  end

  opts.on('-h HEIGHT', '--height HEIGHT', Integer) do |height|
    options[:height] = height
  end

  opts.on('--help') do
    puts opts
    exit
  end
end.parse!

def make_random_color
  Gosu::Color.from_hsv(rand(360), rand, 0.8)
end

##
# Create a random object to be used in our demo scene.
def make_random_object(angle)
  center = Vector[Gosu.offset_x(angle, 1), Gosu.offset_y(angle, 1)]
  mass = rand + 0.5
  radius = mass / 4
  color = make_random_color
  velocity = center * 0.02 * rand
  Circle.new(center, mass, radius, color, velocity, 0.6)
end

##
# Create a nice demo scene with some random objects.
def create_scene
  scene = Scene.new
  num_objects = 8
  (1..num_objects).each do |i|
    # Compute an angle to space out objects around the center of the screen
    angle = 360 / num_objects * i
    scene.add_object(make_random_object(angle))
  end
  scene
end

def create_camera
  Camera.new(Vector[0, 0], 0.5)
end

w = Window.new(create_scene, create_camera, options[:width], options[:height])
w.show
