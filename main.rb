require "optparse"

require "gosu"

require_relative "camera"
require_relative "rectangle"
require_relative "scene"
require_relative "window"

options = {
  :width => 800,
  :height => 600,
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [-w/--width WIDTH] [-h/--height HEIGHT]"

  opts.on("-w WIDTH", "--width WIDTH", Integer) do |width|
    options[:width] = width
  end

  opts.on("-h HEIGHT", "--height HEIGHT", Integer) do |height|
    options[:height] = height
  end

  opts.on("--help") do
    puts opts
    exit
  end
end.parse!

def create_scene
  rectangle = Rectangle.new(Vector[0, 0], 1, 1, 1)
  rectangle.accelerate(Vector[0.01, 0.01])

  scene = Scene.new
  scene.add_object(rectangle)

  scene
end

def create_camera
  Camera.new(Vector[0, 0], 0.5)
end

w = Window.new(create_scene, create_camera, options[:width], options[:height])
w.show
