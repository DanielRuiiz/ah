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


test = User.new
test.affiliation = "teacher"
test.points = 10

DataMapper.finalize
User.auto_upgrade!