require "sinatra"
require "geokit"
Geokit::Geocoders::GoogleGeocoder.api_key = "AIzaSyDK3ShvUzUt4s__r6DcZYNxS2jiwgmpK-8"
require_relative "authentication.rb"
require_relative "map.rb"


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
  location = params["Address"]
  #coords = MultiGeocoder.geocode(location)
  m = Marker.new
  m.longitude = 45#(MultiGeocoder.geocode(location)).lng
  m.latitude = 45#(MultiGeocoder.geocode(location)).lat
  m.save
  @markers = Marker.all
  redirect "/map"
end

get "/map" do
	erb :map
	@markers = Marker.all
	#markers.each do |x|
	#	return x.longitude
	#	return x.latitude
	#end
end

get "/new" do
	erb :new
end

