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

  test "chef email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "chef email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com lesliek@gmail.com andrew@edu.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

end
