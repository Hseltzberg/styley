# == Schema Information
#
# Table name: outfit_seasons
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  outfit_id  :integer
#  season_id  :integer
#
class OutfitSeason < ApplicationRecord
  belongs_to :outfit
  belongs_to :season
end
