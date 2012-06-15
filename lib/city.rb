# This class represent city
# Author: Haribhau Ingale
# Date: Dec 14th,2009

class City
  
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end

  def is_valid?
    @name =~/\A[A-Z]{1}\Z/
  end

end