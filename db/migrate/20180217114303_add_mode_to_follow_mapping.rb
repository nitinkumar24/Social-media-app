class AddModeToFollowMapping < ActiveRecord::Migration[5.1]
  def change
    add_column :follow_mappings, :mode, :string
  end
end
