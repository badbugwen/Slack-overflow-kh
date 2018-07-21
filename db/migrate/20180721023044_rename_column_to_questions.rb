class RenameColumnToQuestions < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :fevorites_count, :favorites_count
  end
end
