class Relationship < ApplicationRecord
  # follower_idがUserに紐づく
  belongs_to :follower, class_name: "User"
  # followed_idがUserに紐づく
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
