module Dissertation
  def self.root
    Pathname.new(File.dirname(__FILE__))
  end
end