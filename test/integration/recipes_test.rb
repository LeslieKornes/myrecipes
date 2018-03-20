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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit Recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete Recipe"
    assert_select 'a[href=?]', recipes_path, text: "Return to Recipes"
  end

  test "should create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Pansit"
    description_of_recipe = "Delicious Filipino dish with clear noodles"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "should reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
