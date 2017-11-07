class FollowMapping < ApplicationRecord
  validates_uniqueness_of :followee_id, scope: :follower_id

end
