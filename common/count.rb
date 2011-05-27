class Count
  attr_accessor :positive, :negative
  
  def initialize(attributes = {})
    self.positive ||= attributes[:positive] || 0
    self.negative ||= attributes[:negative] || 0
  end
  
  def attributes
    {:positive => positive, :negative => negative}
  end
  
  def total
    positive + negative
  end
  
  def [](counter)
    self.send(counter)
  end
  
  def []=(counter, value)
    self.send("#{counter}=", value)
  end
  
  def +(count)
    Count.new(count.attributes)
  end
end