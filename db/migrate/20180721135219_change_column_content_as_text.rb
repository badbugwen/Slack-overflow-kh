class ChangeColumnContentAsText < ActiveRecord::Migration[5.1]
  def change
    change_column :questions, :content, :text
    change_column :solutions, :content, :text
  end
end
