class Tag < ApplicationRecord
  has_and_belongs_to_many :questions
  validates :name, length: { maximum: 10, too_long: "10 characters is the maximum of a hashtag allowed" }
end
