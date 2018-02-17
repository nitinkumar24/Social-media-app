class AddModeToFriendrequest < ActiveRecord::Migration[5.1]
  def change
    add_column :friendrequests, :mode, :string
  end
end
