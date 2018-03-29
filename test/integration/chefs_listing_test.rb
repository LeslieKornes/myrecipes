require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Marco", email: "Marco@mkmail.com",
                    password: "Marco414", password_confirmation: "Marco414")
    @chef2 = Chef.create!(chefname: "Dodjie", email: "Dodjie@dtmail.com",
                    password: "Dodjie0706", password_confirmation: "Dodjie0706")
    @admin = Chef.create!(chefname: "Dodjie1", email: "Dodjie1@dtmail.com",
                    password: "Dodjie0706", password_confirmation: "Dodjie0706",
                    admin: true)
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@admin, "Dodjie0706")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

  test "should delete all associated recipes of destroyed chef" do
    @chef.save
    @chef.recipes.create!(name: "Testing destroy", description: "Testing destroy action")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end

end
