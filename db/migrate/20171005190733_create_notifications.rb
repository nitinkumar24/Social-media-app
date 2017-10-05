class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :recipient_id
      t.string :noti_type
      t.integer :noti_type_id
      t.string :message

      t.timestamps
    end
  end
end
