require_relative "../init"

classifier = ARGV.first.try(:gsub, /^\-\-/, "")

begin
  puts "Using Classifier::#{classifier.camelize}"
  require_relative "#{classifier}/#{classifier}"
  "Classifier::#{classifier.camelize}".constantize.new.run
rescue LoadError
  puts "Could not load selected classifier."
end if classifier