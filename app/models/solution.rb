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
end
