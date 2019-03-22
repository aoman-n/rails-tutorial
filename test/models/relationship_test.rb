require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:aoba).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    aoba = users(:aoba)
    assert_not michael.following?(aoba)
    michael.follow(aoba)
    assert michael.following?(aoba)
    michael.unfollow(aoba)
    assert_not michael.following?(aoba)
  end

end
