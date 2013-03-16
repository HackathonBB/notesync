class WelcomeController < ApplicationController
  def index
  	@loggedIn = (not not session[:user])
  end
end
