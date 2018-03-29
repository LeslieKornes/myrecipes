require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "Nino", email: "Nino@nkmail.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Dodjie", email: "Dodjie@dtmail.com",
                    password: "Dodjie0706", password_confirmation: "Dodjie0706")
    @admin = Chef.create!(chefname: "Dodjie1", email: "Dodjie1@dtmail.com",
                    password: "Dodjie0706", password_confirmation: "Dodjie0706",
                    admin: true)
  end

  test "should reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "Nino@nkmail.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "should accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Nino1", email: "nino1@nkmail.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Nino1", @chef.chefname
    assert_match "nino1@nkmail.com", @chef.email
  end

  test "should accept edit attempt by admin user" do
    sign_in_as(@admin, "Dodjie0706")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Nino2", email: "nino2@nkmail.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Nino2", @chef.chefname
    assert_match "nino2@nkmail.com", @chef.email
  end

  test "should redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "Dodjie0706")
    updated_name = "Leslie"
    updated_email = "Leslie@gmail.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Nino", @chef.chefname
    assert_match "nino@nkmail.com", @chef.email
  end

end
