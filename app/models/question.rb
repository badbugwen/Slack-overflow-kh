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
  has_many :soluted_users, through: :solutions, source: :user
  has_many :upvotes, dependent: :destroy
  has_many :upvoted_users, through: :upvotes, source: :user
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  belongs_to :user

  has_and_belongs_to_many :tags
  validates_associated :tags

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_upvoted?(user)
    self.upvoted_users.include?(user)
  end

  def is_soluted?(user)
    self.soluted_users.include?(user)
  end

end
