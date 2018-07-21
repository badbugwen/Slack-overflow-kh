# == Schema Information
#
# Table name: solutions
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#

class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :upvotes
end
