require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_user = users(:aoba)
  end

  test "home following & followers" do
    log_in_as(@user)
    @user.follow(@other_user)
    @other_user.follow(@user)
    get root_url
    assert_select 'strong#following', text: '1'
    assert_select 'strong#followers', text: '1'
    @user.unfollow(@other_user)
    @other_user.unfollow(@user)
    get root_url
    assert_select 'strong#following', text: '0'
    assert_select 'strong#followers', text: '0'
  end

  test "profile display" do
    @user.follow(@other_user)
    @other_user.follow(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_select 'strong#following', text: '1'
    assert_select 'strong#followers', text: '1'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
