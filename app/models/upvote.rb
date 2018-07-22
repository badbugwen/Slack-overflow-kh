# == Schema Information
#
# Table name: upvotes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  solution_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :question, counter_cache: true
  belongs_to :solution, counter_cache: true
end
