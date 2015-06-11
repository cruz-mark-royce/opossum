require 'test_helper'
require 'minitest/pride'

class UserTest < ActiveSupport::TestCase
  test "should require email" do
    user1 = User.new(password: "notapassword")
    user2 = User.new(password: "notapassword", email: "not@email.com")
    refute user1.save
    assert user2.save
  end

  test "should require password with length from 4-20" do
    user0 = User.new(email: "not@email.com")
    user1 = User.new(email: "not@email.com", password: "no")
    user2 = User.new(email: "not@email.com", password: "just_right")
    user3 = User.new(email: "not@email.com", password: "_____too_____long_____")
    refute user0.save
    refute user1.save
    assert user2.save
    refute user3.save
  end
end
