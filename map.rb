require	'data_mapper'

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
    property :title, String
    property :body, Text

    def marker(x, y)
        longitude = y
        latitude = x
    end
end

DataMapper.finalize

Marker.auto_upgrade!