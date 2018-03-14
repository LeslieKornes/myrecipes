require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @recipe = Recipe.new(name: "vegetable", description: "Great veggie dish")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end


end
