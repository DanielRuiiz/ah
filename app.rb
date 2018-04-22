require "sinatra"
require_relative "authentication.rb"
require_relative "map.rb"
require 'net/http'
require 'geocoder'

get "/" do
	erb :index
end

get "/dashboard" do
	authenticate!
	erb :dashboard
end

get "/leaderboard" do
	erb :leaderboard
end

post "/marker" do
  s = params["Address"]
  c = params["City"]
  st = params["State"]
  def address(street, city, state)
  		return [street, city, state,].compact.join(', ')
	end
  coords = Geocoder.coordinates(address(s,c,st), t={})
  m = Mark.new
  m.longitude = coords[0]#(MultiGeocoder.geocode(location)).lng
  m.latitude = coords[1]#(MultiGeocoder.geocode(location)).lat
  t = params["title"]
  b = params["body"]
  m.title = t
  m.body = b
  m.save
  @markers = Mark.all
  redirect "/map"
end

get "/map" do
	@markers = Mark.all
	erb :map
	
	#markers.each do |x|
	#	return x.longitude
	#	return x.latitude
	#end
end

get "/new" do
	erb :new
end

