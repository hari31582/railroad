# This class represents route with start and end city
# Author: Haribhau Ingale
# date: 14th Dec,2009

require File.dirname(__FILE__)+'/string'


class Route
  attr_reader :start_city,:end_city,:distance
  def initialize(route)
    @start_city = route.shift!.to_city
    @end_city = route.shift!.to_city
    @distance = route.shift!
  end

  def is_valid_route?    
    @start_city.is_valid? && @end_city.is_valid? && has_valid_distance?
  end

  private

  def has_valid_distance?
    @distance.to_s =~/\d+{1}/
  end


end