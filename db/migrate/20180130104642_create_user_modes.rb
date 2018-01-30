class CreateUserModes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_modes do |t|
      t.references :user, foreign_key: true
      t.string :mode

      t.timestamps
    end
  end
end
