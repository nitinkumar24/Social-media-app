class AddTypeToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :flavour, :string
  end
end
