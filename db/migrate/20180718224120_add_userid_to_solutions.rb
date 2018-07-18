class AddUseridToSolutions < ActiveRecord::Migration[5.1]
  def change
    add_column :solutions, :user_id, :integer
  end
end
