require "sinatra"
require_relative "authentication.rb"
require "open-uri"
require_relative "user.rb"

#the following urls are included in authentication.rb
# GET /login
# GET /logout
# GET /sign_up

# authenticate! will make sure that the user is signed in, if they are not they will be redirected to the login page
# if the user is signed in, current_user will refer to the signed in user object.
# if they are not signed in, current_user will be nil

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

get "/map" do
	erb :map
end

get "/new" do
	erb :new
end

post '/create' do
	temp = User.new
	temp.email = params["email"]
	temp.password = params["password"]
	temp.affiliation = params["affiliation"]
	temp.save
	erb :submitted
end

post '/go' do
    @lat = params[:lat]
    @lon = params[:lon]
    erb :index

end

def self.set_location (lat,lon)
    if lat.nil?|| lon.nil? #if html5 location isn't passed, revert to this method
      page = "http://freegeoip.net/json/"
      doc = Nokogiri::HTML(open(page, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'))
      loc = /(latitude)(\":)(\d+.\d+)(,\"longitude\":)(-\d+.\d+)/.match(doc.text)
      @lat = loc[3]
      @lon = loc[5]
    else
      @lat = lat
      @lon = lon
    end