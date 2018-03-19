require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Nino", email: "Nino@nkmail.com")
    @recipe = Recipe.create(name: "Cookies", description: "Gingerbread Ninjas", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Easter Eggs", description: "Volcano hardboiled eggs")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_response 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @chef.name, response.body
  end

end
