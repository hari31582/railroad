# This class will store the routes and give answer to queries
# Author: Haribhau Ingale
# Date: 14th Dec,2009

class RouteMap  < Array

  # store errors
  attr_accessor :errors

  # Initialize errors with \n. this is just fro better priniting on screen
  def initialize
    @errors = "\n"
  end

  def self.create
    new
  end


  def  print_errors
    puts @errors
  end

  alias_method :prev_find , :find
 
  # Check the validation while inserting route into route map
  def <<(route)
    unless route.is_valid_route?
      @errors  += "Route #{route.start_city}-#{route.end_city}#{route.distance} is invalid\n"
    end
    self.push route
  end

  # Find the answer to query

  def find(query)
    begin
      answer = "Unknown Query. We are sorry!! We coludnot answer you"

    case query
    when /^The distance of the route (.+)$/
      distance = parse_and_find_distance($1)
      answer = distance.kind_of?(String) ? distance :  query+' is '+distance.to_s
    when /^The length of the shortest route from ([A-Z]{1}) to ([A-Z]{1})$/
      distance = find_shortest_distance($1,$2)
      answer = distance > 0 ? query+' is '+distance.to_s : "No Such Route"
    when /^The number of trips starting at ([A-Z]{1}) and ending at ([A-Z]{1}) with a maximum of (\d+) stops$/
      trips = trip_with_maximum_stops($1,$2,$3)
      answer = query +' are '+trips.size.to_s+"(#{trips.join(',')})"
    when /^The number of trips starting at ([A-Z]{1}) and ending at ([A-Z]{1}) with exactly (\d+) stops$/
      trips = trip_with_maximum_stops($1,$2,$3,'exactly')
      answer = query +' are '+trips.size.to_s+"(#{trips.join(',')})"
    when /^The number of different routes from ([A-Z]{1}) to ([A-Z]{1}) with a distance of less than (\d+)$/
      trips = trip_with_maximum_stops($1,$2,0,false,$3)
      puts "Here"
      answer = query +' are '+trips.size.to_s+"(#{trips.join(',')})"  
    end
    rescue=>e
      puts "We are sorry due to technical difficulties we can't answer you at present."
    end
    answer.to_s
  end

  private

  # Find distance of given route
  def parse_and_find_distance(full_route)
    cities = full_route.split('-')
    distance=0    
    cities.each_with_index do|city,index|
      if cities[index+1]
        route = prev_find{|route| route.start_city.to_s==city && route.end_city.to_s==cities[index+1]}
        if route
          distance += route.distance.to_i
        else
          return "No Such Route"
        end
      end
    end
    distance==0 ? "No Such Route" : distance
  end

  # Find shortest distance between cities
  def find_shortest_distance(from_city,to_city)

    # store the intermediate cities in Queue
    intermedite_cities = Queue.new

    # Store the start city
    intermedite_cities.push [from_city,0]
    
    minimum_distance =0

    #Find distance till target city reached
    until intermedite_cities.empty?
      #pop up the first element
      city = intermedite_cities.pop

      if city.first == to_city
        minimum_distance = city.last.to_i if (minimum_distance > city.last.to_i)|| minimum_distance==0
        next
      end

      #store adjucent cities in queue
      old_distance = city.last.to_i
      for adjust_city in adjucent_cities(city.first)
        if (minimum_distance > old_distance+adjust_city.last.to_i) || minimum_distance==0
          intermedite_cities.push [adjust_city.first,old_distance+adjust_city.last.to_i]
        end
      end
    end
    minimum_distance
  end

  
  
  def adjucent_cities(from_city)
    cities = select{|route| route if  route.start_city.to_s==from_city }.sort_by{|route| route.distance.to_i}
    cities.map{|route| [route.end_city.to_s,route.distance]}
  end

  # Find trips from one city to another city
  def trip_with_maximum_stops(from_city,to_city,max_stops,has_exact=false,max_distance=0)
    max_stops = max_stops.to_i + 1
    max_distance = max_distance.to_i
    # store the intermediate cities in Queue
    intermedite_cities = Queue.new

    # Store the start city
    intermedite_cities.push [from_city,from_city]

    all_possible_routes = []

    #Find routes
    until intermedite_cities.empty?
      #pop up the first element in queue
      city = intermedite_cities.pop
      if max_distance> 0
        has_maximum_or_equal_stops = parse_and_find_distance(city.last).to_i < max_distance
      else
        has_maximum_or_equal_stops = has_exact ?  (city.last.split('-').size ==max_stops) : (city.last.split('-').size <=max_stops)
      end

      # Add the reached route in array
      if city.first == to_city && has_maximum_or_equal_stops && city.last.split('-').size > 1
        all_possible_routes << city.last
        next
      end

      #store adjucent cities in queue
      old_distance = city.last

      if max_distance > 0
        condition = "parse_and_find_distance(old_distance+'-'+adjust_city.first).to_i < max_distance"
      else
        condition = "(max_stops >= (old_distance+'-'+adjust_city.first).split('-').size)"
      end

      for adjust_city in adjucent_cities(city.first)
           if eval(condition)
             intermedite_cities.push [adjust_city.first,old_distance+'-'+adjust_city.first]
           end
        end
  
    end
    all_possible_routes

  end

  
end