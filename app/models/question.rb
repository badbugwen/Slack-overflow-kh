class Question < ApplicationRecord
  has_many :solutions
  has_many :upvotes
  has_many :favorites
  belongs_to :user 
end
