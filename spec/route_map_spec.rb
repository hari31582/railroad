# Rspec testcases for routemap class
require File.dirname(__FILE__)+'/../lib/route_map'
require File.dirname(__FILE__)+'/../lib/route'
require File.dirname(__FILE__)+'/../lib/city'

describe RouteMap do
  before(:each) do
    @route_map = RouteMap.create
    @routes = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"
    @routes.split(',').each do|route|
      @route_map <<  Route.new(route.strip)
    end
  end

  

  it "should be instance of array" do
      RouteMap.superclass.to_s.should == "Array"
  end

  it "should be the collection of route" do
    @route_map.first.instance_of?(Route).should be_true
    @route_map.size.should == @routes.split(',').size
  end

  it "should show set errors when routes are invalid  " do
    routes = "ABA, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7"
    @route_map=RouteMap.create
    routes.split(',').each do|route|
      @route_map <<  Route.new(route.strip)
    end
    @route_map.errors.should =~/invalid/
  end

  it "should find the distance for given route" do
    @route_map.send(:parse_and_find_distance,"A-B-C-D").should == 17
    @route_map.send(:parse_and_find_distance,"A-B-C").should == 9
    @route_map.send(:parse_and_find_distance,"D-E").should == 6

  end

  it "should give shortest path between two cities" do
   @route_map.send(:find_shortest_distance,"A","C").should == 9
   @route_map.send(:find_shortest_distance,"A","D").should == 5
   @route_map.send(:find_shortest_distance,"B","E").should == 6
  end

  
  it "should find number of trips with maximum 3 stops" do
    @route_map.send(:trip_with_maximum_stops,"C","C",3).size.should == 2
    
  end

  it "should find number of trips exactly 4 stops"  do
      @route_map.send(:trip_with_maximum_stops,"A","C",4,'exactly').size.should == 3
  end

  it "should find number of strips from one city to another city with distance less than given distance" do
    @route_map.send(:trip_with_maximum_stops,"C","C",0,false,30).size.should == 3
  end

  it "should return correct message for find " do
    @route_map.find("The distance of the route A-B-C").should == "The distance of the route A-B-C is 9"
    @route_map.find("The length of the shortest route from A to C").should == "The length of the shortest route from A to C is 9"
  end

  it "should return all adjucent cities for given cities sorted by distance" do
    @route_map.send(:adjucent_cities,"C").size == 2
    @route_map.send(:adjucent_cities,"C").first.should == ["E",2.to_s]
  end

end
