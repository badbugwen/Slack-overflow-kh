class Tag < ApplicationRecord
  has_and_belongs_to_many :questions
  validates :name, length: { maximum: 10, too_long: "10 characters is the maximum of a hashtag allowed" }
  validates_format_of :name, :with => /\A[\u4e00-\u9fa5a-zA-Z0-9]+\z/ 
end
