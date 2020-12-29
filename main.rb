require "optparse"

require "gosu"

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

w = Window.new(options[:width], options[:height])
w.show
