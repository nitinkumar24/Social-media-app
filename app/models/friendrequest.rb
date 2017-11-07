class Friendrequest < ApplicationRecord

  validates_uniqueness_of :receiver_id, scope: :sender_id

end
