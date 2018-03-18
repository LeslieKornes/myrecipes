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

  test "should reject invalid emails" do
    invalid_emails = %w[leslie@example andrew@gmail,com name@gmail]
    invalid_emails.each do |invalid|
      @chef.email = invalid
      assert_not @chef.valid?, "#{invalid.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lowercase before hitting db" do
    mixed_email = "JohN@example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

end
