require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Nino", email: "Nino@nkmail.com",
                    password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Cookies", description: "Gingerbread Ninjas", chef: @chef)
  end

  test "should reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: " " } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "should successfully edit a recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    new_name = "new recipe name"
    new_description = "new description"
    patch recipe_path(@recipe), params: { recipe: { name: new_name, description: new_description } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match new_name, @recipe.name
    assert_match new_description, @recipe.description
  end

end
