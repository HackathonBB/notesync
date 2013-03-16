class UserController < ApplicationController
  def create
  	user = User.by_nick.key(params[:user][:nick])
  	if (user.length > 0)
  		flash[:error] = "UserName alredy taken"
  		redirect_to user_new_path()
  		return
  	end
  	user = User.new(params[:user])
  	user.save
  	session[:user] = user.id;
  	redirect_to root_path()

  end

  def new

  end

  def logIn
  	user = User.by_nick.key(params[:user][:nick])
  	if user.length>0 && user.first.password == params[:user][:password]
  		session[:user] = user.first.id
  		redirect_to root_path()
  	else
  		flash[:error] = "incorrect username or password"
  		redirect_to user_new_path() 
  	end
  end

  def logout
  	session[:user] = nil
  	redirect_to root_path()
  end
end
