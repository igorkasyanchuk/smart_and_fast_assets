# == Schema Information
#
# Table name: smart_assets
#
#  id            :integer          not null, primary key
#  url           :string
#  width         :integer
#  height        :integer
#  original_size :integer
#  new_size      :integer
#  image         :string
#  created_at    :datetime
#

require 'test_helper'

class SmartAssetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
