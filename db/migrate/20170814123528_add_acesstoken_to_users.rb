class AddAcesstokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :accesstoken, :string
  end
end
