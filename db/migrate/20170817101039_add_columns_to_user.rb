class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sex, :string
    add_column :users, :batchof, :integer
  end
end
