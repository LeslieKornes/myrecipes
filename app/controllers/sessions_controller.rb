class SessionsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by([:session][:email].downcase)
    if chef && chef.authenticate([:session][:password])
      session[:chef_id] = chef.id
      flash[:success] = "You have successfully logged in!"
      redirect_to chef
    else
      flash.now[:danger] = "There was a problem logging you in."
      render 'new'
    end
  end

  def destroy

  end

end
