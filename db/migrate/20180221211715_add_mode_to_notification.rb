class AddModeToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :mode, :string
  end
end
