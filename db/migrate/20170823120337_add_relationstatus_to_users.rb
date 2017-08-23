class AddRelationstatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :relationstatus, :string
  end
end
