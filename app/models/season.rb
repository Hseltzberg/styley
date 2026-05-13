# == Schema Information
#
# Table name: seasons
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Season < ApplicationRecord
  has_many  :outfit_seasons, dependent: :destroy
  has_many :outfits, through: :outfit_seasons, source: :outfit
end
