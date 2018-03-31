class IngredientsController < ApplicationController

  def create

  end

  def edit

  end

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def new

  end

  def show

  end

  def update

  end

end
