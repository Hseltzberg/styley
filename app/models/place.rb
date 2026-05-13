# == Schema Information
#
# Table name: places
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  occasion_id :integer
#  outfit_id   :integer
#
class Place < ApplicationRecord
  belongs_to :outfit
  belongs_to :occasion
end
