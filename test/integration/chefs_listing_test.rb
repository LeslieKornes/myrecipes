require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Marco", email: "Marco@mkmail.com",
                    password: "Marco414", password_confirmation: "Marco414")
    @chef2 = Chef.create!(chefname: "Dodjie", email: "Dodjie@dtmail.com",
                    password: "Dodjie0706", password_confirmation: "Dodjie0706")
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

end
