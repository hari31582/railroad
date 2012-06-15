# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.dirname(__FILE__)+'/../lib/route'

describe Route do
  

 def create_route(city_with_distance)
   @route = Route.new(city_with_distance)
 end


  it "should assign start city to start_city attribute" do
    create_route("AB5")
    @route.start_city.to_s.should == "A"
  end

 it "should assign end city to end_city attribute" do
    create_route("AB5")
    @route.end_city.to_s.should == "B"
  end
  
 it "should assign distance to distance attribute" do
    create_route("AB5")
    @route.distance.to_i.should == 5
  end


  it " should have valid distance" do
    create_route("AB5")
    @route.send(:has_valid_distance?).should_not be_nil
  end

  it "should be valid route" do
    create_route("AB5")
    @route.is_valid_route?.should_not be_nil
  end

  it "should return nil or false for invalid route" do
    create_route("ABB")
    @route.is_valid_route?.should be_nil
  end


end

