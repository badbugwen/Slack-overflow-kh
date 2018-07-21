class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :upvotes
end
