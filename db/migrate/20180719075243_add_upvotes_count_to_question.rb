class AddUpvotesCountToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :upvotes_count, :integer, :default => 0

    Question.pluck(:id).each do |i|
      Question.reset_counters(i, :upvotes)
    end
  end
end
