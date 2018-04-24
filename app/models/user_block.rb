class UserBlock < ApplicationRecord
    validates_uniqueness_of :email
end
