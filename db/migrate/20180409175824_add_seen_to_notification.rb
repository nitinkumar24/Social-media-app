class AddSeenToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :seen, :boolean ,:default => false
  end
end
