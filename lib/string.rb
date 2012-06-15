require File.dirname(__FILE__)+'/city'
class String
  def shift!
    first_char = self[0]
    self.replace(self[1..-1])
    first_char.chr
  end

  def to_city
    City.new(self)
  end
end