class AddColumnsForCounterCache < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :upvotes_count, :integer, :default => 0
    add_column :questions, :solutions_count, :integer, :default => 0
    add_column :questions, :fevorites_count, :integer, :default => 0
    add_column :solutions, :upvotes_count, :integer, :default => 0
  end
end
