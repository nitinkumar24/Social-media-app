class Notification < ApplicationRecord
    belongs_to :user

    def self.new_count(recipient_id,mode)
        Notification.where(:recipient_id => recipient_id,mode: mode,seen: false).count
    end
end
