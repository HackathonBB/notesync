class ApplicationController < ActionController::Base
  protect_from_forgery


  private

  def require_login

  	if !session[:user]
  		flash[:error] = "You need to be logged in"
  		redirect_to root_path()
  	else
  		@user = User.find(session[:user])
  	end

  end

end
