# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Question < ApplicationRecord
  has_many :solutions
  has_many :upvotes, dependent: :destroy
  has_many :upvoted_users, through: :upvotes, source: :user
  has_many :favorites
  belongs_to :user
end
