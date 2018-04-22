require	'data_mapper'

if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end


class Mark
	include DataMapper::Resource
	property :id, Serial
	property :longitude, Integer
    property :latitude, Integer
    property :title, Text
    property :body, Text
    property :created_at, DateTime

    #def marker()
      #  longitude = coords.lng
       # latitude = coords.lat
    #end
end
test = Mark.new
test.title = "Yes"
test.body = "I know"
DataMapper.finalize

Mark.auto_upgrade!
