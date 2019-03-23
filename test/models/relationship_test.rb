# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:lana).id,
                                     followed_id: users(:malory).id)
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
    lana = users(:lana)
    malory = users(:malory)
    assert_not lana.following?(malory)
    lana.follow(malory)
    assert lana.following?(malory)
    assert malory.followers.include?(lana)
    lana.unfollow(malory)
    assert_not lana.following?(malory)
  end

end
