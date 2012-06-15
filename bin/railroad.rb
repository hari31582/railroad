# This script will find the answers to given queries
# Author: Haribhau Ingale
# Date: 14th Dec, 2009

require File.dirname(__FILE__)+'/../lib/route_map'
require File.dirname(__FILE__)+'/../lib/route'

# Take input in routes variable. Please change the valu if another input to be provided
routes = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7".split(',')


#Create map which will have all routes with it
map = RouteMap.create

routes.each do|route|
    map << Route.new(route.strip)
end

# Print errors and exit program
unless map.errors.chomp.empty?
  map.print_errors
  puts "Pleas change graph inputs"
  exit
end

puts map.find("The distance of the route A-B-C")
puts map.find("The distance of the route A-D")
puts map.find("The distance of the route A-D-C")
puts map.find("The distance of the route A-E-B-C-D")
puts map.find("The distance of the route A-E-D")
puts map.find("The number of trips starting at C and ending at C with a maximum of 3 stops")
puts map.find("The number of trips starting at A and ending at C with exactly 4 stops")
puts map.find("The length of the shortest route from A to C")
puts map.find("The length of the shortest route from B to E")
puts map.find("The length of the shortest route from A to A")
puts map.find("The length of the shortest route from N to Q")
puts map.find("The number of different routes from C to C with a distance of less than 30")



loop do
  puts "Please enter queries like above examples"
  query = gets.chomp
  puts map.find(query)
end



