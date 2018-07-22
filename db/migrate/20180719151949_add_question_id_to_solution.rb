class AddQuestionIdToSolution < ActiveRecord::Migration[5.1]
  def change
    add_column :solutions ,:question_id, :integer
  end
end
