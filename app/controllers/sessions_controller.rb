class SessionsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by([:session][:email].downcase)
    if chef && chef.authenticate([:session][:password])
      #handle it
    else
      flash.now[:danger] = "There was a problem logging you in."
      render 'new'
    end
  end

  def destroy

  end

end
