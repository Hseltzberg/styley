# == Schema Information
#
# Table name: vibes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feeling_id :integer
#  outfit_id  :integer
#
class Vibe < ApplicationRecord
  belongs_to :outfit
  belongs_to :feeling
end
