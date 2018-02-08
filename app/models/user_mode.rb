class UserMode < ApplicationRecord
    belongs_to :user
    searchkick
end
