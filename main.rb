# frozen_string_literal: true

require 'optparse'

require 'gosu'

require_relative 'camera'
require_relative 'rectangle'
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
  Gosu::Color.from_hsv(rand(360), rand, 1.0)
end

##
# Give a random nudge to object.
def give_random_acceleration(object)
  force = Vector[rand * 0.02 - 0.01, rand * 0.02 - 0.01]
  object.accelerate(force)
end

##
# Create a random object to be used in our demo scene.
def make_random_object
  center = Vector[rand - 0.5, rand - 0.5]
  mass = rand + 0.5
  width = mass / 2
  color = make_random_color
  object = Rectangle.new(center, mass, width, width, color)
  give_random_acceleration(object)
  object
end

##
# Create a nice demo scene with some random objects.
def create_scene
  scene = Scene.new
  10.times do
    scene.add_object(make_random_object)
  end
  scene
end

def create_camera
  Camera.new(Vector[0, 0], 0.5)
end

w = Window.new(create_scene, create_camera, options[:width], options[:height])
w.show
