require	'data_mapper'
require 'geokit'
include Geokit::Geocoders

if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end


class Marker
	include DataMapper::Resource
	property :id, Serial
	property :longitude, Integer
  property :latitude, Integer
  property :created_at, DateTime

    #def marker()
      #  longitude = coords.lng
       # latitude = coords.lat
    #end
end

DataMapper.finalize

Marker.auto_upgrade!



end