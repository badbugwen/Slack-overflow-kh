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

require 'test_helper'

class UpvoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
