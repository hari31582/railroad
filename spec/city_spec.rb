
# Rspec testcases for city class

require File.dirname(__FILE__)+'/../lib/city'

describe City do
  before(:each) do
  #  @city = City.new
  end

  def new_city(name)
    @city = City.new(name)
  end

  it "should have return 0 for valid name" do
    new_city("A")
    @city.is_valid?.should == 0
  end

  it "should have return false for invalid name" do
   new_city("AK")
    @city.is_valid?.should be_nil
  end

  it "display city name when to_s method called on city" do
     new_city("B")
     @city.to_s.should == "B"
  end

end

