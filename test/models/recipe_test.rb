require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create!(chefname: "Leslie", email: "LeslieKornes@lkmail.com")
    @recipe = @chef.recipes.build(name: "vegetable", description: "Great veggie dish")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "recipe name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description name should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "description shouldn't be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

end