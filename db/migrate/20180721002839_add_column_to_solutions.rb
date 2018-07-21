class AddColumnToSolutions < ActiveRecord::Migration[5.1]
  def change
    add_column :solutions, :user_id, :integer
    remove_column :solutions, :title
  end
end
