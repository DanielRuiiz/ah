require 'sinatra'
require_relative "user.rb"

enable :sessions

get "/login" do
	erb :"authentication/login"
end


post "/process_login" do
	email = params[:email]
	password = params[:password]
	username = params[:username]
	points = params[:points]
	user = User.first(email: email.downcase)

	if(user && user.login(password))
		session[:user_id] = user.id
		session[:user_name] = user.username
		session[:user_points] = user.points
		redirect "/"
	else
		erb :"authentication/invalid_login"
	end
end

get "/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/sign_up" do
	erb :"authentication/sign_up"
end


post "/register" do
	email = params[:email]
	password = params[:password]
	username = params[:username]
	points = 0

	u = User.new
	u.email = email.downcase
	u.password =  password
	u.username = username
	u.points = points
	u.save

	session[:user_id] = u.id
	session[:user_name] = u.username
	session[:user_points] = u.points

	erb :"authentication/successful_signup"

end

#This method will return the user object of the currently signed in user
#Returns nil if not signed in
def current_user
	if(session[:user_id])
		u = User.first(id: session[:user_id], username: session[:user_name], points:session[:user_points])
		return u
	else
		return nil
	end
end

#if the user is not signed in, will redirect to login page
def authenticate!
	if !current_user
		redirect "/login"
	end
end