class UserController < ApplicationController
  def create
  	user = User.by_nick.key(params[:user][:nick])
  	if (user.length != 0)
  		render :text => "Username alredy taken"
  		return
  	end
  	user = User.new(params)
  	session[:user] = user;
  	redirect_to welcome_index_path()

  end

  def new

  end

  def logIn
  	user = User.by_nick.key(params[:user][:nick])
  	if !user || user.password == params[:user][:password]
  		render :text => "incorrect username or password"
  	else 
  		session[:user] = user
  		redirect_to welcome_index_path()
  	end
  end
end
