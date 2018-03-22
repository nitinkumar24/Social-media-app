class AddNewNotificationsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :new_notifications, :integer, :default => 0
  end
end
