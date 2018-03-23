require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Nino", email: "Nino@nkmail.com",
                    password: "password", password_confirmation: "password")
  end

  test "should reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "Nino@nkmail.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "should accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Nino1", email: "Nino1@nkmail.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Nino1", @chef.chefname
    assert_match "Nino1@nkmail.com", @chef.email
  end

end
