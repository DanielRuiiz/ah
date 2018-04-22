require 'data_mapper' # metagem, requires common plugins too.

 #need install dm-sqlite-adapter
 #if on heroku, use Postgres database
 #if not use sqlite3 database I gave you
if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

class User
    include DataMapper::Resource
    property :id, Serial
    property :email, Text
    property :password, String
    property :created_at, DateTime
    property :points, Integer 
    property :username, Text
    property :affiliation, Text
    property :address, Text
    #property :points, Serial
    def login(password)
    	return self.password == password
    end

end
#@users_by_point_count = User.all(:order => [:points.desc])
DataMapper.finalize
User.auto_upgrade!


#class Marker
 #   include DataMapper::Resource
  #  property :id, Serial
   # property :longitude, Integer
  #property :latitude, Integer
  #property :created_at, DateTime

    #def marker()
      #  longitude = coords.lng
       # latitude = coords.lat
    #end
#end

#DataMapper.finalize



# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models


# automatically create the post table

#Marker.auto_upgrade!

