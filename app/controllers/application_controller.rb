class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  #any method we build here is available to all controllers

  #to make current_chef and logged_in? available in views:
  helper_method :current_chef, :logged_in?

  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    #the !! turns any expression into a T/F
    !!current_chef
  end

  def require_user
    #will restrict actions if no user is logged in
    if !logged_in?
      flash[:danger] = "You must be logged in for that!"
      redirect_to root_path
    end
  end

end
