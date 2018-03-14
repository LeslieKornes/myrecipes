require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Leslie", email: "Leslie@gmail.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chef name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chef name less than 30 chars" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

end
