require "sinatra"
require "geokit"
Geokit::Geocoders::GoogleGeocoder.api_key = "AIzaSyDK3ShvUzUt4s__r6DcZYNxS2jiwgmpK-8"
require_relative "authentication.rb"


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
  m.longitude = (MultiGeocoder.geocode(location)).lng
  m.latitude = (MultiGeocoder.geocode(location)).lat
  m.save
  get '/marker' do
    erb :map
  end
end

get "/map" do
	erb :map
	#@markers = Marker.all
end

get "/new" do
	erb :new
end

